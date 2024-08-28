extends Node2D

signal alien_spawned(alien_instance)
#signal all_aliens_spawned

@export var default_spawn_frequency = 1
@export var default_spawn_quantity = 3
@export var default_alien_count: int = 50

@export var maximum_distance = 10
const alien_scene = preload("res://Scenes/Entities/Alien.tscn")


var current_max_aliens : int
var current_spawn_frequency : float
var current_spawn_quantity : int 

#var signal_check = true

@onready var timer = $Timer

func _ready():
	update_difficulty()
	

func _on_timer_timeout():
	for i in range(current_spawn_quantity):
		if Global.current_alien_count < current_max_aliens:
			spawn_aliens()
		#elif signal_check:
			#signal_check = false
			#all_aliens_spawned.emit()

func spawn_aliens():
	var minimal_distance = sqrt((get_viewport_rect().size.x / 1) ** 2 + (get_viewport_rect().size.y / 1) ** 2)
	var max_distance = minimal_distance * maximum_distance
	var distance = randf_range(minimal_distance, max_distance)
	#print("New enemy spawn at: ", str(distance), "minimal: ", str(minimal_distance), "maximum: ", max_distance)
	var angle = randf_range(0, 360)
	var x = cos(angle) * distance
	var y = sin(angle) * distance
	var alien_instance = alien_scene.instantiate()
	alien_instance.position = Vector2(global_position.x + x, global_position.y + y)
	#get_parent().add_child(alien_instance)
	#print(alien_instance.get_parent())
	alien_spawned.emit(alien_instance)
	Global.current_alien_count += 1
	#print("An alien was born, current count: ", Global.current_alien_count)

func update_difficulty():
	var difficulty_factor = log(Global.current_stage) / log(2)  # logarithmic scaling
	current_max_aliens = default_alien_count + int(difficulty_factor * 10)
	current_spawn_frequency = max(default_spawn_frequency - (difficulty_factor * 0.05), 0.1)
	current_spawn_quantity = default_spawn_quantity + int(difficulty_factor)
	print("current_max_aliens: ", current_max_aliens,", current_spawn_frequency: ",current_spawn_frequency,", current_spawn_quantity: ",current_spawn_quantity)
	timer.wait_time = current_spawn_frequency
	#max_alien_count = max_alien_count
