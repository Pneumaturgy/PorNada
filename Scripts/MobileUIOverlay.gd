extends CanvasLayer

signal use_touch_move_vector
signal use_touch_move_multiplier
signal use_touch_aim_vector
const JOYSTICK = preload("res://Scenes/Joystick.tscn")
var touch_move_joystick = null
var touch_aim_joystick = null
var touch_move_vector : Vector2
var touch_aim_vector : Vector2
var touches = {}  # Dictionary to keep track of touches and their associated joysticks
var touch_1_index : int
var touch_2_index : int
var deadzone_radius : float = 100
var raw_touch_move_vector : Vector2
var raw_touch_aim_vector : Vector2
var speed_multiplier : float


func _physics_process(_delta):
	if touch_move_joystick:
		emit_signal("use_touch_move_vector",touch_move_vector)
		speed_multiplier = calculate_speed_multiplier(raw_touch_move_vector)
		emit_signal("use_touch_move_multiplier",speed_multiplier)
	else:
		emit_signal("use_touch_move_vector",Vector2(0,0))
	
	if touch_aim_joystick:
		emit_signal("use_touch_aim_vector",touch_aim_vector)
		check_and_trigger_fire(raw_touch_aim_vector)
	else:
		emit_signal("use_touch_aim_vector",Vector2(0,0))


func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			var touch_position = event.position
			var is_left_side = touch_position.x < get_viewport().get_visible_rect().size.x / 2
			# Handle touch input here
			if is_left_side: # Left side touch
				if !touch_move_joystick and !touches.has(event.index):
					touch_move_joystick = JOYSTICK.instantiate()
					add_child(touch_move_joystick)
					touches[event.index] = touch_move_joystick
					touch_move_joystick.global_position = event.position - Vector2(128,128)
			else: # Right side touch
				if !touch_aim_joystick and !touches.has(event.index):
					touch_aim_joystick = JOYSTICK.instantiate()
					add_child(touch_aim_joystick)
					touches[event.index] = touch_aim_joystick
					touch_aim_joystick.global_position = event.position - Vector2(128,128)
		else:
			if touches.has(event.index):
				var joystick = touches[event.index]
				if joystick == touch_move_joystick:
					touch_move_joystick.queue_free()
					touch_move_joystick = null
				if joystick == touch_aim_joystick:
					touch_aim_joystick.queue_free()
					touch_aim_joystick = null
				touches.erase(event.index)

	elif event is InputEventScreenDrag:
		if touches.has(event.index):
			var joystick = touches[event.index]
			joystick.get_child(0).global_position = event.position
			if joystick == touch_move_joystick:
				raw_touch_move_vector = (event.position - (touch_move_joystick.global_position + Vector2(128, 128)))
				touch_move_vector = raw_touch_move_vector.normalized()
			elif joystick == touch_aim_joystick:
				raw_touch_aim_vector = (event.position - (touch_aim_joystick.global_position + Vector2(128, 128)))
				touch_aim_vector = raw_touch_aim_vector.normalized()

func check_and_trigger_fire(aim_vector : Vector2):
	if aim_vector.length() > deadzone_radius:
		Input.action_press("fire")
	else:
		Input.action_release("fire")
	
func calculate_speed_multiplier(move_vector : Vector2):
	var distance = move_vector.length()
	var clamped_distance = min(distance, deadzone_radius)
	return clamped_distance / deadzone_radius
