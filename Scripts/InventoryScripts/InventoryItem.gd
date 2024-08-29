extends Resource
class_name InventoryItem

@export var item_type : String
@export var item_quantity : int
@export var inventory_slot : int
var item_image : Sprite2D

func _ready():
	match item_type:
		"Poop":
			generate_image("Poop")
		"Log":
			generate_image("Log")


func generate_image(image):
	var new_image = Sprite2D.new()
	new_image.texture = load("res://Assets/2D/InventoryImages/" + image + ".svg")
	item_image = new_image
