#pragma once

#include "GameRecord.h"

namespace GameAPI {
    struct GameText : public GameRecord<RE::TESObjectBOOK> {
    public:
        inline GameText() {}
        inline GameText(RE::TESObjectBOOK* book) { form = book; }
    };
}