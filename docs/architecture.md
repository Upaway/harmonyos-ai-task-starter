# Architecture Overview

## Context

`Just Start` is a Stage-model HarmonyOS NEXT app focused on a simple productivity loop.

Core user flow:

1. Input task
2. Confirm duration
3. Focus timer session
4. Session result
5. Daily stats and settings

## Module Layout

- `AppScope/`: app-level metadata and resources
- `entry/`: main application module
- `docs/`: product, release, and workflow documentation

Inside `entry/src/main/ets/`:

- `pages/`: route-level pages
- `components/`: reusable UI components
- `viewmodels/`: page state + orchestration
- `models/`: typed domain models
- `storage/`: local persistence access
- `constants/`: visual and copy constants
- `utils/`: helper utilities

## Architectural Principles

- Local-first: v0.1 stores data on device.
- Flow-first: preserve end-to-end usability before advanced features.
- Separation of concerns: UI, state, and persistence are decoupled.
- Incremental AI: v0.2 AI capability should integrate without breaking v0.1 core flow.

## Data Model (High-Level)

- Focus session records
- Daily statistics
- User preference (for example, default focus duration)

All models should remain serialization-friendly for local storage.

## Release Boundary

- v0.1 runnable MVP != AppGallery release readiness.
- AppGallery release additionally requires signed artifacts, compliance docs, and store assets.