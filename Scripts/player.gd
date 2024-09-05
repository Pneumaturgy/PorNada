extends Mech
class_name Player

signal player_died
signal collected(drop)

@export var mobile_controls = true
@export var joypad_dead_zone = 0.1
@export var current_payload : PackedScene
@export var fire_rate = 0.3

## Inventory Variables
#const INVENTORY_SLOT = preload("res://Scenes/Player/inventory_slot.tscn")
@export var current_inventory_slots = 4
#var max_inventory_slots = 32
#@export var inventory_items = [InventoryItem]
@onready var inventory = $Inventory


@onready var aiming_direction = $AimingDirection
@onready var fire_rate_timer = $FireRateTimer
@onready var progress_bar = $PlayerHud/Control/ProgressBar

var firing_offset = 20
var can_fire = false
var weapon_ready = true
var disable_player_controls = false
var touch_move_vector = Vector2(0, 0)
var touch_aim_vector = Vector2(0, 0)
var speed_multiplier : float

var inventory_2: Dictionary # TODO: Transform into its own class / node, to communicate with Signals. Also, convert inventory contents to arrays within resources

func _ready():
	#collected.connect(on_collected)
	check_mobile_controls()
	fire_rate_timer.wait_time = fire_rate
	progress_bar.value = self.properties["health"]
	inventory_2 = {}

func check_mobile_controls():
	if mobile_controls:
		$MobileUiOverlay.visible = true
	else:
		$MobileUiOverlay.visible = false

#region Input Vectors

func get_input():
	if !disable_player_controls:
		if !mobile_controls:
			var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
			velocity = input_direction * get_property("speed")
		else:
			velocity = touch_move_vector * (speed_multiplier * get_property("speed"))
	else:
		velocity = Vector2(0,0)
func _on_mobile_ui_overlay_use_touch_move_vector(move_vector):
	if mobile_controls:
		touch_move_vector = move_vector


func _on_mobile_ui_overlay_use_touch_aim_vector(aim_vector):
	if mobile_controls:
		touch_aim_vector = aim_vector
		self.rotation = aim_vector.angle()


func _on_mobile_ui_overlay_use_touch_move_multiplier(_speed_multiplier):
	if mobile_controls:
		speed_multiplier = _speed_multiplier


#endregion

func _input(event):
	if !disable_player_controls:
		if event is InputEventMouseButton:
			can_fire = event.pressed

		if Input.is_action_just_pressed("fire"):
			if weapon_ready:
				fire(current_payload)
				weapon_ready = false
		
		if event is InputEventMouseMotion and !mobile_controls:
			look_at(get_global_mouse_position())
			
		if event is InputEventJoypadMotion and !mobile_controls:
			var input_aim_direction = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
			if abs(input_aim_direction.x) >= joypad_dead_zone or abs(input_aim_direction.y) >= joypad_dead_zone:
				self.rotation = input_aim_direction.angle()
		
		if event is InputEventKey:
			if Input.is_action_just_pressed("ui_cancel"):
				get_tree().quit()
	if event is InputEventKey:
		if Input.is_action_just_pressed("open_inventory"):
			toggle_inventory() # TODO : Take this out of the else

func _physics_process(_delta):
	get_input()
	move_and_slide()
	

func toggle_inventory():
	inventory.visible = !inventory.visible
	disable_player_controls = !disable_player_controls
	#return inventory_open



func fire(payload):
	fire_rate_timer.start()
	var direction = (aiming_direction.global_position - self.global_position).normalized()
	var new_payload = payload.instantiate()
	new_payload.direction = direction
	new_payload.global_position = aiming_direction.global_position + (direction * firing_offset)
	new_payload.rotation = self.rotation
	get_parent().add_child(new_payload)

func _on_fire_rate_timer_timeout():
	weapon_ready = true
	if can_fire:
		fire(current_payload)

func update_ui(property, delta):
	if property == "health":
		progress_bar.value = self.properties["health"]

func die():
	player_died.emit()
