#include "EscapeGameScript.h"

#include "BDSM/ActorTable.h"

namespace ScriptAPI {
    namespace EscapeGame {
        void escapeGameSuccess(GameAPI::GameActor target, GameAPI::GameArmor restraint) {
            BDSM::ActorData* data = BDSM::ActorTable::getActorData(target, false);
            if (!data) {
                return;
            }

            data->unlock(restraint);
        }
    }
}