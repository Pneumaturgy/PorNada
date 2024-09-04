
class_name DroppedPneuma
extends GenericDrop

func _init() -> void:
	item_identifier = "item:pneuma"
	min_quantity_multiplier = 1
	max_quantity_multiplier = 20
	super._init()

func _on_body_entered(body):
	print("on body entered, ", body)
	super._on_body_entered(body)
