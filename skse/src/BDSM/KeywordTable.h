#pragma once

#include "KeywordProperties.h"

#include "GameAPI/GameArmor.h"
#include "GameAPI/GameKeyword.h"

namespace BDSM {
    struct KeywordTable {
    public:
        static void setup();

        static KeywordProperties* getProperties(GameAPI::GameKeyword keyword);
        static GameAPI::GameKeyword getKeyword(std::string keywordID);

    private:
        static inline std::unordered_map<RecordID, KeywordProperties> keywords;
        static inline std::unordered_map<std::string, GameAPI::GameKeyword> keywordsByIDs;
    };
}