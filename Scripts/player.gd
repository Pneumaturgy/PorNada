extends Mech
class_name Player

@export var joypad_dead_zone = 0.1
@export var current_payload : PackedScene
@export var fire_rate = 0.3

@onready var aiming_direction = $AimingDirection
@onready var fire_rate_timer = $FireRateTimer

## Mobile Controls Feature Flag. 
## Ensure you enable visibility of the overlay if you tick this.
@export var use_mobile : bool

var firing_offset = 20
var weapon_ready = true

var touch_move_vector = Vector2(0, 0)
var touch_aim_vector = Vector2(0, 0)
var speed_multiplier : float
#@onready var player_animation = $CharacterSprite/PlayerAnimation

func _ready():
	fire_rate_timer.wait_time = fire_rate

#region Input Vectors

func get_input():
	if !use_mobile:
		var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = input_direction * get_property("speed")
	else:
		velocity = touch_move_vector * (speed_multiplier * get_property("speed"))

func _on_mobile_ui_overlay_use_touch_move_vector(move_vector):
	if use_mobile:
		touch_move_vector = move_vector


func _on_mobile_ui_overlay_use_touch_aim_vector(aim_vector):
	if use_mobile:
		touch_aim_vector = aim_vector
		self.rotation = aim_vector.angle()


func _on_mobile_ui_overlay_use_touch_move_multiplier(_speed_multiplier):
	if use_mobile:
		speed_multiplier = _speed_multiplier


#endregion

func _input(event):
	if event is InputEventMouseMotion and !use_mobile:
		look_at(get_global_mouse_position())
		
	if event is InputEventJoypadMotion and !use_mobile:
		var input_aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
		if abs(input_aim_direction.x) >= joypad_dead_zone or abs(input_aim_direction.y) >= joypad_dead_zone:
			self.rotation = input_aim_direction.angle()
	
	if event is InputEventKey:
		if Input.is_action_just_pressed("ui_cancel"):
			get_tree().quit()
	
	if Input.is_action_pressed("fire") and weapon_ready:
		
		fire(current_payload)
		weapon_ready = false
		fire_rate_timer.start()

func _physics_process(_delta):
	get_input()
	move_and_slide()

func fire(payload):
	var direction = (aiming_direction.global_position - self.global_position).normalized()
	#print('firing: ', payload)
	var new_payload = payload.instantiate()
	new_payload.direction = direction
	new_payload.global_position = aiming_direction.global_position + (direction * firing_offset)
	new_payload.rotation = self.rotation
	get_parent().add_child(new_payload)
	#player_animation.play("player_shoot")

func _on_fire_rate_timer_timeout():
	weapon_ready = true





