#include "RecordTable.h"

namespace Util {
    void RecordTable::setup() {
        bdsmNoStrip.loadFile(0x801);

        bdsmArmRestraint.loadFile(0x83D);
        bdsmBlindfold.loadFile(0x838);
        bdsmGag.loadFile(0x836);
        bdsmGagClosed.loadFile(0x8EC);
        bdsmGagFull.loadFile(0x861);
        bdsmRemoveOnUnlock.loadFile(0x81E);
        bdsmRestrainScrolls.loadFile(0x919);
        bdsmRestrainShouts.loadFile(0x845);
        bdsmRestrainSpells.loadFile(0x846);
        bdsmRestrainWeapons.loadFile(0x847);
    }
}