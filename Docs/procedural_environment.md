# Procedural Environment & Background

PorNada uses a noise-based distribution system to randomly generate environment details and background objects using Godot's `MultiMeshInstance2D`.

## Procedural Background (`procedural_background.gd`)
The `ProceduralBackground` node handles the efficient rendering and distribution of thousands of static environment objects.

### How it Works
1. **MultiMesh Setup**: The script identifies all `MultiMeshInstance2D` children. It uses MultiMeshes for high-performance rendering of many identical meshes in a single draw call.
2. **Noise Generation**: It generates a `FastNoiseLite` (Perlin noise) texture at runtime with a random seed.
3. **Distribution Logic**:
   - The script iterates through the pixels of the noise image.
   - It checks the "height" (grayscale value) of the noise at each pixel.
   - If the value falls within a specified `ranges_array` for a given mesh type, it potentially places an instance.
   - **Spawn Chance**: A `spawn_chances` multiplier is applied to further thin out the distribution.
   - **Variance**: Adds random positional offsets (`variance_multiplier`) to prevent rigid grid-like alignment.

### Configuration (Exported Variables)
- `spawn_chances`: The percentage chance (0-100) that a valid noise point will actually spawn an instance.
- `variance_multiplier`: The maximum random distance an object can be shifted from its grid point.
- `ranges_array`: Defines the "altitude" or noise threshold (Min/Max) where each object type is allowed to appear.

## Performance Benefits
By using `MultiMeshInstance2D` instead of individual `Sprite2D` nodes, the game can display dense environments (forests, debris fields, etc.) with minimal CPU and GPU overhead. The generation happens once at `_ready()`, ensuring smooth gameplay afterwards.

## Tips for Content Creation
- **Layering**: You can layer multiple `MultiMeshInstance2D` nodes to create complex environments (e.g., small grass on low noise values, large rocks on high values).
- **Seeds**: Change the seed in `create_new_noise()` or expose it to the inspector to allow for reproducible maps.
