#pragma once

#include "GameAPI/Events/GameActorEquipEvent.h"
#include "GameAPI/GameArmor.h"
#include "GameAPI/GameShout.h"
#include "GameAPI/GameSpell.h"
#include "GameAPI/GameWeapon.h"

namespace Events {
    class EventListener {
    public:
        static void setup();

        static void onEquip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt);
        static void onUnequip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt);
        static void onEquipShout(GameAPI::GameActorEquipEvent<GameAPI::GameShout>& evt);
        static void onEquipSpell(GameAPI::GameActorEquipEvent<GameAPI::GameSpell>& evt);
        static void onEquipWeapon(GameAPI::GameActorEquipEvent<GameAPI::GameWeapon>& evt);
    };
}