extends CharacterBody2D
class_name  Entity

signal destroyed()

@export var drop_item_resource : Resource
var death_check = true
signal healthChanged
const drop_item_scene = preload("res://Scenes/Entities/DroppedResources/DropItemScene.tscn")


@export var properties = {
	"health": 100.0,
	"defense": 10.0,
	"speed": 300.0
}

var runtime_properties = properties.duplicate(true);

var MAX_PROPERTIES = {
	"health": 1000.0,
	"defense": 100.0,
	"speed": 10000.0
}

var MIN_PROPERTIES = {
	"health": 0.0,
	"defense": 0.0,
	"speed": 0.0
}

func _ready():
	runtime_properties = properties.duplicate(true);


func die():
	destroyed.emit()
	drop()
	queue_free()

func health_triggers(value):
	healthChanged.emit()
	if value <= 0:
		if death_check:
			death_check = false
			die()

func check_triggers(property, value):
	if property == "health":
		health_triggers(value)

func set_property(property, value):
	var MAX_VALUE = MAX_PROPERTIES[property]
	var MIN_VALUE = MIN_PROPERTIES[property]
	if value < MIN_VALUE:
		value = MIN_VALUE
	elif value > MAX_VALUE:
		value = MAX_VALUE
	runtime_properties[property] = value
	check_triggers(property, value)

func get_property(property):
	return runtime_properties[property]

func affect_property(property, delta):
	update_ui(property,delta)
	set_property(property, get_property(property) + delta)

func update_ui(_property,_delta):
	pass


func drop():
	var new_drop = drop_item_scene.instantiate()
	new_drop.drop_resource = drop_item_resource
	new_drop.position = self.global_position
	var drops_node_group = get_node("/root/Main")
	drops_node_group.call_deferred("add_child", new_drop)
	# TODO: Add graphic functionality
