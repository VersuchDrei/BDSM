#include "Game.h"

#include "Game/LocaleManager.h"

namespace GameAPI {
    void Game::showMessageBox(std::string content, std::vector<std::string> options, std::function<void(unsigned int)> callback) {
        content = LocaleManager::GetSingleton()->GetLocalization(content);
        for (std::string& option : options) {
            option = LocaleManager::GetSingleton()->GetLocalization(option);
        }

        auto* messagebox = RE::MessageDataFactoryManager::GetSingleton()->GetCreator<RE::MessageBoxData>(RE::InterfaceStrings::GetSingleton()->messageBoxData)->Create();
        messagebox->callback = RE::make_smart<MessageBoxCallback>(callback);
        messagebox->bodyText = content;
        for (std::string& text : options) {
            messagebox->buttonText.push_back(text.c_str());
        }
        messagebox->QueueMessage();
    }
}