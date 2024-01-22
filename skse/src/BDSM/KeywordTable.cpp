#include "KeywordTable.h"

#include "Util/JsonFileLoader.h"
#include "Util/JsonUtil.h"
#include "Util/StringUtil.h"

namespace BDSM {
    const char* KEYWORD_FILE_PATH{"Data/SKSE/Plugins/BDSM/keywords"};

    void KeywordTable::setup() {
        Util::JsonFileLoader::LoadFilesInFolder(KEYWORD_FILE_PATH, [&](std::string path, std::string filename, json json){
            GameAPI::GameKeyword keyword;
            JsonUtil::loadGameRecord<GameAPI::GameKeyword>(json, keyword, "keyword", filename, "keyword", path, true);
            if (!keyword) {
                return;                                 
            }

            std::string lowerName = filename;
            StringUtil::toLower(&lowerName);
            keywordsByIDs[lowerName] = keyword;

            KeywordProperties properties;

            properties.converedSlots.loadJson(json, "coveredSlots", filename, "keyword");
            JsonUtil::consumeLowerStringList(json, [&properties](std::string inherit) { properties.inherits.push_back(inherit); }, "inherits", filename, "keyword", false);

            keywords[keyword.getRecordID()] = properties;
        });
    }


    KeywordProperties* KeywordTable::getProperties(GameAPI::GameKeyword keyword) {
        auto iter = keywords.find(keyword.getRecordID());
        if (iter != keywords.end()) {
            return &iter->second;
        }

        return nullptr;
    }

    GameAPI::GameKeyword KeywordTable::getKeyword(std::string keywordID) {
        auto iter = keywordsByIDs.find(keywordID);
        if (iter != keywordsByIDs.end()) {
            return iter->second;
        }

        return {};
    }
}