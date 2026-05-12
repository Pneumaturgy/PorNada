# Mobile UI & Overlay

The game includes a specialized mobile interface for touch-based devices.

## Mobile UI Overlay (`MobileUIOverlay.gd`)
A `CanvasLayer` that provides dual virtual joysticks for movement and aiming.

### Joystick Implementation
- **Dynamic Instantiation**: Joysticks are created at the touch position and removed when the touch ends.
- **Left Side**: Dedicated to movement (`touch_move_vector`).
- **Right Side**: Dedicated to aiming and firing (`touch_aim_vector`).

### Input Emulation
- **Fire Action**: The overlay automatically triggers the "fire" input action when the aim joystick is pulled beyond the `deadzone_radius`.
- **Speed Multiplier**: Calculates a `speed_multiplier` (0.0 to 1.0) based on how far the movement joystick is pulled, allowing for analog-style movement.

### HUD Elements
- **Aiming Direction**: A visual indicator of where the player is currently aiming.
- **Progress Bars**: Displays player health and other vital stats on the mobile screen.
