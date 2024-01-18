#pragma once

#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameScroll : public GameRecord<RE::ScrollItem> {
        inline GameScroll() {}
        inline GameScroll(RE::ScrollItem* scroll) { form = scroll; }

        inline bool hasKeyword(GameKeyword keyword) const { return form->HasKeyword(keyword.form); }
    };
}  // namespace GameAPI