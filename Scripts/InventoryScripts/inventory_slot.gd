extends TextureRect
class_name InventorySlot

@export var current_item : Drop
@export var quantity = 0
@onready var sprite_2d = $Control/Sprite2D
@onready var quantity_text = $QuantityText
var slot_index
var can_drop_function : Callable
#var drop_data : Callable

func _ready():
	expand_mode = 1

func update_slot():
	texture = current_item.item_image
	quantity_text.text = "[center]" + str(quantity) + "[/center]"
	
func _get_drag_data(at_position):
	# Retrieves information about the thing we are dragging
	return slot_index
	
func _can_drop_data(at_position, origin_index):
	# Check if we can drop data on this slot
	var can_drop = can_drop_function.call(slot_index, origin_index)
	#print("_can_drop_data: ", can_drop)
	return can_drop

func _drop_data(at_position, origin_index):
	# What happens when we drop data on this resource
	print("_drop_data: ", slot_index, origin_index)
