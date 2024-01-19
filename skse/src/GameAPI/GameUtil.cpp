#include "GameUtil.h"

namespace GameAPI {
    namespace GameUtil {
        bool isInventoryOpen() {
            return RE::UI::GetSingleton()->IsMenuOpen("InventoryMenu") ||
                   RE::UI::GetSingleton()->IsMenuOpen("ContainerMenu");
        }

        void CompileAndRun(RE::Script* script, RE::TESObjectREFR* targetRef, RE::COMPILER_NAME name) {
            RE::ScriptCompiler compiler;
            CompileAndRunImpl(script, &compiler, name, targetRef);
        }
    }
}