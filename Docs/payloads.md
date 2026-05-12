# Payload & Projectile System

The `Payload` system handles all projectiles and their associated behaviors. It uses a strategy-based approach to separate stats from movement and spawn logic.

## Payload (`payload.gd`)
A `Payload` is an `Area2D` that moves through the world and applies effects upon contact with an `Entity`.

### Components
- **Stats Resource**: `payloadStatsResource` defines speed, damage (deltas), and lifetime.
- **Behavior Resource**: `payloadBehaviorResource` determines the movement strategy (e.g., chasing).
- **Spawn Resource**: `payloadSpawnResource` determines how the payload is initialized or if it spawns children.

### Lifecycle
1. **Ready**: Initializes strategies and starts a death timer based on `timeToLive`.
2. **Process**: Moves based on the `payload_behavior_strategy`.
3. **Collision**: When it enters a body, it calls `apply_effects` and triggers `hit_effect` before destroying itself.

---

## Payload Resources

### PayloadStats (`base_payload_stats.gd`)
Defines the numerical properties of a projectile:
- `bullet_speed`: Movement velocity.
- `timeToLive`: Expiration time in seconds.
- `affected_properties_with_deltas`: A dictionary defining how much health, defense, or speed is changed on the target.
- `fire_rate`: Delay between shots.
- `spawn_children`: Boolean flag for multi-stage projectiles.

### Movement & Spawn Strategies
The system supports multiple strategies for varied projectile types (e.g., missiles, shotguns, linear shots). Strategies are initialized via the respective resource files.
