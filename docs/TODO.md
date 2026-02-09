# Space Mining Empire - Development Roadmap

**Vision:** Chill automation empire i rummet - rolig progression, tilfredsstillende automation
**Engine:** Godot
**Status:** V1 Proof of Concept

---

## 🎯 Core Decisions (Locked for V1)

- ✅ Real-time gameplay, men kan altid flygte
- ✅ Mining: Target område → skibet miner automatisk
- ✅ Ships: Slot-based (ikke grid) - Motor/Mining/Cargo/Weapon slots
- ✅ Outpost: Unlocks når du har 2 skibe
- ✅ Cargo: Per resource type (fylder forskelligt)
- ✅ Ingen fuel system i V1
- ✅ Fjender: Sporadiske pirate visits (ikke konstant combat)
- ✅ Base: Fysisk station du flyver til

---

## Phase 0: Foundation ✅ COMPLETE
**Mål:** Godot projekt setup + basic bevægelse

- [x] Opret Godot projekt + Git repository
- [x] Basic 2D space scene (sort baggrund, få stjerner)
- [x] Player ship sprite + click-to-move input (right-click)
- [x] Ship bevægelse (acceleration, max speed, rotation mod bevægelsesretning)
- [x] Kamera følger ship
- [x] Right-click navigation (click-to-move med NavigationAgent2D)

**Done when:** Du kan flyve rundt i tomt rum ✅ Playtest godkendt 4. februar 2026

---

## Phase 1: Core Mining Loop 🪨
**Mål:** Et skib kan mine og sælge

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

## Phase 2: Resources & Zones 🌌
**Mål:** Flere resources + risiko/belønning

- [ ] Resource type: Copper (lidt mere værd end Iron)
- [ ] Resource type: Crystal (rare, meget værd)
- [ ] Zone 1 (Safe): Mest Iron, lidt Copper
- [ ] Zone 2 (Risky): Copper + Crystal, dyrere rewards
- [ ] Zone selector UI (vælg zone før du undocker)
- [ ] Different asteroid colors per resource type

**Done when:** Du kan vælge mellem 2 zoner med forskellige rewards

---

## Phase 3: Pirates & Risk ⚔️
**Mål:** Risky zone har faktisk risiko

- [ ] Pirate drone sprite + AI
- [ ] Pirate spawner i Zone 2 (sporadisk - hver 30-60 sek)
- [ ] Pirate følger player ship (simple chase)
- [ ] Pirate skyder (simpel projectile)
- [ ] Player ship HP system
- [ ] Shield slot upgrade (absorberer skade)
- [ ] Flee mechanic: Return to base tidligt (mister ikke cargo)
- [ ] Death: Mister cargo + repair cost (200 credits)

**Done when:** Zone 2 føles risikabelt men ikke unfair

---

## Phase 4: Fleet System 🚀
**Mål:** Flere skibe = automation starter

### 4.1 Second Ship
- [ ] Ship hangar UI på base
- [ ] Buy ship: Miner Hull (koster 2000 credits)
- [ ] Switch mellem ships (vælg hvilket du styrer)
- [ ] Idle ships venter på base

### 4.2 Basic Automation
- [ ] Orders UI: "Mine Zone 1" → "Return when cargo full"
- [ ] Auto-pilot: Ship flyver til zone automatisk
- [ ] Auto-mining: Ship finder nærmeste asteroid selv
- [ ] Auto-return: Når cargo ≥ 90% → tilbage til base
- [ ] Auto-sell: Sælger automatisk på base
- [ ] Loop: Ship gentager orden indtil du stopper den

### 4.3 Ship Roles (Slots)
- [ ] Slot system: Hvert ship har 4 slots
  - Motor slot (speed stat)
  - Mining slot (mining speed stat)
  - Cargo slot (capacity stat)
  - Weapon slot (auto-defense)
- [ ] 3 modules per slot type (tier 1/2/3)
- [ ] Upgrade/swap modules menu

**Done when:** Du har 2 skibe, 1 på manual, 1 på auto-loop

---

## Phase 5: Outpost Unlock 🏗️
**Mål:** Empire-følelse kickstarter

- [ ] Outpost build menu (unlocks når du ejer 2+ ships)
- [ ] Place outpost i Zone 1 eller Zone 2
- [ ] Outpost features:
  - Repair ships
  - Storage (ekstra cargo depot)
  - Auto-sell (ships kan sælge dér)
- [ ] Ships kan target outpost i stedet for main base
- [ ] Zone "sikres" når outpost bygges (færre pirates)

**Done when:** Du har 1 outpost kørende, fleet bruger den

---

## Phase 6: Polish & V1 Victory 🎉
**Mål:** Spillet føles som et rigtigt spil

- [ ] Sound FX (mining laser, sell, pirate shoot)
- [ ] Background music (chill space vibes)
- [ ] Particle effects (mining sparks, explosions)
- [ ] Save/Load system (gem progress mellem sessions)
- [ ] Tutorial popups (første gang hver mechanic)
- [ ] Victory condition: 100k credits + 3 ships + 1 outpost

**Done when:** V1 er "done" og kan vises frem

---

## 🚫 Backlog (DO NOT TOUCH før Phase 6 er done)

- Node-based automation editor
- Factions & reputation
- Market price fluctuations
- Production chains (refinery)
- Multiple star systems
- Procedural generation
- More ship types (Hauler, Scout, Escort)
- Crew/AI pilots
- Story/quests

---

## 📊 Progress Tracking

**Current Phase:** Phase 1 - Core Mining Loop
**Last Updated:** 9. februar 2026

### Milestones
- [x] Phase 0 Complete ✅ (4. februar 2026)
- [ ] Phase 1 Complete (Core Loop Works!)
- [ ] Phase 2 Complete (Resources & Zones)
- [ ] Phase 3 Complete (Risk Added)
- [ ] Phase 4 Complete (Fleet Automation!)
- [ ] Phase 5 Complete (Outpost)
- [ ] Phase 6 Complete (V1 DONE! 🎉)

---

## 💡 Development Notes

**Keep in mind:**
- Chill > Stress: Hvis noget føles stressende, simplificer
- Automation er belønning: Først gør du det selv → så designer du systemet
- Progress skal være synlig: Efter 30 min skal imperiet føles større

**Testing hver phase:**
- Spil i 5 minutter
- Er det tilfredsstillende?
- Er det chill?
- Hvis nej → fjern/simplificer før næste phase
