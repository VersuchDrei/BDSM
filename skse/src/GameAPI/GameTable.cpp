#include "GameTable.h"

namespace GameAPI {
    void GameTable::setup() {
        RE::TESDataHandler* handler = RE::TESDataHandler::GetSingleton();

        bdsmLockable = handler->LookupForm<RE::BGSKeyword>(0x801, "BDSM.esp");
    }
}