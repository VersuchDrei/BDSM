#pragma once

#include "GameEventSources.h"

namespace GameAPI {
    void installHooksPost();

    struct EquipItem {
        static void thunk(RE::ActorEquipManager* manager, RE::Actor* actor, RE::TESBoundObject* object, const RE::ObjectEquipParams& params) {
            switch (object->GetFormType()) {
                case RE::AlchemyItem::FORMTYPE: {
                    GameActorEvent evt{actor};
                    GameEventSources::consumeEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::IngredientItem::FORMTYPE: {
                    GameActorEvent evt{actor};
                    GameEventSources::consumeEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::TESObjectARMO::FORMTYPE: {
                    GameActorEquipEvent<GameArmor> evt{actor, object->As<RE::TESObjectARMO>()};
                    GameEventSources::equipArmorEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::TESObjectWEAP::FORMTYPE: {
                    GameActorEquipEvent<GameWeapon> evt{actor, object->As<RE::TESObjectWEAP>()};
                    GameEventSources::equipWeaponEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::SpellItem::FORMTYPE: {
                    GameActorEquipEvent<GameSpell> evt{actor, object->As<RE::SpellItem>()};
                    GameEventSources::equipSpellEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::ScrollItem::FORMTYPE: {
                    GameActorEquipEvent<GameScroll> evt{actor, object->As<RE::ScrollItem>()};
                    GameEventSources::equipScrollEventSource.sendEvent(evt);
                    if (evt.isCancelled()) {
                        return;
                    }
                } break;
                case RE::TESShout::FORMTYPE: {
                    GameActorEquipEvent<GameShout> evt{actor, object->As<RE::TESShout>()};
                    GameEventSources::equipShoutEventSource.sendEvent(evt);
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
                GameActorEquipEvent<GameArmor> evt{actor, object->As<RE::TESObjectARMO>()};
                GameEventSources::unequipArmorEventSource.sendEvent(evt);
                if (evt.isCancelled()) {
                    return;
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
}