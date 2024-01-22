#pragma once

#include "ActorData.h"

#include "GameAPI/GameSerializationInterface.h"

namespace BDSM {
    struct ActorTable {
    public:
        static ActorData* getActorData(GameAPI::GameActor actor, bool createIfNotExists);

        static void serialize(GameAPI::GameSerializationInterface serial);
        static void deserialize(GameAPI::GameSerializationInterface serial);
        static void revert(GameAPI::GameSerializationInterface serial);

    private:
        static inline std::unordered_map<RecordID, ActorData> actors;
    };
}