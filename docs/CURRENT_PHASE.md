# 🎯 Current Focus: Phase 1 - Core Mining Loop

**What we're building RIGHT NOW:**

### 1.1 Mining Mechanics
- [x] Asteroid field spawner (3-5 asteroids et sted)
- [x] Asteroid sprites (simple colored circles OK for V1)
- [x] Click asteroid → ship flyver derhen automatisk
- [x] Mining laser visual (line/particles)
- [x] Mining progressbar (3-5 sek per asteroid)
- [x] Asteroid giver Iron (første resource)
- [x] Cargo system: Ship har max capacity (fx 100 units)
- [x] HUD: viser cargo (Iron: 45/100)

### 1.2 Base & Economy
- [x] Base station (fysisk objekt i verden)
- [x] Fly til base → åbner UI menu
- [x] Sell menu: Iron → Credits (fast pris V1)
- [x] Credits display i HUD
- [x] Return to mining field

### 1.3 First Upgrade
- [x] Upgrade menu på base
- [x] 1 upgrade: Cargo capacity +50 (koster 500 credits)
- [x] Køb → cargo max øges
- [x] Upgrade er persistent (gemmes)

**Done when:** Du kan mine Iron → flyve til base → sælge → købe cargo upgrade → mine mere

---

## ⛔ DO NOT BUILD YET:

### Phase 2 features (kommer EFTER Phase 1):
- Multiple resource types (Copper, Crystal)
- Different zones
- Zone selector UI

### Phase 3+ features:
- Pirates
- Combat/weapons
- Shield system
- Fleet/multiple ships
- Automation
- Outposts
- Anything else from TODO.md

**If you're tempted to build these:** STOP. Finish Phase 1 first. Test it. Make it feel good.

---

## Testing Checklist før vi går videre til Phase 2:

- [ ] Kan jeg klikke på asteroid og skibet flyver derhen?
- [ ] Starter mining automatisk når skibet ankommer?
- [ ] Viser mining laser korrekt?
- [ ] Viser progress bar mining progress?
- [ ] Får jeg iron i cargo efter mining?
- [ ] Viser HUD korrekt cargo (Iron: X/100)?
- [ ] Åbner base menu når jeg flyver til station?
- [ ] Kan jeg sælge iron for credits?
- [ ] Viser HUD credits korrekt?
- [ ] Kan jeg købe cargo upgrade?
- [ ] Gemmes upgrade efter restart?
- [ ] Føles hele loopet tilfredsstillende?

### Questions to ask yourself:
- Er det *chill* at mine og sælge?
- Føles mining progression som en belønning?
- Ville jeg gerne have flere resources og upgrades?

**If any answer is "no":** Fix it before moving to Phase 2!

---

## 📝 Notes for Phase 1

**Controls:**
- **Left-click on asteroid** = Navigate to and mine
- **Right-click anywhere** = Manual movement (cancels mining)
- **Fly to base station** = Opens sell/upgrade menu

**World Layout:**
```
     -800                    0                    +800
       |                      |                      |
   BASE STATION           PLAYER START        ASTEROID FIELD
       [B]                   [P]                  [A][A][A]
```

**Technical implementation:**
- GameStateSingleton autoload singleton (credits, cargo, upgrades)
- Phase-based script organization (/scripts/phase1/)
- Procedurally generated sprites (embedded in scripts)
- Area2D for asteroids and base station collision
- Line2D for mining laser visual

---

## ✅ When Phase 1 is DONE:

1. Test thoroughly (play for 10+ minutes)
2. Complete the mining loop several times
3. Buy the cargo upgrade
4. Verify save/load works
5. Commit to git: `git commit -m "Phase 1 complete - Core mining loop works"`
6. Update this file to Phase 2
7. THEN start building Phase 2 features

---

**Next Phase Preview:** Phase 2 - Resources & Zones
- Multiple resource types (Copper, Crystal)
- Different zones with different rewards
- But we're NOT there yet!

**Current Status:** 🟡 Implemented incl. minimap improvements, pending playtest
**Started:** 4. februar 2026
**Completed:** [Not yet]
