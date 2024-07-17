#pragma once

#include "GameAPI/GameArmor.h"
#include "GameAPI/GameItem.h"

namespace BDSM {
    struct RestraintData {
    public:
        GameAPI::GameArmor restraint;
        GameAPI::GameItem original;
        std::unordered_map<std::string, float> cooldowns;
        std::vector<RestraintData> combinations;

        inline RestraintData(GameAPI::GameArmor restraint) : restraint{restraint} {}
        RestraintData(GameAPI::GameSerializationInterface serial);

        void serialize(GameAPI::GameSerializationInterface serial);

        bool isGameOnCooldown(std::string game);
        void setGameCooldown(std::string game, float cooldown);
    };
}