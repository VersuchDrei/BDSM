#pragma once

#include "GameAPI/Events/GameActorEquipEvent.h"
#include "GameAPI/Events/GameActorInteractEvent.h"
#include "GameAPI/GameArmor.h"
#include "GameAPI/GameScroll.h"
#include "GameAPI/GameShout.h"
#include "GameAPI/GameSpell.h"
#include "GameAPI/GameText.h"
#include "GameAPI/GameWeapon.h"

namespace Events {
    class EventListener {
    public:
        static void setup();

    private:
        static void onActorLoad(GameAPI::GameActorEvent& evt);
        static void onConsume(GameAPI::GameActorEvent& evt);
        static void onRead(GameAPI::GameActorInteractEvent<GameAPI::GameText>& evt);
        static void onEquip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt);
        static void onUnequip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt);
        static void onEquipWeapon(GameAPI::GameActorEquipEvent<GameAPI::GameWeapon>& evt);
        static void onEquipSpell(GameAPI::GameActorEquipEvent<GameAPI::GameSpell>& evt);
        static void onEquipScroll(GameAPI::GameActorEquipEvent<GameAPI::GameScroll>& evt);
        static void onEquipShout(GameAPI::GameActorEquipEvent<GameAPI::GameShout>& evt);
    };
}