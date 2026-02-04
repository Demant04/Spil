# 🚨 Development Rules - READ THIS FIRST

## For AI Assistants (Claude Code, Copilot, Cursor, etc.)

**CRITICAL: These rules prevent scope creep and keep development focused.**

---

## Rule 1: ONLY Build Current Phase

**Before writing ANY code:**
1. Open and read `CURRENT_PHASE.md`
2. Check which Phase we're in (look at the title)
3. Only build tasks that have `[ ]` unchecked boxes in that phase
4. Do NOT build anything from future phases, even if it "makes sense"

**Example:**
- If we're in Phase 0 (movement), do NOT add mining mechanics
- If we're in Phase 1 (mining), do NOT add pirates or fleet
- If human asks for Phase 3 feature while in Phase 1, politely remind them

---

## Rule 2: No "Future-Proofing"

**Bad examples (DON'T DO THIS):**
- "I'll add a fleet manager class for later phases"
- "Let me prepare the resource system architecture for Phase 2"
- "I'll make this extensible for when we add factions"

**Good examples (DO THIS):**
- "Here's simple movement code for Phase 0"
- "This mining system works for Phase 1, we can expand later"
- "Basic cargo storage, exactly what current phase needs"

**Philosophy:** Build EXACTLY what current phase needs. Nothing more.

---

## Rule 3: Stop and Ask When Phase is Done

**When all `[ ]` are checked in CURRENT_PHASE.md:**

1. STOP coding
2. Tell human: "Phase X is complete! Test it before we continue."
3. Do NOT automatically start next phase
4. Wait for human to update CURRENT_PHASE.md

**DO NOT:**
- "Since we're done with Phase 1, let me start Phase 2"
- Automatically implement next phase
- Assume human wants to continue immediately

---

## Rule 4: Remind About Scope

**If human asks for feature from wrong phase:**

```
"That's a [Phase X] feature, but we're currently in Phase Y.
Should we:
A) Finish Phase Y first (recommended)
B) Skip to Phase X (might break things)
C) Add it as a note to Phase X for later"
```

**Only proceed with B if human explicitly says so.**

---

## Rule 5: Simple Over Clever

We're building a **proof of concept**, not production code.

**Priorities:**
1. Does it work?
2. Is it clear and readable?
3. Can we build on it next phase?

**NOT priorities:**
- Perfect architecture
- Zero technical debt
- Enterprise patterns
- Over-optimization

**Examples:**
- Hardcoded values in Phase 0/1 = OK
- Global variables for quick prototyping = OK (but comment them)
- Placeholder graphics = OK
- Copy-paste for 2 similar things = OK (we'll refactor if needed)

---

## Rule 6: Test Before Moving On

**After each phase:**
- Human must test for at least 10 minutes
- Check CURRENT_PHASE.md testing checklist
- If anything feels wrong, fix it before next phase

**This prevents:**
- Building on broken foundation
- Discovering Phase 0 bugs in Phase 4
- Having to redo entire systems

---

## Phase Transition Checklist

**When moving to next phase:**

```bash
# 1. Human tests current phase
# 2. All checkboxes in CURRENT_PHASE.md are checked
# 3. Human commits:
git add .
git commit -m "Phase X complete - [brief description]"

# 4. Human updates CURRENT_PHASE.md to next phase
# 5. Human commits again:
git commit -m "Starting Phase Y"

# 6. NOW AI can build Phase Y features
```

---

## Emergency Break Rules

**AI must STOP and ask human if:**
- Code starts feeling overly complex for current phase
- Implementation takes more than 2 hours
- You're tempted to build "just one small thing" from future phase
- Human seems confused about what phase we're in
- Feature request conflicts with "Chill Empire" philosophy

---

## Code Quality Guidelines

### Comments
- Explain WHY, not WHAT
- Mark TODOs for future phases clearly
- Example: `# TODO Phase 4: Replace with proper fleet manager`

### File Organization
```
/scripts
  /phase0  # Movement
  /phase1  # Mining
  /phase2  # Resources
  ...
```

### Naming
- Clear over clever: `player_ship` not `ps` or `protagonist_vessel`
- Functions describe action: `mine_asteroid()` not `process()`

### Testing
- Test current phase features manually
- No automated tests until Phase 6 (keep it simple)

---

## Current Status

**Active Phase:** Phase 0 - Foundation (implemented, awaiting playtest)
**Last Updated:** 3. februar 2026
**Next Phase:** Phase 1 - Core Mining Loop (NOT YET!)

---

## Quick Reference

| Phase | Focus | Don't Build Yet |
|-------|-------|-----------------|
| 0 | Movement | Mining, resources, enemies |
| 1 | Mining loop | Multiple resources, zones |
| 2 | Resources & zones | Pirates, fleet |
| 3 | Pirates & risk | Fleet, automation |
| 4 | Fleet & automation | Outposts, polish |
| 5 | Outposts | Victory condition, polish |
| 6 | Polish & victory | Anything in Backlog |

---

## Philosophy Reminder

**This game is about:**
- ✅ Chill progression
- ✅ Satisfying automation
- ✅ Building an empire over time

**This game is NOT about:**
- ❌ Stressful combat
- ❌ Complex management simulation
- ❌ Competitive speedrunning
- ❌ Permadeath frustration

**If a feature makes the game less chill: simplify or remove it.**

---

## For Human Developer

**If AI breaks these rules:**
1. Remind them to read DEVELOPMENT_RULES.md
2. Point to specific rule violated
3. Ask them to revert and follow rules

**If you want to override:**
- That's fine! It's your project
- Just update CURRENT_PHASE.md explicitly
- Commit with clear message about why

---

**Remember: Finish one phase completely before starting the next. Slow and steady wins the race! 🚀**
