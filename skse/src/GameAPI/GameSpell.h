#pragma once

#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameSpell : public GameRecord<RE::SpellItem> {
        inline GameSpell() {}
        inline GameSpell(RE::SpellItem* spell) { form = spell; }

        inline bool hasKeyword(GameKeyword keyword) const { return form->HasKeyword(keyword.form); }
    };
}  // namespace GameAPI