extends TextureRect
class_name InventorySlot

@export var current_item : Drop
@export var quantity = 0
@onready var sprite_2d = $Control/Sprite2D
@onready var quantity_text = $QuantityText

func _ready():
	expand_mode = 1

func update_slot():
	texture = current_item.item_image
	quantity_text.text = "[center]" + str(quantity) + "[/center]"
	
func _get_drag_data(at_position):
	# Retrieves information about the thing we are dragging
	print("Dragging")
	var data = SlotData.new(current_item, quantity)
	return data
	
func _can_drop_data(at_position, data):
	# Check if we can drop data on this slot
	print("Can drop")
	return true

func _drop_data(at_position, data):
	# What happens when we drop data on this resource
	print("Dropped data: ", data)
	pass
