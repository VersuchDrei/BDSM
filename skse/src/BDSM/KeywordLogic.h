#pragma once

#include "KeywordTable.h"

#include "GameAPI/GameArmor.h"

namespace BDSM {
    class KeywordLogic {
    public:
        static void processArmors();

        static GameAPI::GameSlotMask getCoveredSlots(GameAPI::GameArmor);

    private:
        static void processArmor(GameAPI::GameArmor armor);
        static void processKeyword(GameAPI::GameArmor armor, GameAPI::GameKeyword keyword);
        static void tryAddKeyword(GameAPI::GameArmor armor, std::string keywordID);
    };
}