extends Area2D
class_name DropObject

#signal collected(drop)
@export var drop_resource : Drop
@onready var icon = $Icon
var quantity: int
@onready var sound = $Sound

func _ready() -> void:
	var random = RandomNumberGenerator.new()
	quantity = random.randi_range(drop_resource.min_quantity_multiplier, drop_resource.max_quantity_multiplier) * Global.current_stage
	icon.texture = drop_resource.item_image 


func _on_body_entered(body):
	if body is Player:
		
		body.collected.emit(self)
		
		#body.add_inventory()

func destroy():
	icon.visible = false
	sound.play()
	#print("destroy!!")
	


func _on_sound_finished():
	queue_free()
