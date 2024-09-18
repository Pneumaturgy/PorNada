extends Area2D
class_name Payload

#@export var bullet_speed = 500
#@export var timeToLive = 1.0
#@export var affected_properties_with_deltas : Dictionary = {
	#"health" : 0.0,
	#"defense" : 0.0,
	#"speed" : 0.0
#}
@export var payloadStatsResource : PayloadStats
@export var payloadBehaviorResource : PayloadBehavior
@export var payloadSpawnResource : PayloadSpawn

var layer_value : int
var mask_value : int

var payload_behavior_strategy
var payload_spawn_strategy

var direction

func _ready():
	payload_behavior_strategy = payloadBehaviorResource.get_chasing_movement_strategy()
	payload_behavior_strategy.initialize(self, payloadStatsResource)
	payload_spawn_strategy = payloadSpawnResource.get_spawn_strategy()
	payload_spawn_strategy.initialize(self, layer_value, mask_value, payloadStatsResource)
	var death_timer = Timer.new()
	add_child(death_timer)
	death_timer.wait_time = payloadStatsResource.timeToLive
	death_timer.timeout.connect(destroy_bullet)
	death_timer.start()

func _process(delta):
	position += payload_behavior_strategy.get_position_delta(self, direction, payloadStatsResource);

func apply_effects(entity):
	for property in payloadStatsResource.affected_properties_with_deltas:
		var delta = payloadStatsResource.affected_properties_with_deltas[property]
		entity.affect_property(property, delta)

func _on_body_entered(body):
	if body is CharacterBody2D: # Entity:
		apply_effects(body)
		destroy_bullet()

func destroy_bullet():
	queue_free()
