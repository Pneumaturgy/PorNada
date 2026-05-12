# Entity & Player Core

## Entity (`entity.gd`)
The `Entity` class is the base class for all characters in the game (including the player and enemies). It inherits from `CharacterBody2D` and manages basic properties and life cycles.

### Key Features
- **Property Management**: Uses a `properties` dictionary to store `health`, `defense`, and `speed`.
- **Runtime Persistence**: `runtime_properties` are initialized from `properties` at start.
- **Triggers**: Implements `check_triggers` and `health_triggers` to handle side effects like death when health reaches zero.
- **Death**: The `die()` function removes the entity from the scene tree.

---

## Player (`player.gd`)
The `Player` class inherits from `Mech` (which likely inherits from `Entity`). It adds player-specific logic like input handling, inventory, and weapon systems.

### Movement & Inputs
- **Mobile Support**: Supports touch-based movement and aiming through signals from `MobileUiOverlay`.
- **PC Inputs**: Uses standard `Input.get_vector` and mouse aiming (`look_at`).
- **Rotation**: Syncs rotation with aiming direction (mouse or touch).

### Weapon System
- **Payloads**: The player fires projectiles defined as `PackedScene` (Payloads).
- **Fire Rate**: Controlled via `FireRateTimer` and `fire_rate` property.
- **Collision**: Player projectiles are set to layer 8 and mask 2 (Enemies) by default.

### Inventory
- **Slots**: Configurable `current_inventory_slots`.
- **UI**: Toggles inventory visibility and pauses player controls when open.

### HUD Integration
- **Progress Bar**: Automatically updates the player's health bar via `update_ui`.
