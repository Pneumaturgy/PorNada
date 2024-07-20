extends Payload
class_name TestDamagePayload

@export var horizontal_speed = 0
@export var vertical_speed = -1

func _init():
	affected_properties_with_deltas = {
		"health": -10.0
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += (vertical_speed * delta)
	position.x += (horizontal_speed * delta)
