# Inventory & Dropped Resources

## Inventory System (`inventory.gd`)
The inventory system manages items collected by the player. It is a `CanvasLayer` that visualizes a grid of slots.

### Features
- **Dynamic Setup**: Automatically creates a grid of `inventory_slot.tscn` instances based on `player.current_inventory_slots`.
- **Item Indexing**: Uses an `index` dictionary to quickly find which slot contains a specific item (by identifier).
- **Stacking**: Items of the same type are added to existing stacks before occupying new slots.
- **Signal Integration**: Connects to the `player.collected` signal to process new drops.

---

## Dropped Resources (`drop_resource.gd`)
Drops are resources that appear in the game world when an entity is defeated.

### Drop Resource
- `item_identifier`: A string key used for inventory indexing.
- `item_image`: The icon displayed in the inventory.
- `min_quantity_multiplier` / `max_quantity_multiplier`: Defines the range of items contained in a single drop.

### Drop Object
The physical world object (likely `drop_object.gd`) that handles collision with the player to trigger the `collected` signal. When collected, the inventory updates its counts and the drop object is destroyed.
