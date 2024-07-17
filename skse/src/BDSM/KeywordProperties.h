#pragma once

#include "GameAPI/GameSlotMask.h"

namespace BDSM {
    struct KeywordProperties {
        std::vector<std::string> inherits;
        GameAPI::GameSlotMask coveredSlots;
    };
}