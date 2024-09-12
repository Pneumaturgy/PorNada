extends Resource
class_name PayloadStats

@export var bullet_speed = 500
@export var timeToLive = 1.0
@export var affected_properties_with_deltas : Dictionary = {
	"health" : 0.0,
	"defense" : 0.0,
	"speed" : 0.0
}
@export var fire_rate = 0.7
@export var rotation_speed = 10.0
@export var spawn_children = true
@export var child_payload : PackedScene
