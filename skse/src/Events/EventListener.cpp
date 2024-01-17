#include "EventListener.h"

#include "GameAPI/GameEventSources.h"

namespace Events {
    void EventListener::setup() {
        GameAPI::GameEventSources::equipArmorEventSource.addListener(onEquip);
        GameAPI::GameEventSources::unequipArmorEventSource.addListener(onUnequip);
        GameAPI::GameEventSources::equipSpellEventSource.addListener(onEquipSpell);
        GameAPI::GameEventSources::equipShoutEventSource.addListener(onEquipShout);
        GameAPI::GameEventSources::equipWeaponEventSource.addListener(onEquipWeapon);
    }

    void EventListener::onEquip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {

    }

    void EventListener::onUnequip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {

    }

    void EventListener::onEquipSpell(GameAPI::GameActorEquipEvent<GameAPI::GameSpell>& evt) {
    
    }

    void EventListener::onEquipShout(GameAPI::GameActorEquipEvent<GameAPI::GameShout>& evt) {
    
    }

    void EventListener::onEquipWeapon(GameAPI::GameActorEquipEvent<GameAPI::GameWeapon>& evt) {
    
    }
}