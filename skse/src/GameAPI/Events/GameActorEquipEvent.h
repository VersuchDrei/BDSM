#pragma once

#include "GameActorEvent.h"

namespace GameAPI {
    template<class T>
    class GameActorEquipEvent : public GameActorEvent {
    public:
        inline GameActorEquipEvent(GameAPI::GameActor actor, T item, bool byPlayer) : GameActorEvent(actor), item{item}, byPlayer{byPlayer} {}

        inline T getItem() { return item; }
        inline bool wasPlayer() { return byPlayer; }

    private:
        T item;
        bool byPlayer;
    };
}  // namespace Events