extends Node
class_name InventorySlot

@export var current_item : Drop
@export var quantity = 0
@onready var sprite_2d = $Control/Sprite2D
@onready var quantity_text = $QuantityText


func update_slot():
	sprite_2d.texture = current_item.item_image
	#sprite_2d.texture.size
	quantity_text.text = "[center]" + str(quantity) + "[/center]"
	
