#pragma once

#include "GameAPI/Events/GameActorInteractEvent.h"
#include "GameAPI/Events/GameActorEquipEvent.h"
#include "GameArmor.h"
#include "GameEventSource.h"
#include "GameScroll.h"
#include "GameShout.h"
#include "GameSpell.h"
#include "GameText.h"
#include "GameWeapon.h"

namespace GameAPI {
    struct GameEventSources {
    public:
        inline static GameEventSource<GameActorEvent> loadActorEventSource;
        inline static GameEventSource<GameActorEvent> consumeEventSource;
        inline static GameEventSource<GameActorInteractEvent<GameText>> readTextEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameArmor>> equipArmorEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameArmor>> unequipArmorEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameWeapon>> equipWeaponEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameSpell>> equipSpellEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameScroll>> equipScrollEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameShout>> equipShoutEventSource;
    };
}