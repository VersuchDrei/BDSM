#include "ActorTable.h"

namespace BDSM {
    ActorData* ActorTable::getActorData(GameAPI::GameActor actor, bool createIfNotExists) {
        auto iter = actors.find(actor.getRecordID());
        if (iter != actors.end()) {
            return &iter->second;
        } else if (createIfNotExists) {
            return &actors.insert({actor.getRecordID(), {actor}}).first->second;
        }

        return nullptr;
    }

    void ActorTable::clearRecord(RecordID id) {
        if (auto it = actors.find(id); it != actors.end()) {
            actors.erase(it);
        }
    }


    void ActorTable::serialize(GameAPI::GameSerializationInterface serial) {
        size_t size = 0;
        for (auto& [id, data] : actors) {
            if (data.getActor().isPersistent()) {
                size++;
            }
        }
        serial.write<size_t>(size);
        for (auto& [id, data] : actors) {
            if (data.getActor().isPersistent()) {
                data.serialize(serial);
            }
        }
    }

    void ActorTable::deserialize(GameAPI::GameSerializationInterface serial) {
        actors.clear();

        size_t size = serial.read<size_t>();
        for (int i = 0; i < size; i++) {
            ActorData data(serial);
            if (data.isValid()) {
                actors.insert({data.getActor().getRecordID(), data});
            }
        }
    }

    void ActorTable::revert(GameAPI::GameSerializationInterface serial) {
        actors.clear();
    }
}