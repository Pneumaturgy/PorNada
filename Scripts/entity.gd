extends CharacterBody2D


@export var speed = 300.0
@export var joypad_dead_zone = 0.1
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var look = false
var isJoypadConnected = Input.get_connected_joypads().size() > 0

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed


func _input(event):
	if event is InputEventMouseMotion:
		look_at(get_global_mouse_position())
		
	if event is InputEventJoypadMotion:
		var input_aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		if abs(input_aim_direction.x) >= joypad_dead_zone or abs(input_aim_direction.y) >= joypad_dead_zone:
			self.rotation = input_aim_direction.angle()


func _physics_process(delta):
	get_input()
	move_and_slide()
