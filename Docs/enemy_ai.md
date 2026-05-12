# Enemy AI & Strategies

Enemy AI in PorNada is built on a modular strategy pattern, allowing for different movement behaviors without rewriting core enemy logic.

## AI Movement Strategies

### Alien Movement Strategy (`alien_movement_strategy.gd`)
The base chasing behavior.
- **Logic**: Calculates a direct vector from the enemy to the player and applies the enemy's speed.

### Teleport Movement Strategy
(Inherits the same interface)
- **Logic**: Likely handles periodic snapping to positions near the player or specific waypoints.

---

## Enemy Resources

### AlienResource (`alien_resource.gd`)
A data container used to define an enemy's behavior profile.
- **MOVEMENT_STRATEGIES**: An enum mapping strategy types to their implementation classes.
- **Behavior Injection**: The `get_chasing_movement_strategy()` function instantiates and returns the appropriate strategy based on the resource's configuration.

## Implementation Details
Enemies (like `alien.gd`) use these resources at runtime to determine how to approach or attack the player. This allows for quick iteration by simply swapping out a `.tres` file in the inspector.
