extends Payload
class_name AlienPayload


func _ready():
	super._ready()
	affected_properties_with_deltas = {
		"health": -2.5
	}
