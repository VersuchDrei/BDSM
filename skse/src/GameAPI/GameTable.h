#pragma once

namespace GameAPI {
    struct GameTable {
    public:
        static void setup();

        static inline RE::BGSKeyword* getLockable() {return bdsmLockable;}
    private:
        inline static RE::BGSKeyword* bdsmLockable;
    };
}