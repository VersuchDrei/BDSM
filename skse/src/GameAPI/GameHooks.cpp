#include "GameHooks.h"

namespace GameAPI {
    void installHooksPost() {
        EquipItem::Install();
        UnequipItem::Install();
    }
}