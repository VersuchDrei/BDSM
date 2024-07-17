#pragma once

#include "RestraintData.h"

#include "GameAPI/GameActor.h"
#include "GameAPI/GameArmor.h"

namespace BDSM {
    struct ActorData {
    public:
        ActorData(GameAPI::GameActor actor);
        ActorData(GameAPI::GameSerializationInterface serial);

        void serialize(GameAPI::GameSerializationInterface serial);
        inline bool isValid() { return actor; }

        inline GameAPI::GameActor getActor() { return actor; }

        bool canEquip(GameAPI::GameArmor armor);
        
        bool lock(GameAPI::GameArmor armor);
        bool unlock(GameAPI::GameArmor armor);

        bool isLocked(GameAPI::GameArmor armor);
        inline bool isLocked(GameAPI::GameSlotMask slot) { return lockedSlots.overlaps(slot); }
        inline bool isCovered(GameAPI::GameSlotMask slot) { return coveredSlots.overlaps(slot); }

        bool isGameOnCooldown(std::string game, GameAPI::GameArmor restraint);
        void setGameCooldown(std::string game, GameAPI::GameArmor restraint, float cooldown);

    private:
        void lock(RestraintData dara);

        GameAPI::GameActor actor;
        std::unordered_map<RecordID, RestraintData> restraints;
        GameAPI::GameSlotMask lockedSlots;
        GameAPI::GameSlotMask coveredSlots;
    };
}