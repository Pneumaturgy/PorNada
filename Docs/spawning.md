# Spawning & Spawn Tables

The spawning system manages enemy waves and difficulty progression using a weighted table approach.

## Alien Spawner (`AlienSpawner.gd`)
The main node responsible for instantiating enemies around the player.

### Features
- **Dynamic Difficulty**: Uses `update_difficulty()` to scale `current_max_aliens`, `spawn_frequency`, and `spawn_quantity` based on `Global.current_stage`.
- **Positional Logic**: Spawns enemies in a circular area outside the viewport using `minimal_distance` and `maximum_distance` calculations.
- **Spawn Table Integration**: Queries an `alien_spawn_table` to determine which type of alien to spawn.

---

## Spawn Table System

### SpawnTable (`SpawnTable.gd`)
A resource that maps stage numbers to specific enemy types and their weights.

- **Wildcards**: Supports a `*` (WILDCARD_STAGE) which can be used when a specific stage isn't defined.
- **Weighted Selection**: The `pick_an_alien_type()` function uses a "die roll" against the total weight of the current stage's entries to pick an enemy index.
- **Lookup Dictionary**: At runtime, the table pre-compiles `SpawnTableRow` data into a `spawnTableLookup` dictionary for efficient access.

### SpawnTableRow (`SpawnTableRow.gd`)
A simple data structure representing a single entry in a spawn table:
- `stage_number`: The specific stage this rule applies to.
- `alien_index`: The ID of the alien type in the spawner's list.
- `weight`: How likely this alien is to spawn relative to others.
