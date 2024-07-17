#include "EscapeGame.h"

namespace GameAPI {
    namespace BDSM {
        void EscapeGame::startEscapeGame(int difficulty, GameActor target, GameArmor restraint) {
            const auto skyrimVM = RE::SkyrimVM::GetSingleton();
            auto vm = skyrimVM ? skyrimVM->impl : nullptr;
            if (vm) {
                RE::TESQuest* escapeGame = form;
                RE::Actor* actor = target.form;
                RE::TESObjectARMO* armor = restraint.form;
                RE::BSTSmartPointer<RE::BSScript::IStackCallbackFunctor> callback;
                auto args = RE::MakeFunctionArguments(std::move(escapeGame), std::move(difficulty), std::move(actor), std::move(armor));
                vm->DispatchStaticCall("bdsmSKSE", "StartEscapeGame", args, callback);
            }
        }
    }
}