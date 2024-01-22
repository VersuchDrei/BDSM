#pragma once

#include "GameAPI/GameArmor.h"

namespace BDSM {
    struct RestraintData {
    public:
        GameAPI::GameArmor restraint;
        GameAPI::GameArmor original;
        std::unordered_map<std::string, float> cooldowns;
        std::vector<RestraintData> combinations;

        inline RestraintData(GameAPI::GameArmor restraint) : restraint{restraint} {}
        RestraintData(GameAPI::GameSerializationInterface serial);

        void serialize(GameAPI::GameSerializationInterface serial);
    };
}