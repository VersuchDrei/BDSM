#include "ActorData.h"

#include "KeywordLogic.h"

#include "GameAPI/Game.h"
#include "Util/RecordTable.h"

namespace BDSM {
    ActorData::ActorData(GameAPI::GameActor actor) : actor{actor} {
        if (!actor.wornItemHasKeyword(Util::RecordTable::getNoStripKeyword())) {
            return;
        }

        for (GameAPI::GameArmor armor : actor.getEquippedItems()) {
            if (armor.hasKeyword(Util::RecordTable::getNoStripKeyword())) {
                lock(armor);
            }
        }
    }

    ActorData::ActorData(GameAPI::GameSerializationInterface serial) {
        actor.readSerial(serial);

        size_t size = serial.read<size_t>();
        for (int i = 0; i < size; i++) {
            RestraintData data(serial);
            if (data.restraint) {
                restraints.insert({data.restraint.getRecordID(), data});
                lockedSlots.add(data.restraint.getSlotMask());
                coveredSlots.add(KeywordLogic::getCoveredSlots(data.restraint));
            }
        }
    }

    void ActorData::serialize(GameAPI::GameSerializationInterface serial) {
        actor.writeSerial(serial);
        serial.write<size_t>(restraints.size());
        for (auto& [id, data] : restraints) {
            data.serialize(serial);
        }
    }


    bool ActorData::canEquip(GameAPI::GameArmor armor) {
        GameAPI::GameSlotMask armorSlots = armor.getSlotMask();
        if (armorSlots.overlaps(lockedSlots) || armorSlots.overlaps(coveredSlots)) {
            if (armor.hasKeyword(Util::RecordTable::getNoStripKeyword())) {
                // TODO check for combinations
            }
            
            return false;
        }

        if (armor.hasKeyword(Util::RecordTable::getNoStripKeyword())) {
            if (KeywordLogic::getCoveredSlots(armor).overlaps(coveredSlots)) {
                return false;
            }
        }

        return true;
    }


    bool ActorData::lock(GameAPI::GameArmor armor) {
        if (!armor.hasKeyword(Util::RecordTable::getNoStripKeyword())) {
            return false;
        }

        if (armor.getSlotMask().overlaps(lockedSlots)) {
            // TODO check for combinations
            return false;
        }

        if (KeywordLogic::getCoveredSlots(armor).overlaps(coveredSlots)) {
            return false;
        }

        lock({armor});

        if (armor.hasKeyword(Util::RecordTable::getRestrainWeaponsKeyword())) {
            actor.unequipWeapons();
        }
        if (armor.hasKeyword(Util::RecordTable::getRestrainSpellsKeyword())) {
            actor.unequipSpells();
        }
        if (armor.hasKeyword(Util::RecordTable::getRestrainScrollsKeyword())) {
            actor.unequipScrolls();
        }
        if (armor.hasKeyword(Util::RecordTable::getRestrainShoutsKeyword())) {
            actor.unequipShouts();
        }

        actor.refreshInventory();
        actor.update3D();

        return true;
    }

    void ActorData::lock(RestraintData data) {
        restraints.insert({data.restraint.getRecordID(), data});

        lockedSlots.add(data.restraint.getSlotMask());
        coveredSlots.add(KeywordLogic::getCoveredSlots(data.restraint));

        if (!actor.isEquipped(data.restraint)) {
            if (actor.getItemCount(data.restraint) == 0) {
                actor.addItem(data.restraint, 1);
            }
            actor.equip(data.restraint);
        }
    }

    bool ActorData::unlock(GameAPI::GameArmor armor) {
        auto iter = restraints.find(armor.getRecordID());
        if (iter == restraints.end()) {
            return false;
        }

        std::vector<RestraintData> combinations = iter->second.combinations;
        GameAPI::GameArmor original = iter->second.original;

        restraints.erase(iter);
        lockedSlots.remove(armor.getSlotMask());
        coveredSlots.remove(KeywordLogic::getCoveredSlots(armor));

        actor.unequip(armor);

        for (RestraintData data : combinations) {
            actor.addItem(data.restraint, 1);
            lock(data);
        }

        if (armor.hasKeyword(Util::RecordTable::getRemoveOnUnlockKeyword())) {
            actor.removeItem(armor, 1);
        } else if (original) {
            actor.removeItem(armor, 1);
            actor.addItem(original, 1);
        }

        actor.refreshInventory();
        actor.update3D();

        return true;
    }


    bool ActorData::isLocked(GameAPI::GameArmor armor) {
        auto iter = restraints.find(armor.getRecordID());
        return iter != restraints.end();
    }
}