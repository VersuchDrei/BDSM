#pragma once

#include "GameActorEvent.h"

namespace GameAPI {
    template<class T>
    struct GameActorInteractEvent : public GameActorEvent {
    public:
        inline GameActorInteractEvent(GameAPI::GameActor actor, T object) : GameActorEvent(actor), object{object} {}
        inline T getObject() { return object; }
    private:
        T object;
    };
}