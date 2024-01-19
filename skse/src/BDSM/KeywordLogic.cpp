#include "KeywordLogic.h"

namespace BDSM {
    void KeywordLogic::processArmors() {
        GameAPI::GameArmor::forAll(processArmor);
    }

    void KeywordLogic::processArmor(GameAPI::GameArmor armor) {
        for (GameAPI::GameKeyword keyword : armor.getKeywords()) {
            processKeyword(armor, keyword);
        }
    }

    void KeywordLogic::processKeyword(GameAPI::GameArmor armor, GameAPI::GameKeyword keyword) {
        KeywordProperties* properties = KeywordTable::getProperties(keyword);
        if (!properties) {
            return;
        }

        for (std::string inheritance : properties->inherits) {
            tryAddKeyword(armor, inheritance);
        }
    }

    void KeywordLogic::tryAddKeyword(GameAPI::GameArmor armor, std::string keywordID) {
        GameAPI::GameKeyword keyword = KeywordTable::getKeyword(keywordID);
        if (!keyword) {
            return;
        }

        if (armor.hasKeyword(keyword)) {
            return;
        }

        armor.addKeyword(keyword);
        processKeyword(armor, keyword);
    }


    GameAPI::GameSlotMask KeywordLogic::getCoveredSlots(GameAPI::GameArmor armor) {
        GameAPI::GameSlotMask coveredSlots;

        for (GameAPI::GameKeyword keyword : armor.getKeywords()) {
            KeywordProperties* properties = KeywordTable::getProperties(keyword);
            if (properties) {
                coveredSlots.add(properties->converedSlots);
            }
        }

        coveredSlots.remove(armor.getSlotMask());

        return coveredSlots;
    }
}