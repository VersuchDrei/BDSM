#include "EscapeGame.h"

namespace BDSM {
    bool EscapeGame::canEscape(GameAPI::GameActor target, GameAPI::GameArmor restraint) {
        for (int i = difficulties.size() - 1; i >= 0; i--) {
            if (restraint.hasKeyword(difficulties[i].keyword)) {
                return !difficulties[i].condition || difficulties[i].condition.fulfills(target);
            }
        }

        return false;
    }

    void EscapeGame::tryEscape(GameAPI::GameActor target, GameAPI::GameArmor restraint) {
        for (int i = difficulties.size() - 1; i >= 0; i--) {
            if (restraint.hasKeyword(difficulties[i].keyword)) {
                game.startEscapeGame(difficulties[i].index, target, restraint);
            }
        }
    }
}