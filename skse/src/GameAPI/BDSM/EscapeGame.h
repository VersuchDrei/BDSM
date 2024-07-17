#pragma once

#include "../GameActor.h"
#include "../GameArmor.h"
#include "../GameScriptInstance.h"

namespace GameAPI {
    namespace BDSM {
        struct EscapeGame : public GameScriptInstance {
            inline EscapeGame() : GameScriptInstance() {}
            inline EscapeGame(RE::TESQuest* quest) : GameScriptInstance(quest) {}

            void startEscapeGame(int difficulty, GameActor target, GameArmor restraint);
        };
    }
}