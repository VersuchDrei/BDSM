#include "GameActor.h"

#include "GameHooks.h"

namespace GameAPI {
    void GameActor::equip(GameArmor armor) const {
        EquipItem(nullptr, 0, form, armor.form, false, true);
    }

    void GameActor::unequip(GameArmor armor) const {
        UnequipItem(nullptr, 0, form, armor.form, false, true);
    }

    
    void GameActor::unequipWeapons() const {
        RE::TESForm* right = form->GetEquippedObject(false);
        if (right && right->Is(RE::TESObjectARMO::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, right, false, true);
        }
        RE::TESForm* left = form->GetEquippedObject(true);
        if (left && left->Is(RE::TESObjectARMO::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, left, false, true);
        }
    }

    void GameActor::unequipSpells() const {
        RE::TESForm* right = form->GetEquippedObject(false);
        if (right && right->Is(RE::SpellItem::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, right, false, true);
        }
        RE::TESForm* left = form->GetEquippedObject(true);
        if (left && left->Is(RE::SpellItem::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, left, false, true);
        }
    }

    void GameActor::unequipScrolls() const {
        RE::TESForm* right = form->GetEquippedObject(false);
        if (right && right->Is(RE::ScrollItem::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, right, false, true);
        }
        RE::TESForm* left = form->GetEquippedObject(true);
        if (left && left->Is(RE::ScrollItem::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, left, false, true);
        }
    }

    void GameActor::unequipShouts() const {
        RE::TESForm* power = form->GetActorRuntimeData().selectedPower;
        if (power && power->Is(RE::TESShout::FORMTYPE)) {
            UnequipItem(nullptr, 0, form, power, false, true);
        }
    }


    void GameActor::refreshInventory() const {
        // there is a bug when unequipping items via code while the inventory is open
        // so we close and immediately open the inventory again to refresh it
        RE::UI* ui = RE::UI::GetSingleton();
        if (ui->IsMenuOpen("InventoryMenu")) {
            RE::IMenu* menu = ui->GetMenu("InventoryMenu").get();
            RE::GFxValue global;
            menu->uiMovie->GetVariable(&global, "_global");
            RE::GFxValue skse;
            global.GetMember("skse", &skse);
            const RE::GFxValue val{"InventoryMenu"};
            skse.Invoke("CloseMenu", nullptr, &val, 1);
            skse.Invoke("OpenMenu", nullptr, &val, 1);

            // TODO queue ninode update?
        } else if (ui->IsMenuOpen("ContainerMenu")) {
            RE::ContainerMenu* menu = ui->GetMenu<RE::ContainerMenu>("ContainerMenu").get();
            if (menu->GetContainerMode() != RE::ContainerMenu::ContainerMode::kNPCMode || form->IsPlayerRef()) {
                RE::IMenu* menu = ui->GetMenu("ContainerMenu").get();
                RE::GFxValue global;
                menu->uiMovie->GetVariable(&global, "_global");
                RE::GFxValue skse;
                global.GetMember("skse", &skse);
                const RE::GFxValue val{"ContainerMenu"};
                skse.Invoke("CloseMenu", nullptr, &val, 1);
            } else {
                RE::IMenu* menu = ui->GetMenu("ContainerMenu").get();
                RE::GFxValue global;
                menu->uiMovie->GetVariable(&global, "_global");
                RE::GFxValue skse;
                global.GetMember("skse", &skse);
                const RE::GFxValue val{"ContainerMenu"};
                skse.Invoke("CloseMenu", nullptr, &val, 1);
                
                std::thread thread([this]{
                    std::this_thread::sleep_for(std::chrono::microseconds(100));
                    SKSE::GetTaskInterface()->AddTask([this] {
                        OpenInventory(form, 3);
                    });
                });
                thread.detach();
            }
        }
    }
}