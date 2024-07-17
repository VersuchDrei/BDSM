#pragma once

#include "GameRecord.h"

namespace GameAPI {
    struct GameScriptInstance : public GameRecord<RE::TESQuest> {
        inline GameScriptInstance() {}
        inline GameScriptInstance(RE::TESQuest* quest) { form = quest; }
    };
}