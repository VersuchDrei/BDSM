#include <stddef.h>

#include "Core.h"
#include "GameLogic/GameEventListener.h"
#include "GameLogic/GameHooks.h"
#include "GameLogic/GameSerializationManager.h"
#include "GameLogic/GameTable.h"

using namespace RE::BSScript;
using namespace SKSE;
using namespace SKSE::log;
using namespace SKSE::stl;

namespace {
    void InitializeLogging() {
        auto path = log_directory();
        if (!path) {
            report_and_fail("Unable to lookup SKSE logs directory.");
        }
        *path /= PluginDeclaration::GetSingleton()->GetName();
        *path += L".log";

        std::shared_ptr<spdlog::logger> log;
        if (IsDebuggerPresent()) {
            log = std::make_shared<spdlog::logger>(
                "Global", std::make_shared<spdlog::sinks::msvc_sink_mt>());
        } else {
            log = std::make_shared<spdlog::logger>(
                "Global", std::make_shared<spdlog::sinks::basic_file_sink_mt>(path->string(), true));
        }
        log->set_level(spdlog::level::info);
        log->flush_on(spdlog::level::info);

        spdlog::set_default_logger(std::move(log));
        spdlog::set_pattern("[%Y-%m-%d %H:%M:%S.%e] [%n] [%l] [%t] [%s:%#] %v");
    }

     void MessageHandler(SKSE::MessagingInterface::Message* a_msg) {
        switch (a_msg->type) {
            case SKSE::MessagingInterface::kPostLoad: {
                GameLogic::installHooksPost();
                GameLogic::GameEventListener::setup();

                Core::postLoad();
            } break;
            case SKSE::MessagingInterface::kPostPostLoad: {
                Core::postpostLoad();
            } break;
            case SKSE::MessagingInterface::kDataLoaded: {
                GameLogic::GameTable::setup();

                Core::dataLoaded();
                SKSE::GetTaskInterface()->AddTask([]() { Core::postDataLoaded(); });
            } break;
        }
    }
}

SKSEPluginLoad(const LoadInterface* skse) {
    InitializeLogging();

    auto* plugin = PluginDeclaration::GetSingleton();
    auto version = plugin->GetVersion();
    log::info("{} {} is loading...", plugin->GetName(), version);

    Init(skse);

    Core::init();

    auto message = SKSE::GetMessagingInterface();
    if (!message->RegisterListener(MessageHandler)) {
        return false;
    }

    const auto serial = SKSE::GetSerializationInterface();
    serial->SetUniqueID(_byteswap_ulong('BDSM'));
    serial->SetSaveCallback(GameLogic::Save);
    serial->SetLoadCallback(GameLogic::Load);
    serial->SetRevertCallback(GameLogic::Revert);

    log::info("{} has finished loading.", plugin->GetName());
    return true;
}
