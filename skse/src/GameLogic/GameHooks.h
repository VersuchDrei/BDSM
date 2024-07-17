#pragma once

#include "GameUtil.h"

#include "GameAPI/GameEventSources.h"

namespace GameLogic {
    void installHooksPost();

    struct Load3D {
        static RE::NiAVObject* thunk(RE::Character* a_this, bool a_arg1) {
            const auto root = func(a_this, a_arg1);
            GameAPI::GameActor actor = a_this;
            GameAPI::GameEventSources::loadActorEventSource.sendEvent(actor);
            return root;
        }

        static inline REL::Relocation<decltype(thunk)> func;

        static inline constexpr std::size_t idx = 0x6A;

        static inline void Install() {
            REL::Relocation<std::uintptr_t> vtbl{RE::Character::VTABLE[0]};
            func = vtbl.write_vfunc(idx, thunk);
        }
    };

    struct EquipItem {
        static void thunk(RE::ActorEquipManager* manager, RE::Actor* actor, RE::TESBoundObject* object, const RE::ObjectEquipParams& params) {
            switch (object->GetFormType()) {
                case RE::AlchemyItem::FORMTYPE: {
                    GameAPI::GameActorEvent evt{actor};
                    GameAPI::GameEventSources::consumeEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::IngredientItem::FORMTYPE: {
                    GameAPI::GameActorEvent evt{actor};
                    GameAPI::GameEventSources::consumeEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::TESObjectBOOK::FORMTYPE: {
                    // this doesn't work, even with the event cancelled the book is still opened
                    /*
                    GameAPI::GameActorInteractEvent<GameText> evt{actor, object->As<RE::TESObjectBOOK>()};
                    GameAPI::GameEventSources::readTextEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                    */
                } break;
                case RE::TESObjectARMO::FORMTYPE: {
                    RE::TESObjectARMO* armor = object->As<RE::TESObjectARMO>();
                    if (armor->GetSlotMask() != RE::BIPED_MODEL::BipedObjectSlot::kNone) {
                        GameAPI::GameActorEquipEvent<GameAPI::GameArmor> evt{actor, armor, GameUtil::isInventoryOpen()};
                        GameAPI::GameEventSources::equipArmorEventSource.sendEvent(evt);
                        if (evt.isCancelled()) {
                            return;
                        }
                    }
                } break;
                case RE::TESObjectWEAP::FORMTYPE: {
                    GameAPI::GameActorEquipEvent<GameAPI::GameWeapon> evt{actor, object->As<RE::TESObjectWEAP>(), GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::equipWeaponEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::ScrollItem::FORMTYPE: {
                    GameAPI::GameActorEquipEvent<GameAPI::GameScroll> evt{actor, object->As<RE::ScrollItem>(), GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::equipScrollEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::TESShout::FORMTYPE: {
                    GameAPI::GameActorEquipEvent<GameAPI::GameShout> evt{actor, object->As<RE::TESShout>(), GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::equipShoutEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
            }

            return func(manager, actor, object, params);
        }

        static inline REL::Relocation<decltype(thunk)> func;

        static inline void Install() {
            std::array targets{
                std::make_pair(RELOCATION_ID(37938, 38894), REL::VariantOffset(0xE5, 0x170, 0xE5)),  // ActorEquipManager::EquipObject
                std::make_pair(RELOCATION_ID(37937, 38893), REL::VariantOffset(0xBC, 0xBC, 0xBC)),   // ActorEquipManager::EquipImpl?
            };

            for (const auto& [id, offset] : targets) {
                REL::Relocation<std::uintptr_t> target{id, offset};
                auto& trampoline = SKSE::GetTrampoline();
                SKSE::AllocTrampoline(14);

                func = trampoline.write_call<5>(target.address(), thunk);
            }
        }
    };

    struct UnequipItem {
        static void thunk(RE::ActorEquipManager* manager, RE::Actor* actor, RE::TESBoundObject* object, const RE::ObjectEquipParams& params) {
            if (object->Is(RE::TESObjectARMO::FORMTYPE)) {
                RE::TESObjectARMO* armor = object->As<RE::TESObjectARMO>();
                if (armor->GetSlotMask() != RE::BIPED_MODEL::BipedObjectSlot::kNone) {
                    GameAPI::GameActorEquipEvent<GameAPI::GameArmor> evt{actor, armor, GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::unequipArmorEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                }
            }
            return func(manager, actor, object, params);
        }

        static inline REL::Relocation<decltype(thunk)> func;

        static inline void Install() {
            REL::Relocation<std::uintptr_t> target{RELOCATION_ID(37945, 38901), REL::VariantOffset(0x138, 0x1B9, 0x138)};
            auto& trampoline = SKSE::GetTrampoline();
            SKSE::AllocTrampoline(14);

            func = trampoline.write_call<5>(target.address(), thunk);
        }
    };

    struct EquipSpell {
        static void thunk(RE::ActorEquipManager* manager, RE::Actor* actor, RE::TESBoundObject* spell, RE::BGSEquipSlot* slot) {
            switch (spell->GetFormType()) {
                case RE::SpellItem::FORMTYPE: {
                    GameAPI::GameActorEquipEvent<GameAPI::GameSpell> evt{actor, spell->As<RE::SpellItem>(), GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::equipSpellEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
            }

            return func(manager, actor, spell, slot);
        }

        static inline REL::Relocation<decltype(thunk)> func;

        static inline void Install() {
            std::array targets{
                std::make_pair(RELOCATION_ID(37939, 38895), REL::VariantOffset(0x47, 0x47, 0x47)),
                std::make_pair(RELOCATION_ID(37950, 38906), REL::VariantOffset(0xC5, 0xCA, 0xC5)),
                std::make_pair(RELOCATION_ID(37952, 38908), REL::VariantOffset(0xD7, 0xD7, 0xD7))
            };

            for (const auto& [id, offset] : targets) {
                REL::Relocation<std::uintptr_t> target{id, offset};
                auto& trampoline = SKSE::GetTrampoline();
                SKSE::AllocTrampoline(14);

                func = trampoline.write_call<5>(target.address(), thunk);
            }
        }
    };

    struct EquipShout {
        static void thunk(RE::ActorEquipManager* manager, RE::Actor* actor, RE::TESBoundObject* shout, RE::BGSEquipSlot* slot) {
            switch (shout->GetFormType()) {
                case RE::TESShout::FORMTYPE: {
                    GameAPI::GameActorEquipEvent<GameAPI::GameShout> evt{actor, shout->As<RE::TESShout>(), GameUtil::isInventoryOpen()};
                    GameAPI::GameEventSources::equipShoutEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
            }

            return func(manager, actor, shout, slot);
        }

        static inline REL::Relocation<decltype(thunk)> func;

        static inline void Install() {
            std::array targets{
                std::make_pair(RELOCATION_ID(37941, 38897), REL::VariantOffset(0x21, 0x21, 0x21)),
                std::make_pair(RELOCATION_ID(37953, 38909), REL::VariantOffset(0x4B, 0x4B, 0x4B))
            };

            for (const auto& [id, offset] : targets) {
                REL::Relocation<std::uintptr_t> target{id, offset};
                auto& trampoline = SKSE::GetTrampoline();
                SKSE::AllocTrampoline(14);

                func = trampoline.write_call<5>(target.address(), thunk);
            }
        }
    };
}