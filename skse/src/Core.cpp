#include "Core.h"

#include "Events/EventListener.h"

namespace Core {
    void init() {
        Events::EventListener::setup();
    }

    void postLoad() {

    }

    void postpostLoad() {

    }

    void dataLoaded() {

    }

    void postDataLoaded() {

    }
}