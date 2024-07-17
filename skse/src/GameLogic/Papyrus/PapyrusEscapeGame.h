#pragma once

#include "ScriptAPI/EscapeGameScript.h"

namespace Papyrus {
    namespace EscapeGame {
        void EscapeGameSuccessNative(RE::StaticFunctionTag*, RE::Actor* target, RE::TESObjectARMO* restraint) {
            ScriptAPI::EscapeGame::escapeGameSuccess(target, restraint);
        }

        bool bind(RE::BSScript::IVirtualMachine* a_vm) {
            const auto obj = "bdsmEscapeGame"sv;

            BIND(EscapeGameSuccessNative);

            return true;
        }
    }
}