#include "GameHooks.h"

namespace GameLogic {
    void installHooksPost() {
        Load3D::Install();
        EquipItem::Install();
        UnequipItem::Install();
    }
}