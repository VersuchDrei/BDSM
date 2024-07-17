#include "Papyrus.h"

#define BIND(a_method, ...) a_vm->RegisterFunction(#a_method##sv, obj, a_method __VA_OPT__(, ) __VA_ARGS__)
#include "PapyrusEscapeGame.h"
#undef BIND

namespace Papyrus {
    void bind() {
        auto papyrus = SKSE::GetPapyrusInterface();
        if (papyrus) {
            papyrus->Register(EscapeGame::bind);
        }
    }
}