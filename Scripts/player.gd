extends Mech
class_name Player

@export var joypad_dead_zone = 0.1
@onready var current_payload = preload("res://Scenes/Payloads/DamagePayload.tscn")
@onready var aiming_direction = $AimingDirection
var firing_offset = 20


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
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
		
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("TEMP_fire"):
			#print('yeah')
			fire(current_payload)

func _physics_process(delta):
	get_input()
	move_and_slide()

func fire(payload):
	var direction = (aiming_direction.global_position - self.global_position).normalized()
	print('firing: ', payload)
	var new_payload = payload.instantiate()
	new_payload.global_position = aiming_direction.global_position + (direction * firing_offset)
	new_payload.direction = direction
	new_payload.rotation = self.rotation
	get_parent().add_child(new_payload)
