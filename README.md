# Spil
Et hygge projekt – et lille Godot 2D space‑mining prototype.

## Status (nu)
- **Phase 1 implementeret** med mining loop, base station economy, cargo-upgrade og ny minimap-navigation.
- Klar til playtest af mining → sell → upgrade loop før Phase 2.

## Controls
- **Left‑click på asteroid**: Flyv til asteroid og start mining
- **Right‑click anywhere**: Manuel bevægelse (afbryder mining)
- **Flyv til base station**: Åbner sell/upgrade menu

## Struktur (kort)
- `scenes/` – Godot‑scener (main, ship, asteroids, base station, HUD, minimap)
- `scripts/phase0/` – Movement og camera
- `scripts/phase1/` – Mining, economy, base station, HUD
- `scripts/ui/` – UI-komponenter (fx minimap)
- `assets/` – placeholder sprites
- `docs/` – roadmap, regler og fase‑status

## Docs
- `docs/CURRENT_PHASE.md` – nuværende fokus og fase‑regler
- `docs/TODO.md` – roadmap for alle faser
- `docs/DEVELOPMENT_RULES.md` – regler for scope og workflow
- `docs/CLAUDE.md` – guidance til AI‑assistenter
