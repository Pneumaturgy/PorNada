extends Node2D

signal alien_spawned(alien_instance)
signal all_aliens_spawned

@export var spawn_frequency = 1
@export var spawn_quantity = 3
@export var maximum_distance = 10


const alien_scene = preload("res://Scenes/Entities/Alien.tscn")

@export var max_alien_count: int = 50

@onready var timer = $Timer

func _ready():
	timer.wait_time = spawn_frequency

func _on_timer_timeout():
	for i in range(spawn_quantity):
		if Global.current_alien_count < max_alien_count:
			spawn_aliens()

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
	alien_spawned.emit(alien_instance)
	Global.current_alien_count += 1
	#print("An alien was born, current count: ", Global.current_alien_count)
