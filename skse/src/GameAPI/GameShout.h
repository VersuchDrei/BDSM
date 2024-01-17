#pragma once

#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameShout : public GameRecord<RE::TESShout> {
        inline GameShout() {}
        inline GameShout(RE::TESShout* shout) { form = shout; }
    };
}  // namespace GameAPI