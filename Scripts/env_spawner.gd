extends Node2D

@export var spawn_frequency = 0.1
@export var spawn_quantity = 1
var current_prop_count = 0
#var can_spawn = true
@export var maximum_distance = 5
const props = [
	preload("res://Scenes/Entities/EnvironmentEntity.tscn")
]

@export var current_max_props = 10
var current_spawn_frequency : float
@onready var timer = $Timer

func _ready():
	timer.wait_time = spawn_frequency
	#Global.number_of_alien_types = len(environment)
	#alien_spawn_table._init()
	#update_difficulty()

func _on_timer_timeout():
	for i in range(spawn_quantity):
		if current_prop_count < current_max_props:
			spawn_prop()

func spawn_prop():
	var minimal_distance = sqrt((get_viewport_rect().size.x / 1) ** 2 + (get_viewport_rect().size.y / 1) ** 2)
	var max_distance = minimal_distance * maximum_distance
	var distance = randf_range(minimal_distance*2, max_distance)
	var angle = randf_range(0, 360)
	var x = cos(angle) * distance
	var y = sin(angle) * distance
	
	var new_prop = props[randi_range(0,props.size()-1)]
	var prop_instance = new_prop.instantiate()
	add_child(prop_instance)
	prop_instance.position = Vector2(global_position.x + x, global_position.y + y)
	prop_instance.destroyed.connect(prop_destroyed)
	current_prop_count += 1
	#print('spawned at: ', prop_instance.position)

func prop_destroyed():
	#print('destroyed')
	current_prop_count -= 1
