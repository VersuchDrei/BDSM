#pragma once

#include "ActorData.h"

namespace BDSM {
    struct ActorTable {
    public:
        static ActorData* getActorData(GameAPI::GameActor actor, bool createIfNotExists);

    private:
        static inline std::unordered_map<RecordID, ActorData> actors;
    };
}