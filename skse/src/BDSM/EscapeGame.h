#pragma once

#include "EscapeGameDifficulty.h"

#include "GameAPI/BDSM/EscapeGame.h"

namespace BDSM {
    struct EscapeGame {
        int priority = 0;
        std::string displayName = "";
        GameAPI::BDSM::EscapeGame game;
        std::vector<EscapeGameDifficulty> difficulties;

        bool canEscape(GameAPI::GameActor target, GameAPI::GameArmor restraint);
        void tryEscape(GameAPI::GameActor target, GameAPI::GameArmor restraint);
    };
}