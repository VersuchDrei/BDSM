#include "EventListener.h"

#include "BDSM/ActorTable.h"
#include "BDSM/EscapeGameTable.h"
#include "GameAPI/Game.h"
#include "GameAPI/GameEventSources.h"
#include "Util/RecordTable.h"

namespace Events {
    void EventListener::setup() {
        GameAPI::GameEventSources::loadActorEventSource.addListener(onActorLoad);
        GameAPI::GameEventSources::deleteRecordEventSource.addListener(onRecordDelete);
        GameAPI::GameEventSources::consumeEventSource.addListener(onConsume);
        GameAPI::GameEventSources::readTextEventSource.addListener(onRead);
        GameAPI::GameEventSources::equipArmorEventSource.addListener(onEquip);
        GameAPI::GameEventSources::unequipArmorEventSource.addListener(onUnequip);
        GameAPI::GameEventSources::equipWeaponEventSource.addListener(onEquipWeapon);
        GameAPI::GameEventSources::equipSpellEventSource.addListener(onEquipSpell);
        GameAPI::GameEventSources::equipScrollEventSource.addListener(onEquipScroll);
        GameAPI::GameEventSources::equipShoutEventSource.addListener(onEquipShout);
    }


    void EventListener::onActorLoad(GameAPI::GameActor& actor) {
        if (actor.wornItemHasKeyword(Util::RecordTable::getNoStripKeyword())) {
            BDSM::ActorTable::getActorData(actor, true);
        }
    }

    void EventListener::onRecordDelete(RecordID& id) {
        BDSM::ActorTable::clearRecord(id);
    }

    void EventListener::onConsume(GameAPI::GameActorEvent& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getGagClosedKeyword())) {
            evt.cancel();
        }
    }

    void EventListener::onRead(GameAPI::GameActorInteractEvent<GameAPI::GameText>& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getBlindfoldKeyword())) {
            evt.cancel();
        }
    }

    void EventListener::onEquip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {
        if (evt.wasPlayer() && GameAPI::GameActor::getPlayer().wornItemHasKeyword(Util::RecordTable::getArmRestraintKeyword())) {
            evt.cancel();
            // TODO notification?
            return;
        }

        if (evt.getItem().hasKeyword(Util::RecordTable::getNoStripKeyword())) {
            BDSM::ActorData* data = BDSM::ActorTable::getActorData(evt.getActor(), true);
            if (data->canEquip(evt.getItem())) {
                if (evt.wasPlayer()) {
                    // TODO check for message box option
                    if (true) {
                        evt.cancel();
                        GameAPI::GameArmor armor = evt.getItem();
                        GameAPI::Game::showMessageBox("Lock?", {"Yes", "No"}, [data, armor](unsigned int option) {
                            if (option == 0) {
                                data->lock(armor);
                            }
                        });
                        // TODO lock options
                    } else {
                        data->lock(evt.getItem());
                    }
                } else {
                    data->lock(evt.getItem());
                }
            } else if (!data->isLocked(evt.getItem())) {
                evt.cancel();
            }
        } else {
            BDSM::ActorData* data = BDSM::ActorTable::getActorData(evt.getActor(), false);
            if (data && !data->canEquip(evt.getItem())) {
                //TODO notification?
                evt.cancel();
            }
        }
    }

    void EventListener::onUnequip(GameAPI::GameActorEquipEvent<GameAPI::GameArmor>& evt) {
        if (evt.wasPlayer() && GameAPI::GameActor::getPlayer().wornItemHasKeyword(Util::RecordTable::getArmRestraintKeyword())) {
            if (evt.getActor().isPlayer() && evt.getItem().hasKeyword(Util::RecordTable::getArmRestraintKeyword())) {
                BDSM::ActorData* data = BDSM::ActorTable::getActorData(evt.getActor(), true);
                if (data->isLocked(evt.getItem())) {
                    // TODO unlock options
                    GameAPI::GameArmor armor = evt.getItem();
                    GameAPI::Game::showMessageBox("Unlock?", {"Yes", "No"}, [data, armor](unsigned int option) {
                        if (option == 0) {
                            data->unlock(armor);                            
                        }
                    });
                    // END TODO
                } else {
                    return;
                }
            }
            evt.cancel();
            return;
        }

        BDSM::ActorData* data = BDSM::ActorTable::getActorData(evt.getActor(), false);
        if (!data) {
            return;
        }

        if (data->isCovered(evt.getItem().getSlotMask())) {
            evt.cancel();
            return;
        }

        if (data->isLocked(evt.getItem())) {
            if (evt.wasPlayer()) {
                evt.cancel();
                GameAPI::GameArmor armor = evt.getItem();
                BDSM::EscapeGameTable::getSingleton()->tryEscape(data, armor);
            } else {
                evt.cancel();
            }
        }
    }

    void EventListener::onEquipWeapon(GameAPI::GameActorEquipEvent<GameAPI::GameWeapon>& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getRestrainWeaponsKeyword())) {
            evt.cancel();
        }
    }

    void EventListener::onEquipSpell(GameAPI::GameActorEquipEvent<GameAPI::GameSpell>& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getRestrainSpellsKeyword())) {
            evt.cancel();
        }
    }

    void EventListener::onEquipScroll(GameAPI::GameActorEquipEvent<GameAPI::GameScroll>& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getRestrainScrollsKeyword())) {
            evt.cancel();
        }
    }

    void EventListener::onEquipShout(GameAPI::GameActorEquipEvent<GameAPI::GameShout>& evt) {
        if (evt.getActor().wornItemHasKeyword(Util::RecordTable::getRestrainShoutsKeyword())) {
            evt.cancel();
        }
    }
}