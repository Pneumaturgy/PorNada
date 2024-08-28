extends Area2D
class_name Payload

@export var bullet_speed = 500
@export var timeToLive = 1.0
@export var affected_properties_with_deltas : Dictionary = {
	"health" : 0.0,
	"defense" : 0.0,
	"speed" : 0.0
}

var direction

func _ready():
	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = timeToLive
	death_timer.timeout.connect(destroy_bullet)
	death_timer.start()

func apply_effects(entity):
	print("applying effects...")
	print(affected_properties_with_deltas)
	for property in affected_properties_with_deltas:
		var delta = affected_properties_with_deltas[property]
		#print("entity: ",entity)
		entity.affect_property(property, delta)

func _on_body_entered(body):
	#print("body: ", body)
	if body is CharacterBody2D: # Entity:
		apply_effects(body)
		destroy_bullet()

func destroy_bullet():
	queue_free()

func _process(delta):
	position += direction * delta * bullet_speed
