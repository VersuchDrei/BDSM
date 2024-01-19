#pragma once

namespace GameAPI {
    class Game {
    public:
        inline static void notification(std::string text) { RE::DebugNotification(text.c_str()); }
        inline static int getMessageBoxOptionLimit() { return 9; }
        static void showMessageBox(std::string content, std::vector<std::string> options, std::function<void(unsigned int)> callback);

        static inline void runSynced(std::function<void()> func) { SKSE::GetTaskInterface()->AddTask([func]{func();}); }

    private:
        class MessageBoxCallback : public RE::IMessageBoxCallback {
        public:
            MessageBoxCallback(std::function<void(unsigned int)> callback) : callback{callback} {}
            ~MessageBoxCallback() override {}
            void Run(RE::IMessageBoxCallback::Message message) override {
                callback(static_cast<unsigned int>(message));
            }

        private:
            std::function<void(unsigned int)> callback;
        };
    };
}