#include "GameTable.h"

namespace GameLogic {
    void GameTable::setup() {
        RE::TESDataHandler* handler = RE::TESDataHandler::GetSingleton();
        GameDaysPassed = handler->LookupForm<RE::TESGlobal>(0x000039, "Skyrim.esm");
    }
}