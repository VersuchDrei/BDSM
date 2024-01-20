#pragma once

#include "GameArmor.h"
#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameActor : public GameRecord<RE::Actor> {
    public:
        inline static GameActor getPlayer() { return RE::PlayerCharacter::GetSingleton(); }

        inline GameActor() {}
        inline GameActor(RE::Actor* actor) { form = actor; }

        inline bool isPlayer() const { return form->IsPlayerRef(); }
        inline std::string getName() const { return form->GetDisplayFullName(); }

        inline int getItemCount(GameArmor armor) const { return GetItemCount(nullptr, 0, form, armor.form); }
        inline void addItem(GameArmor armor, int count) const { form->GetContainer()->AddObjectToContainer(armor.form, count, nullptr); }
        inline void removeItem(GameArmor armor, int count) const { form->GetContainer()->RemoveObjectFromContainer(armor.form, count); }

        inline bool isEquipped(GameArmor armor) const { return IsEquipped(nullptr, 0, form, armor.form); }
        void equip(GameArmor armor) const;
        void unequip(GameArmor armor) const;

        void unequipWeapons() const;
        void unequipSpells() const;
        void unequipScrolls() const;
        void unequipShouts() const;

        void refreshInventory() const;

        inline bool hasKeyword(GameKeyword keyword) const { return form->HasKeyword(keyword.form); }
        inline bool hasKeyword(std::string keyword) const { return form->HasKeywordString(keyword); }
        inline bool wornItemHasKeyword(GameKeyword keyword) const { return WornHasKeyword(nullptr, 0, form, keyword.form); }

    private:
        inline static void EquipItem(RE::BSScript::IVirtualMachine* vm, RE::VMStackID stackID, RE::Actor* actor, RE::TESForm* akItem, bool abPreventRemoval, bool abSilent) {
            using func_t = decltype(EquipItem);
            REL::Relocation<func_t> func{RELOCATION_ID(53861, 54661)};
            func(vm, stackID, actor, akItem, abPreventRemoval, abSilent);
        }

        inline static void UnequipItem(RE::BSScript::IVirtualMachine* vm, RE::VMStackID stackID, RE::Actor* actor, RE::TESForm* akItem, bool abPreventEquip, bool abSilent) {
            using func_t = decltype(UnequipItem);
            REL::Relocation<func_t> func{RELOCATION_ID(53950, 54774)};
            func(vm, stackID, actor, akItem, abPreventEquip, abSilent);
        }

        inline static bool IsEquipped(RE::BSScript::IVirtualMachine* vm, RE::VMStackID stackID, RE::Actor* actor, RE::TESForm* akItem) {
            using func_t = decltype(IsEquipped);
            REL::Relocation<func_t> func{RELOCATION_ID(53895, 54707)};
            return func(vm, stackID, actor, akItem);
        }

        inline static bool WornHasKeyword(RE::BSScript::IVirtualMachine* vm, RE::VMStackID stackID, RE::Actor* actor, RE::BGSKeyword* akKeyword) {
            using func_t = decltype(WornHasKeyword);
            REL::Relocation<func_t> func{RELOCATION_ID(53953, 54777)};
            return func(vm, stackID, actor, akKeyword);
        }

        inline static int GetItemCount(RE::BSScript::IVirtualMachine* vm, RE::VMStackID stackID, RE::TESObjectREFR* object, RE::TESForm* akItem) {
            using func_t = decltype(GetItemCount);
            REL::Relocation<func_t> func{RELOCATION_ID(55644, 56173)};
            return func(vm, stackID, object, akItem);
        }

        inline static void OpenInventory(RE::TESObjectREFR* object, int iArg) {
            using func_t = decltype(OpenInventory);
            REL::Relocation<func_t> func{RELOCATION_ID(50211, 51140)};
            func(object, iArg);
        }
    };
}  // namespace GameAPI