extends Payload
class_name DamagePayload

@export var speed = 500
var direction

func _init():
	affected_properties_with_deltas = {
		"health": -10.0
	}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * delta * speed
