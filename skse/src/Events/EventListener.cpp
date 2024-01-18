#include "EventListener.h"

#include "GameAPI/GameEventSources.h"

namespace Events {
    void EventListener::setup() {
        GameAPI::GameEventSources::consumeEventSource.addListener(onConsume);
        GameAPI::GameEventSources::equipArmorEventSource.addListener(onEquip);
        GameAPI::GameEventSources::unequipArmorEventSource.addListener(onUnequip);
        GameAPI::GameEventSources::equipWeaponEventSource.addListener(onEquipWeapon);
        GameAPI::GameEventSources::equipSpellEventSource.addListener(onEquipSpell);
        GameAPI::GameEventSources::equipScrollEventSource.addListener(onEquipScroll);
        GameAPI::GameEventSources::equipShoutEventSource.addListener(onEquipShout);
    }

    void EventListener::onConsume(GameAPI::GameActorEvent& evt) {

    }

    void EventListener::onEquip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {

    }

    void EventListener::onUnequip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {

    }

    void EventListener::onEquipWeapon(GameAPI::GameActorEquipEvent<GameAPI::GameWeapon>& evt) {
    
    }

    void EventListener::onEquipSpell(GameAPI::GameActorEquipEvent<GameAPI::GameSpell>& evt) {
    
    }

    void EventListener::onEquipScroll(GameAPI::GameActorEquipEvent<GameAPI::GameScroll>& evt) {
    
    }

    void EventListener::onEquipShout(GameAPI::GameActorEquipEvent<GameAPI::GameShout>& evt) {
    
    }
}