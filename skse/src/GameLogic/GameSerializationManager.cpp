#include "GameSerializationManager.h"

#include "Core.h"

namespace GameLogic {
    void Save(SKSE::SerializationInterface* serial) {
        std::unique_lock lock(_lock);
        logger::info("serializing data");

        if (!serial->OpenRecord(bdsmRecord, 0)) {
            logger::error("Unable to open record to write cosave data.");
            return;
        }

        Core::save(serial);
    }

    void Load(SKSE::SerializationInterface* serial) {
        std::unique_lock lock(_lock);
        logger::info("deserializing data");

        std::uint32_t type;
        std::uint32_t size;
        std::uint32_t version;

        while (serial->GetNextRecordInfo(type, version, size)) {
            if (type == bdsmRecord) {
                Core::load(serial);
            }
        }
    }

    void Revert(SKSE::SerializationInterface* serial) {
        Core::revert(serial);
    }
}