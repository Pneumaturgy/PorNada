extends Area2D
class_name Payload

@export var timeToLive = 1.0
var affected_properties_with_deltas = {}

func _ready():
	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = timeToLive
	death_timer.timeout.connect(destroy_bullet)
	death_timer.start()

func apply_effects(entity):
	print("applying effects...")
	print(affected_properties_with_deltas)
	for property in affected_properties_with_deltas:
		var delta = affected_properties_with_deltas[property]
		entity.affect_property(property, delta)

func _on_body_entered(body):
	print("body: ", body)
	if body is CharacterBody2D: # Entity:
		apply_effects(body)
		destroy_bullet()

func destroy_bullet():
	queue_free()
