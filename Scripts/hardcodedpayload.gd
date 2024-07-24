extends Payload
class_name HardcodedPayload


func _ready():
	super._ready()
	affected_properties_with_deltas = {
		"health": -10.0
	}


