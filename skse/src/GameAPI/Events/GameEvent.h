#pragma once

namespace GameAPI {
    struct GameEvent {
    public:
        inline void cancel() { cancelled = true; }
        inline bool isCancelled() { return cancelled; }

    private:
        bool cancelled = false;
    };
}