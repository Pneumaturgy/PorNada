# Global Infrastructure & Saving

The backbone of the game's state and data management.

## Global Autoload (`Global.gd`)
A singleton script that persists throughout the entire game session.

### Save System
Uses encrypted local files with a shared password (`por_nada`).
- **Save Path**: `user://por_nada.save` (General data).
- **Progress Path**: `user://por_nada_progress.save` (Wins and Stage progress).
- **Encryption**: Uses `FileAccess.open_encrypted_with_pass` for security.

### Game State
- `current_stage`: Tracks the current level or wave.
- `total_wins`: Tracks lifetime wins.
- `current_alien_count`: Used by the spawner to cap enemy density.

---

## Utilities (`utils.gd`)
Contains helper functions for common operations (e.g., math helpers, group management).

## Main Controller (`Main.gd`)
The root node of the gameplay scene. It handles high-level events like starting waves, game over states, and scene transitions. It coordinates between the player, spawner, and UI overlays.
