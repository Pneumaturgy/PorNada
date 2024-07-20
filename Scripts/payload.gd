extends Area2D
class_name Payload

var affected_properties_with_deltas = {}

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
