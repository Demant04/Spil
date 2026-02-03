# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with this repository.

## Project Overview

**Spil** is a Danish hobby project ("Et hygge projekt" - a cozy project). The name "Spil" means "Game" in Danish.

## Repository Structure

```
Spil/
├── .github/workflows/   # GitHub Actions CI configuration
│   └── blank.yml        # Basic CI workflow
├── README.md            # Project readme
└── CLAUDE.md            # This file
```

## Development Guidelines

- This is an early-stage project with minimal structure
- The project uses GitHub Actions for CI (triggers on push/PR to main branch)

## CI/CD

The project has a basic GitHub Actions workflow that:
- Runs on pushes and pull requests to the `main` branch
- Can be triggered manually via workflow_dispatch
- Currently runs placeholder echo commands (ready to be configured with actual build/test steps)
