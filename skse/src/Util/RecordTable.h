#pragma once

#include "GameAPI/GameKeyword.h"

namespace Util {
    struct RecordTable {
    public:
        static void setup();

        static inline GameAPI::GameKeyword getNoStripKeyword() { return bdsmNoStrip; }

        static inline GameAPI::GameKeyword getArmRestraintKeyword() { return bdsmArmRestraint; }
        static inline GameAPI::GameKeyword getBlindfoldKeyword() { return bdsmBlindfold; }
        static inline GameAPI::GameKeyword getGagKeyword() { return bdsmGag; }
        static inline GameAPI::GameKeyword getGagClosedKeyword() { return bdsmGagClosed; }
        static inline GameAPI::GameKeyword getGagFullKeyword() { return bdsmGagFull; }
        static inline GameAPI::GameKeyword getRemoveOnUnlockKeyword() { return bdsmRemoveOnUnlock; }
        static inline GameAPI::GameKeyword getRestrainScrollsKeyword() { return bdsmRestrainScrolls; }
        static inline GameAPI::GameKeyword getRestrainShoutsKeyword() { return bdsmRestrainShouts; }
        static inline GameAPI::GameKeyword getRestrainSpellsKeyword() { return bdsmRestrainSpells; }
        static inline GameAPI::GameKeyword getRestrainWeaponsKeyword() { return bdsmRestrainWeapons; }

    private:
        static inline GameAPI::GameKeyword bdsmNoStrip;

        static inline GameAPI::GameKeyword bdsmArmRestraint;
        static inline GameAPI::GameKeyword bdsmBlindfold;
        static inline GameAPI::GameKeyword bdsmGag;
        static inline GameAPI::GameKeyword bdsmGagClosed;
        static inline GameAPI::GameKeyword bdsmGagFull;
        static inline GameAPI::GameKeyword bdsmRemoveOnUnlock;
        static inline GameAPI::GameKeyword bdsmRestrainScrolls;
        static inline GameAPI::GameKeyword bdsmRestrainShouts;
        static inline GameAPI::GameKeyword bdsmRestrainSpells;
        static inline GameAPI::GameKeyword bdsmRestrainWeapons;
    };
}