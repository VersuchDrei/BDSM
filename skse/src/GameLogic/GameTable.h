#pragma once

#include "Util/Singleton.h"

namespace GameLogic {
    struct GameTable : public Util::Singleton<GameTable> {
    public:
        void setup();

        inline RE::TESGlobal* getGameDaysPassed() { return GameDaysPassed; }
    private:
        RE::TESGlobal* GameDaysPassed = nullptr;
    };
}