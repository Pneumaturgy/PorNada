extends Node2D

signal alien_spawned(alien_instance)

@export var default_spawn_frequency = 1
@export var default_spawn_quantity = 3
@export var default_alien_count: int = 50
var can_spawn = true
@export var maximum_distance = 10
const aliens = [
	preload("res://Scenes/Entities/Enemies/Alien.tscn"),
	preload("res://Scenes/Entities/Enemies/RedAlien.tscn"),
	preload("res://Scenes/Entities/Enemies/RangedAlien.tscn")
]
@export var alien_spawn_table : SpawnTable

var current_max_aliens : int
var current_spawn_frequency : float
var current_spawn_quantity : int 

@onready var timer = $Timer

func _ready():
	Global.number_of_alien_types = len(aliens)
	alien_spawn_table._init()
	update_difficulty()

func _on_timer_timeout():
	if can_spawn:
		for i in range(current_spawn_quantity):
			if Global.current_alien_count < current_max_aliens:
				spawn_aliens()

func spawn_aliens():
	var minimal_distance = sqrt((get_viewport_rect().size.x / 1) ** 2 + (get_viewport_rect().size.y / 1) ** 2)
	var max_distance = minimal_distance * maximum_distance
	var distance = randf_range(minimal_distance, max_distance)
	var angle = randf_range(0, 360)
	var x = cos(angle) * distance
	var y = sin(angle) * distance
	var picked_alien_type = alien_spawn_table.pick_an_alien_type()
	print("Current Stage: ", Global.current_stage, ", Spawning Alien: ", picked_alien_type)
	var selected_alien_type = aliens[picked_alien_type]
	var alien_instance = selected_alien_type.instantiate()
	alien_instance.position = Vector2(global_position.x + x, global_position.y + y)
	alien_spawned.emit(alien_instance)
	Global.current_alien_count += 1

func update_difficulty():
	if alien_spawn_table.is_current_stage_in_table_wildcard():
		alien_spawn_table.mutate_wildcard_stage()
	var difficulty_factor = log(Global.current_stage) / log(2)  # logarithmic scaling
	current_max_aliens = default_alien_count + int(difficulty_factor * 10)
	current_spawn_frequency = max(default_spawn_frequency - (difficulty_factor * 0.05), 0.1)
	current_spawn_quantity = default_spawn_quantity + int(difficulty_factor)
	timer.wait_time = current_spawn_frequency
