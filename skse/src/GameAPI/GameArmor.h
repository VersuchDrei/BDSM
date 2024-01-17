#pragma once

#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameArmor : public GameRecord<RE::TESObjectARMO> {
        inline GameArmor() {}
        inline GameArmor(RE::TESObjectARMO* armor) { form = armor; }

        inline bool hasKeyword(GameKeyword keyword) const { return form->HasKeyword(keyword.form); }
    };
}