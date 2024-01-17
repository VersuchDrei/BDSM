#pragma once

#include "GameActorEvent.h"

namespace GameAPI {
    template<class T>
    class GameActorEquipEvent : public GameActorEvent {
    public:
        GameActorEquipEvent(GameAPI::GameActor actor, T) : GameActorEvent(actor), item{item} {}

    private:
        T item;
    };
}  // namespace Events