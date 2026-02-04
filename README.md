# Spil
Et hygge projekt – et lille Godot 2D space‑mining prototype.

## Status (nu)
- **Phase 0 er FÆRDIG!** Basic scene, stjerner, click‑to‑move (right‑click) og smooth camera follow er testet og godkendt.
- Klar til Phase 1: Core Mining Loop (mining, asteroids, base station, economy).

## Controls
- Right‑click: sæt target‑position til click‑to‑move (NavigationAgent2D).

## Struktur (kort)
- `scenes/` – Godot‑scener (main, ship, star field)
- `scripts/` – GDScript (faseopdelt)
- `assets/` – placeholder sprites (pt. ikke i brug; ship/starfield bruger embedded PNG‑scripts)
- `docs/` – roadmap, regler og fase‑status

## Docs
- `docs/CURRENT_PHASE.md` – nuværende fokus og fase‑regler
- `docs/TODO.md` – roadmap for alle faser
- `docs/DEVELOPMENT_RULES.md` – regler for scope og workflow
- `docs/CLAUDE.md` – guidance til AI‑assistenter
