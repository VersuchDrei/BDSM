#pragma once

#include "Util/Singleton.h"

namespace GameLogic {
    class GameEventListener : public Util::ISingleton<GameEventListener>, public RE::BSTEventSink<RE::TESFormDeleteEvent> {
    public:
        static void setup();

        RE::BSEventNotifyControl ProcessEvent(const RE::TESFormDeleteEvent* evt, RE::BSTEventSource<RE::TESFormDeleteEvent>*) override;
    };
}