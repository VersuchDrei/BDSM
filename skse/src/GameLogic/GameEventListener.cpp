#include "GameEventListener.h"

#include "GameAPI/GameEventSources.h"

namespace GameLogic {
    void GameEventListener::setup() {
		GameEventListener* listener = getSingleton();
        RE::ScriptEventSourceHolder::GetSingleton()->AddEventSink<RE::TESFormDeleteEvent>(listener);
	}

	RE::BSEventNotifyControl GameEventListener::ProcessEvent(const RE::TESFormDeleteEvent* evt, RE::BSTEventSource<RE::TESFormDeleteEvent>*) {
        RecordID id = evt->formID;
        GameAPI::GameEventSources::deleteRecordEventSource.sendEvent(id);

		return RE::BSEventNotifyControl::kContinue;
	}
}