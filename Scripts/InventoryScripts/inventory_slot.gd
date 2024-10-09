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
	
