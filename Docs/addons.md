# Project Add-Ons

The PorNada project integrates several powerful add-ons to streamline development, testing, and visual effects.

## AI Assistant Hub
- **Purpose**: Embeds AI assistants directly into the Godot editor.
- **Key Features**:
  - **In-Editor Chat**: Talk to assistants without leaving the engine.
  - **Code Generation**: Assistants can read and write code directly in the Godot script editor.
  - **Context Aware**: Can be configured with project-specific prompts and knowledge.
- **Configuration**:
  - Plugin script: `ai_hub_plugin.gd`
  - Settings found in Project Settings under `Plugins` and `AI Assistant Hub`.

## Shader Toolkit
- **Purpose**: A collection of reusable shaders for UI and environment effects.
- **Key Shaders**:
  - **Glass Panel (`glass_panel.gdshader`)**: Provides a frosted glass / glassmorphism effect with adjustable blur, tint, and edge highlights.
- **Usage**: Apply the shader to a `ColorRect` or `Panel` and adjust the shader parameters in the inspector.

## GUT - Godot Unit Testing
- **Purpose**: A comprehensive utility for writing and running unit tests in Godot.
- **Key Features**:
  - **Assertions**: A wide range of assertion methods for data validation.
  - **Doubling**: Easily create test doubles (mocks/stubs) for scenes and scripts.
  - **GUI Test Runner**: An integrated panel to run tests and view results in real-time.
- **Documentation**: See [Testing with GUT](testing.md) for project-specific usage or visit the [GUT Wiki](https://gut.readthedocs.io/en/latest/).

---

## Managing Add-Ons
To enable or disable these add-ons, navigate to `Project / Project Settings / Plugins` in the Godot Editor. Ensure that plugins are enabled before attempting to use their associated features or nodes.
