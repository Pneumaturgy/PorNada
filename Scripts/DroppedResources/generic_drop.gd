class_name GenericDrop
extends Area2D

var quantity: int
var min_quantity_multiplier: int = 1
var max_quantity_multiplier: int = 10
var item_identifier: String = "item:generic"

func _init() -> void:
	var random = RandomNumberGenerator.new()
	quantity = random.randi_range(min_quantity_multiplier, max_quantity_multiplier) * Global.current_stage
	#random.free() # TODO: throws an error, why?

func _on_body_entered(body: Node2D) -> void:
	print("body: ", body)
	if body is Player:
		body.add_inventory(item_identifier, quantity)
		queue_free()
