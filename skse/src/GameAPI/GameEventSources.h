#pragma once

#include "GameAPI/Events/GameActorEquipEvent.h"
#include "GameArmor.h"
#include "GameEventSource.h"
#include "GameShout.h"
#include "GameSpell.h"
#include "GameWeapon.h"

namespace GameAPI {
    struct GameEventSources {
    public:
        inline static GameEventSource<GameActorEquipEvent<GameArmor>> equipArmorEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameArmor>> unequipArmorEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameShout>> equipShoutEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameSpell>> equipSpellEventSource;
        inline static GameEventSource<GameActorEquipEvent<GameWeapon>> equipWeaponEventSource;
    };
}