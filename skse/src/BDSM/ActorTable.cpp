#include "ActorTable.h"

namespace BDSM {
    ActorData* ActorTable::getActorData(GameAPI::GameActor actor, bool createIfNotExists) {
        if (createIfNotExists) {
            return &actors.insert({actor.getRecordID(), {actor}}).first->second;
        } else {
            auto iter = actors.find(actor.getRecordID());
            if (iter != actors.end()) {
                return &iter->second;
            }
        
            return nullptr;
        }
    }
}