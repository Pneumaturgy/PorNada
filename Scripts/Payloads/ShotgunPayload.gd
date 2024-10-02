extends Area2D
class_name ShotgunPayload

@export var fire_rate = 0.7
@export var bullet_speed = 5000
@export var timeToLive = 1.0
@export var affected_properties_with_deltas : Dictionary = {
	"health" : -3.0,
	"defense" : 0.0,
	"speed" : 0.0
}
@export var center_bullet = true
const SHOTGUN_PAYLOAD = preload("res://Scenes/Payloads/ShotgunPayload.tscn")

var direction

func _ready():
	if (center_bullet):
		spread_bullets()

	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = timeToLive
	death_timer.timeout.connect(destroy_bullet)
	death_timer.start()

func apply_effects(entity):
	print('-----entity')
	print(entity)
	for property in affected_properties_with_deltas:
		var delta = affected_properties_with_deltas[property]
		entity.affect_property(property, delta)

func _on_body_entered(body):
	if body is CharacterBody2D: # Entity:
		apply_effects(body)
		destroy_bullet()

func destroy_bullet():
	queue_free()

func _process(delta):
	position += direction * bullet_speed * delta


func spread_bullets():
	for i in [-2, -1, 1, 2]:
		var new_bullet_instance = SHOTGUN_PAYLOAD.instantiate()
		new_bullet_instance.center_bullet = false
		var angle_offset = deg_to_rad(15 * i)
		var center_angle = direction.angle()
		var new_angle = center_angle + angle_offset
		var new_direction = Vector2(cos(new_angle), sin(new_angle)).normalized()
		new_bullet_instance.direction = new_direction
		new_bullet_instance.global_position = global_position
		new_bullet_instance.rotation = self.rotation
		get_parent().add_child(new_bullet_instance)
