#include "Core.h"

#include "BDSM/ActorTable.h"
#include "BDSM/KeywordLogic.h"
#include "BDSM/KeywordTable.h"
#include "Events/EventListener.h"
#include "Util/RecordTable.h"

namespace Core {
    void init() {
        Events::EventListener::setup();
    }

    void postLoad() {

    }

    void postpostLoad() {

    }

    void dataLoaded() {
        Util::RecordTable::setup();
        BDSM::KeywordTable::setup();
    }

    void postDataLoaded() {
        BDSM::KeywordLogic::processArmors();
    }

    void save(GameAPI::GameSerializationInterface serial) {
        BDSM::ActorTable::serialize(serial);
    }

    void load(GameAPI::GameSerializationInterface serial) {
        BDSM::ActorTable::deserialize(serial);
    }

    void revert(GameAPI::GameSerializationInterface serial) {
        BDSM::ActorTable::revert(serial);
    }
}