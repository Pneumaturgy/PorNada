class_name MisslePayload
extends Area2D

@export var fire_rate = 0.7
@export var bullet_speed = 5000
@export var timeToLive = 10.0
@export var affected_properties_with_deltas : Dictionary = {
	"health" : -10.0,
	"defense" : 0.0,
	"speed" : 0.0
}
@export var rotation_speed = 10.0

var direction
var enemy_target

func _ready():
	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = timeToLive
	death_timer.timeout.connect(destroy_bullet)
	death_timer.start()

func apply_effects(entity):
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
	if enemy_target == null:
		enemy_target = get_nearest_enemy()
	if enemy_target:
		var target_direction = enemy_target.global_position - self.global_position
		var target_rotation = target_direction.angle()
		self.rotation = lerp_angle(rotation, target_rotation, rotation_speed * delta)
		var move_direction = Vector2(cos(rotation), sin(rotation))
		position += move_direction * bullet_speed * delta
	else:
		position += direction * bullet_speed * delta

func get_nearest_enemy():
	var nearest_enemy = null
	var shortest_distance = INF
	var enemies = get_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy
