# 🎫 Project Tickets

This document tracks all planned features and technical tasks for **Por Nada**. Every task must follow the ticket template below.

---

## 🛠️ Ticket Template

## Ticket Title
*Status: [Status]*
### User Story (as a, i'd like to, so that)

- **Context**: (why)
- **Description**: (What)
- **Requirements**: (how)

### Acceptance criteria (Gherkin language)

- **Estimated complexity**: 
- **Risk assessment**: 

---

## Fix Top-Left Bias in Procedural Generation
*Status: [Done]*

### User Story
As a player, I'd like to encounter environmental details across the entire map, so that the world doesn't feel empty as I explore further from the start.

- **Context**: The `procedural_background.gd` script stops generating instances as soon as `instance_count` is reached. Since it iterates from the top-left (0,0), this causes a "clumping" effect in the top-left corner of the world.
- **Description**: Refactor the distribution logic to ensure the `instance_count` is spread across all valid noise points.
- **Requirements**: 
    - Modify `Scripts/procedural_background.gd`.
    - Either collect all valid points and pick a random subset, or adjust the `spawn_chances` logic to be more holistic.

### Acceptance criteria
- **Given** a map size of 512x512
- **When** the environment is generated
- **Then** objects should be found in all corners of the map (Top-Left, Top-Right, Bottom-Left, Bottom-Right) provided the noise allows it.

- **Estimated complexity**: Medium
- **Risk assessment**: Low (Purely logic-based, doesn't affect rendering performance).

---

## Implement Random Scaling for Environment Objects
*Status: [Planned]*

### User Story
As a designer, I'd like environmental objects to have varying sizes, so that the forest and debris fields look more organic and visually diverse.

- **Context**: Currently, all objects in a `MultiMeshInstance2D` use the default 1:1 scale, making patterns look repetitive.
- **Description**: Add a randomization factor to the scale of each instance during generation.
- **Requirements**:
    - Update `generate_new_terrain` in `Scripts/procedural_background.gd`.
    - Apply a `randf_range` (e.g., 0.8 to 1.2) to the Transform2D scale.

### Acceptance criteria
- **Given** a MultiMesh with multiple instances
- **When** the environment generates
- **Then** instances should have slightly different sizes from one another.

- **Estimated complexity**: Low
- **Risk assessment**: Low.

---

## Export `grid_step` Variable for Environmental Density
*Status: [Planned]*

### User Story
As a level designer, I'd like to adjust the distance between environmental objects from the Godot Inspector, so that I can quickly iterate on map density.

- **Context**: The spacing between objects is currently hardcoded at `100` pixels in the script.
- **Description**: Replace the hardcoded `100` multiplier with an exported variable.
- **Requirements**:
    - Add `@export var grid_step : int = 100` to `procedural_background.gd`.
    - Update the position calculation to use `grid_step`.

### Acceptance criteria
- **Given** a `ProceduralBackground` node
- **When** I change the `grid_step` in the Inspector
- **Then** the objects in the world should move closer or further apart accordingly.

- **Estimated complexity**: Low
- **Risk assessment**: Low.
