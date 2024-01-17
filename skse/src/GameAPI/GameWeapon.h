#pragma once

#include "GameKeyword.h"
#include "GameRecord.h"

namespace GameAPI {
    struct GameWeapon : public GameRecord<RE::TESObjectWEAP> {
        inline GameWeapon() {}
        inline GameWeapon(RE::TESObjectWEAP* weapon) { form = weapon; }

        inline bool hasKeyword(GameKeyword keyword) const { return form->HasKeyword(keyword.form); }
    };
}  // namespace GameAPI