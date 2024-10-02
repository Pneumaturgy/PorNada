extends Area2D
class_name DropObject

#signal collected(drop)
@export var dropSpawnEffect : PackedScene
@export var dropCollectEffect : PackedScene
@export var drop_resource : Drop
@onready var icon = $Icon
var quantity: int
@onready var sound = $Sound

func _ready() -> void:
	drop_effect()
	var random = RandomNumberGenerator.new()
	quantity = random.randi_range(drop_resource.min_quantity_multiplier, drop_resource.max_quantity_multiplier) * Global.current_stage
	icon.texture = drop_resource.item_image 

func drop_effect():
	if dropSpawnEffect:
		var new_effect = dropSpawnEffect.instantiate()
		new_effect.position = self.position
		get_parent().add_child(new_effect)

func _on_body_entered(body):
	if body is Player:
		
		body.collected.emit(self)
		
		#body.add_inventory()

func destroy():
	collect_effect()
	queue_free()

func collect_effect():
	var new_effect = dropCollectEffect.instantiate()
	new_effect.position = self.position
	get_parent().add_child(new_effect)
