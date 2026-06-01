# Por Nada - Project Documentation Hub

Welcome to the **Por Nada** Godot repository. This project is a Godot-based game (Top-Down/Platformer) featuring a robust projectile system, dynamic enemy AI, and mobile-optimized UI.

## 🤖 Overview for Developers

1. **Architecture**: The project follows a modular design. Logic is separated into `Scripts/`, while visuals and scenes are in `Assets/` and `Scenes/`.
2. **Core Loop**: Managed by `Main.gd` and `Global.gd` (Autoload).
3. **Key Systems**:
   - **Payloads**: A flexible projectile and behavior system.
   - **Enemies**: Strategy-based AI movement and resource-driven enemy definitions.
   - **Spawning**: Table-driven spawn logic for dynamic difficulty.
   - **Inventory**: A lightweight inventory and resource dropping system.

---

## 🧩 Currently Available Add-Ons

The project utilizes several key add-ons to enhance development and testing:

- **AI Assistant Hub (`ai_assistant_hub`)**: An integrated editor plugin for LLM-assisted development and context generation.
- **Shader Toolkit (`shader`)**: Reusable shaders including `glass_panel.gdshader` for stylized UI.
- **GUT (Godot Unit Testing)**: The testing framework used for unit and integration tests located in `Tests/`.

---

## 📚 System Documentation Index

Detailed documentation for each system can be found in the `docs/` directory:

### Core Systems
- [**Entity & Player Core**](docs/entities.md) - Documentation for the base `entity.gd`, `player.gd`, and movement mechanics.
- [**Payload & Projectile System**](docs/payloads.md) - Deep dive into the `Payload` resource-based projectile system, including movement and spawn behaviors.
- [**Enemy AI & Strategies**](docs/enemy_ai.md) - Explains the `MovementStrategy` pattern and how to define new enemies using `EnemyResources`.
- [**Integrated Add-Ons**](docs/addons.md) - Documentation for the AI Assistant Hub, Shader Toolkit, and GUT.

### Procedural Generation
- [**Spawning & Spawn Tables**](docs/spawning.md) - How to use `SpawnTable` resources to manage enemy waves and difficulty scaling.
- [**Procedural Environment**](docs/procedural_environment.md) - Documentation on the noise-based `MultiMeshInstance2D` distribution system for background objects.

### Infrastructure & UI
- [**Inventory & Dropped Resources**](docs/inventory.md) - Details on the inventory system and how resources are dropped from defeated entities.
- [**Mobile UI & Overlay**](docs/mobile_ui.md) - Documentation for the mobile-optimized HUD and menu systems.
- [**Audio & Dynamic Music**](docs/audio.md) - Explains the state-based jukebox system and procedural music shuffling.

### Testing & Best Practices
- [**Testing with GUT**](docs/testing.md) - Guidelines for writing and running tests within the project.
- [**Global State & Utilities**](docs/global_infrastructure.md) - Documentation for `Global.gd` and the `utils.gd` helper library.

---

## 🚀 Quick Start

1. **Project Setup**: Open `project.godot` in Godot 4.x.
2. **Main Scene**: Run `res://Scenes/Levels/MainMenu.tscn` to start the game.
3. **Folder Conventions**:
   - `Assets/`: Textures, Sprites, Sounds.
   - `Scenes/`: Level and UI scenes.
   - `Scripts/`: GDScript files.
   - `Tests/`: Unit and Integration tests.

---

## 🗺️ Project Planning & Roadmap

All new features, bug fixes, and technical improvements are tracked in our centralized ticket system. 

> [!IMPORTANT]
> All new features and major changes MUST have a corresponding ticket in [**Tickets.md**](docs/Tickets.md) before implementation.

---

> *Note: This documentation is actively maintained. Please update the relevant `.md` files in `docs/` and ensure tickets are updated when introducing major system changes.*
