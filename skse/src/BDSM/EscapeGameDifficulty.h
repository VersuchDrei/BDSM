#pragma once

#include "GameAPI/GameCondition.h"
#include "GameAPI/GameKeyword.h"

namespace BDSM {
    struct EscapeGameDifficulty {
        int index = -1;
        GameAPI::GameKeyword keyword;
        GameAPI::GameCondition condition;
    };
}