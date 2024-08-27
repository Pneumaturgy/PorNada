extends CharacterBody2D
class_name  Entity

var death_check = true

@export var properties = {
	"health": 100.0,
	"defense": 10.0,
	"speed": 300.0
}

var MAX_PROPERTIES = {
	"health": 100.0,
	"defense": 10.0,
	"speed": 300.0
}

var MIN_PROPERTIES = {
	"health": 0.0,
	"defense": 0.0,
	"speed": 0.0
}

func die():
	queue_free()

func health_triggers(value):
	if value <= 0:
		if death_check:
			death_check = false
			die()
			

func check_triggers(property, value):
	if property == "health":
		health_triggers(value)

func set_property(property, value):
	#print(property, " changing to ", value)
	var MAX_VALUE = MAX_PROPERTIES[property]
	var MIN_VALUE = MIN_PROPERTIES[property]
	if value < MIN_VALUE:
		value = MIN_VALUE
	elif value > MAX_VALUE:
		value = MAX_VALUE
	properties[property] = value
	check_triggers(property, value)

func get_property(property):
	return properties[property]

func affect_property(property, delta):
	#print(property, " changing by ", delta)
	set_property(property, get_property(property) + delta)
