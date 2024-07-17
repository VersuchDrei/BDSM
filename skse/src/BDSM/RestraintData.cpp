#include "RestraintData.h"

#include "GameAPI/Game.h"
#include "Util/SerializationUtil.h"

namespace BDSM {
    RestraintData::RestraintData(GameAPI::GameSerializationInterface serial) {
        restraint.readSerial(serial);
        original.readSerial(serial);

        cooldowns = SerializationUtil::readFloatMap(serial);

        size_t size = serial.read<size_t>();
        for (int i = 0; i < size; i++) {
            RestraintData data(serial);
            if (data.restraint) {
                combinations.push_back(data);
            }
        }
    }

    void RestraintData::serialize(GameAPI::GameSerializationInterface serial) {
        restraint.writeSerial(serial);
        original.writeSerial(serial);

        SerializationUtil::writeFloatMap(serial, cooldowns);

        serial.write<size_t>(combinations.size());
        for (RestraintData& data : combinations) {
            data.serialize(serial);
        }
    }


    bool RestraintData::isGameOnCooldown(std::string game) {
        if (!cooldowns.contains(game)) {
            return false;
        }

        return cooldowns[game] < GameAPI::Game::getGameTime();
    }

    void RestraintData::setGameCooldown(std::string game, float cooldown) {
        cooldowns[game] = GameAPI::Game::getGameTime() + cooldown;
    }
}