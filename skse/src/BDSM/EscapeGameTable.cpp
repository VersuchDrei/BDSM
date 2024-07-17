#include "EscapeGameTable.h"

#include "GameAPI/Game.h"
#include "Util/JsonFileLoader.h"
#include "Util/JsonUtil.h"

namespace BDSM {
    const char* ESCAPE_GAME_FILE_PATH{"Data/SKSE/Plugins/BDSM/escape games"};

    void EscapeGameTable::setup() {
        escapeGames.clear();

        Util::JsonFileLoader::LoadFilesInFolder(ESCAPE_GAME_FILE_PATH, [&](std::string path, std::string filename, json json){
            EscapeGame escapeGame;
            JsonUtil::loadGameRecord<GameAPI::BDSM::EscapeGame>(json, escapeGame.game, "game", filename, "escape game", path, true);
            if (!escapeGame.game) {
                return;
            }

            if (!json.contains("difficulties")) {
                logger::warn("escape game {} does not have property 'difficulties' defined", filename);
                return;
            }

            nlohmann::json difficulties = json["difficulties"];
            if (!difficulties.is_array()) {
                logger::warn("property 'difficulties' of escape game {} is not a list", filename);
                return;
            }

            escapeGame.displayName = filename;
            JsonUtil::loadString(json, escapeGame.displayName, "displayName", filename, "escape game", false);
            JsonUtil::loadInt(json, escapeGame.priority, "priority", filename, "escape game", false);

            int index = -1;
            for (nlohmann::json jsonDifficulty : difficulties) {
                index++;
                
                if (!jsonDifficulty.is_object()) {
                    logger::warn("difficulty {} of escape game {} is malformed", index, filename);
                    continue;
                }

                std::string objectType = "difficulty " + std::to_string(index) + " of escape game";

                EscapeGameDifficulty difficulty;
                difficulty.index = index;

                JsonUtil::loadGameRecord<GameAPI::GameKeyword>(jsonDifficulty, difficulty.keyword, "keyword", filename, objectType, path, true);
                if (!difficulty.keyword) {
                    continue;
                }

                JsonUtil::loadGameRecord<GameAPI::GameCondition>(jsonDifficulty, difficulty.condition, "condition", filename, objectType, path, false);

                escapeGame.difficulties.push_back(difficulty);
            }

            escapeGames.push_back(escapeGame);
        });

        std::sort(escapeGames.begin(), escapeGames.end(), [&](EscapeGame a, EscapeGame b) {
            return a.priority > b.priority;
        });
    }


    void EscapeGameTable::tryEscape(ActorData* data, GameAPI::GameArmor restraint) {
        std::vector<EscapeGame*> availableGames;

        for (EscapeGame& game : escapeGames) {
            if (game.canEscape(data->getActor(), restraint)) {
                availableGames.push_back(&game);
            }
        }

        std::vector<std::string> gameNames;
        for (EscapeGame* game : availableGames) {
            gameNames.push_back(game->displayName);
        }

        GameAPI::Game::showMessageBox("$bdsm_escape_selection_message", gameNames, [data, restraint, availableGames](unsigned int index) {
            availableGames[index]->tryEscape(data->getActor(), restraint);
        });
    }
}