extends CanvasLayer

signal use_move_vector
signal use_aim_vector
@onready var move_joystick = $Control/HSplitContainer/MoveJoystickControl/MoveJoystick
@onready var aim_joystick = $Control/HSplitContainer/AimJoystickControl/AimJoystick


## While this Overlay is active, the joysticks inside it will
## Pass on their values for whatever wants to use them.
func _physics_process(_delta):
	if move_joystick.joystick_active:
		emit_signal("use_move_vector",move_joystick.vector)
	else:
		emit_signal("use_move_vector",Vector2(0,0))
	if aim_joystick.joystick_active:
		emit_signal("use_aim_vector",aim_joystick.vector)
