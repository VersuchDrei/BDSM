#include "ActorData.h"

#include "KeywordLogic.h"

#include "GameAPI/Game.h"
#include "Util/RecordTable.h"

namespace BDSM {
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

        lock({.restraint = armor});

        actor.refreshInventory();

        return true;
    }

    void ActorData::lock(RestraintData data) {
        restraints[data.restraint.getRecordID()] = data;

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

        return true;
    }


    bool ActorData::isLocked(GameAPI::GameArmor armor) {
        auto iter = restraints.find(armor.getRecordID());
        return iter != restraints.end();
    }
}