#pragma once

#include "ActorData.h"
#include "EscapeGame.h"

#include "Util/Singleton.h"

namespace BDSM {
    class EscapeGameTable : public Util::Singleton<EscapeGameTable> {
    public:
        void setup();

        void tryEscape(ActorData* data, GameAPI::GameArmor restraint);

    private:
        std::vector<EscapeGame> escapeGames;
    };
}