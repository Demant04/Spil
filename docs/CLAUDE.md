# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this repository.

## Project Overview

**Spil** (Danish for "Game") is a hobby project building a **space mining empire game** in Godot.

**Vision:** A chill automation empire in space with relaxing progression and satisfying automation gameplay.

**Core Philosophy:**
- Chill > Stress: If something feels stressful, simplify it
- Automation is the reward: First you do it manually → then you design the automation
- Progress should be visible: After 30 minutes, the empire should feel bigger

**Technology Stack:**
- Engine: Godot (2D)
- Language: GDScript
- Version Control: Git + GitHub
- Development Style: Phased, incremental PoC approach

## Repository Structure

```
Spil/
├── assets/                # Sprites and placeholder art
├── scenes/                # Godot scenes (main, ship, star field)
├── scripts/               # GDScript code (phase-based)
├── docs/                  # Project docs (rules, roadmap, phase status)
│  ├── TODO.md             # Complete development roadmap (Phases 0-6)
│  ├── DEVELOPMENT_RULES.md# Critical rules for AI assistants
│  ├── CURRENT_PHASE.md    # Current phase focus and constraints
│  └── CLAUDE.md           # This file
├── project.godot          # Godot project file
└── README.md              # Simple project readme
```

## 🚨 CRITICAL: Read This Before Any Work

### Rule #1: Always Check Current Phase

**Before writing ANY code:**

1. **Read `docs/CURRENT_PHASE.md` first** - This tells you what phase we're in
2. **Only build features from the current phase** - Nothing from future phases
3. **Follow `docs/DEVELOPMENT_RULES.md`** - These prevent scope creep

**Current Status (as of 2026-02-03):**
- **Active Phase:** Phase 0 - Foundation (click-to-move ship movement)
- **Phase 0 Implementation:** Click-to-move navigation, star field, and smooth camera follow are in place.
- **DO NOT BUILD:** Mining, asteroids, resources, economy, pirates, fleet, automation, or anything from Phases 1-6

### Rule #2: Phase-Driven Development

This project uses **strict phased development**:

| Phase | Focus | Status |
|-------|-------|--------|
| 0 | Foundation - Basic ship movement | 🟡 Implemented, needs playtest |
| 1 | Core Mining Loop - Mine & sell | ⏸️ Not started |
| 2 | Resources & Zones - Multiple resources | ⏸️ Not started |
| 3 | Pirates & Risk - Combat mechanics | ⏸️ Not started |
| 4 | Fleet System - Automation begins | ⏸️ Not started |
| 5 | Outpost Unlock - Empire expansion | ⏸️ Not started |
| 6 | Polish & Victory - V1 complete | ⏸️ Not started |

**Phase Transition Rules:**
- ✅ Complete ALL tasks in current phase
- ✅ Test thoroughly (10+ minutes of gameplay)
- ✅ Human commits phase completion
- ✅ Human updates `docs/CURRENT_PHASE.md` to next phase
- ❌ DO NOT auto-start next phase
- ❌ DO NOT build "just one small thing" from future phases
- ❌ DO NOT add "future-proofing" or "extensible architecture"

### Rule #3: Simple Over Clever

This is a **proof of concept**, not production code.

**Good practices:**
- Hardcoded values in early phases = OK
- Placeholder graphics = OK
- Copy-paste for prototyping = OK
- Focus on making it work and feel good first

**Bad practices:**
- ❌ Enterprise architecture patterns
- ❌ Over-optimization
- ❌ Building features "for later phases"
- ❌ Complex abstractions before they're needed

## Development Workflow

### When User Asks for New Feature

```
1. Check docs/CURRENT_PHASE.md - Is this feature in the current phase?

   ✅ YES → Build it

   ❌ NO → Respond:
   "That's a [Phase X] feature, but we're currently in Phase Y.
   Should we:
   A) Finish Phase Y first (recommended)
   B) Skip to Phase X (might break things)
   C) Add it as a note for later"

   Only proceed with B if human explicitly confirms.
```

### When Phase is Complete

```
1. STOP coding
2. Tell human: "Phase X is complete! Test it before we continue."
3. DO NOT automatically start next phase
4. Wait for human to test and update docs/CURRENT_PHASE.md
```

### Emergency Stops

**Stop and ask human if:**
- Code feels overly complex for current phase
- Implementation takes more than 2 hours
- You're tempted to build something from a future phase
- Feature conflicts with "chill empire" philosophy

## Core Game Design (Locked for V1)

These decisions are **locked** and should not be questioned during V1 development:

- ✅ Real-time gameplay, but player can always flee to safety
- ✅ Mining: Click target area → ship mines automatically
- ✅ Ships: Slot-based system (Motor/Mining/Cargo/Weapon slots), NOT grid-based
- ✅ Outpost: Unlocks when you have 2+ ships
- ✅ Cargo: Per resource type (different resources take different space)
- ✅ No fuel system in V1 (keep it simple)
- ✅ Enemies: Sporadic pirate visits, NOT constant combat
- ✅ Base: Physical station you fly to in the game world

## Key Files Reference

### docs/TODO.md
Complete development roadmap with all phases detailed. Use this to understand the big picture, but remember: **only build current phase**.

### docs/DEVELOPMENT_RULES.md
Critical rules that prevent scope creep. Read this if you're ever unsure about what to build.

### docs/CURRENT_PHASE.md
**The most important file.** This is your source of truth for what to build right now. Always read this first.

## Code Organization (Current)

```
/scripts
  /phase0/     # Movement systems

/scenes/
  main.tscn
  player_ship.tscn
  star_field.tscn

/assets/
  /sprites/
    ship_placeholder.png
    star_white.png
```

**Note:** The current scenes use embedded PNG scripts for the ship and starfield sprites; placeholder assets remain in `assets/` for later use.

## Naming Conventions

- **Clear over clever:** `player_ship` not `ps` or `protagonist_vessel`
- **Functions describe actions:** `mine_asteroid()` not `process()`
- **Comments explain WHY, not WHAT**
- **Mark future TODOs:** `# TODO Phase 4: Replace with proper fleet manager`

## Testing Guidelines

- Manual testing only until Phase 6
- Test each phase for 10+ minutes before moving on
- Check if gameplay feels "chill" and satisfying
- If it feels stressful or frustrating → simplify

## CI/CD

Basic GitHub Actions workflow:
- Runs on pushes and pull requests to `main` branch
- Can be triggered manually via workflow_dispatch
- Currently placeholder (ready for Godot export/testing setup)

## Project Status

**Last Updated:** 2026-02-03
**Current Phase:** Phase 0 - Foundation (implemented, awaiting playtest)
**Victory Condition:** Phase 6 complete = 100k credits + 3 ships + 1 outpost + polished gameplay

## Quick Start for New Claude Sessions

1. Read `docs/CURRENT_PHASE.md` to see what phase we're in
2. Check which tasks have `[ ]` unchecked in that phase
3. Only work on those specific tasks
4. When asking for clarification, reference phase rules
5. Mark tasks complete in docs/CURRENT_PHASE.md as you finish them

## Language Notes

- Project uses Danish names/terms occasionally ("hygge projekt" = cozy project)
- Documentation is primarily in English
- Code comments can be in English or Danish
- Game might have Danish UI (TBD)

---

**Remember: One phase at a time. Finish, test, polish, then move forward. Slow and steady builds a great game! 🚀**
