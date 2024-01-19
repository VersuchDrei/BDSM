#pragma once

#include "GameAPI/GameArmor.h"

namespace BDSM {
    struct RestraintData {
    public:
        GameAPI::GameArmor restraint;
        std::unordered_map<std::string, float> cooldowns;
        GameAPI::GameArmor original;
        std::vector<RestraintData> combinations;
    };
}