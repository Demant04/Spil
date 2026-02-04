# 🎯 Current Focus: Phase 0 - Foundation

**What we're building RIGHT NOW:**
- [x] Opret Godot projekt (åbn Godot, lav nyt 2D projekt)
- [x] Basic 2D space scene (sort baggrund, få stjerner som decoration)
- [x] Player ship sprite + click-to-move input (right-click)
- [x] Ship bevægelse (acceleration, max speed, rotation mod bevægelsesretning)
- [x] Kamera følger ship (smooth camera follow)
- [x] Right-click navigation (click-to-move med NavigationAgent2D)

**Done when:** Du kan flyve rundt i tomt rum og det føles smooth

---

## ⛔ DO NOT BUILD YET:

### Phase 1 features (kommer EFTER Phase 0):
- Mining mechanics
- Asteroids
- Resources
- Base station
- Economy/credits
- Upgrades

### Phase 2+ features:
- Multiple resources
- Zones
- Pirates
- Fleet system
- Automation
- Outposts
- Anything else from TODO.md

**If you're tempted to build these:** STOP. Finish Phase 0 first. Test it. Make it feel good.

---

## Testing Checklist før vi går videre til Phase 1:

- [x] Kan jeg bevæge mig smooth og responsive?
- [x] Føles acceleration naturlig (ikke instant teleport)?
- [x] Roterer skibet pænt når jeg drejer?
- [x] Følger kameraet skibet uden at være rykket?
- [x] Kører det uden lag på min computer?
- [x] Er koden organiseret og kommenteret?
- [x] Har jeg testet i mindst 5 minutter?

### Questions to ask yourself:
- Er det *chill* at flyve rundt?
- Føles bevægelsen som et rumskib?
- Ville jeg gerne mine asteroider med denne control?

**If any answer is "no":** Fix it before moving to Phase 1!

---

## 📝 Notes for Phase 0

**Keep it simple:**
- Ship kan bare være en simpel trekant (placeholder sprite OK)
- Stjerner kan være små hvide dots
- Fokus er på bevægelse og feel, ikke grafik

**Technical hints:**
- Brug CharacterBody2D for ship
- Use `move_and_slide()` for smooth movement
- Linear interpolation (lerp) for camera smooth follow
- Max speed cap så skibet ikke bliver ucontrollable
- Right-click navigation for click-to-move (with pathfinding ready)

---

## ✅ When Phase 0 is DONE:

1. Test thoroughly (play for 10+ minutes)
2. Commit to git: `git commit -m "Phase 0 complete - Basic movement works"`
3. Update this file to Phase 1
4. Commit again: `git commit -m "Starting Phase 1 - Mining Loop"`
5. THEN start building Phase 1 features

---

**Next Phase Preview:** Phase 1 - Core Mining Loop
- But we're NOT there yet!
- Finish Phase 0 first!

**Current Status:** ✅ COMPLETE - Playtest godkendt!
**Started:** 3. februar 2026
**Completed:** 4. februar 2026
