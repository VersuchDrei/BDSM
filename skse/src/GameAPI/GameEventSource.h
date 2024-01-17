#pragma once

namespace GameAPI {
    template<class T>
    class GameEventSource {
    public:
        inline void addListener(std::function<void(T&)> listener) { listeners.push_back(listener); }
        inline void sendEvent(T& evt) {
            for (std::function<void(T&)> listener : listeners) {
                listener(evt);
            }
        }

    private:
        std::vector<std::function<void(T&)>> listeners;
    };
}  // namespace GameAPI