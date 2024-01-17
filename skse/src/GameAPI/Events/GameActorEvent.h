#pragma once

#include "GameEvent.h"

#include "GameAPI/GameActor.h"

namespace GameAPI {
    struct GameActorEvent : public GameEvent {
    public:
        inline GameActorEvent(GameAPI::GameActor actor) : actor{actor} {}
        inline GameAPI::GameActor getActor() { return actor; }

    private:
        GameAPI::GameActor actor;
    };
}  // namespace Events