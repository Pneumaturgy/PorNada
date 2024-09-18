extends Entity
class_name Alien


signal alien_death

var player
@export var payload : PackedScene
@onready var AttackCooldownTimer = $AttackCooldown
@export var drop_item_resource : Resource
@export var attack_cooldown = 1.0

const drop_item_scene = preload("res://Scenes/Entities/DroppedResources/DropItemScene.tscn")

var firing_offset = 20
var is_chasing = false
var direction
var is_attacking = false
var is_looking = false

@export var alien_resource : AlienResource
var chasing_movement_strategy

# Called when the node enters the scene tree for the first time.
func _ready():
	alien_death.connect(get_parent().on_alien_death)
	chasing_movement_strategy = alien_resource.get_chasing_movement_strategy()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_looking:
		look_at(player.global_position)
	if is_chasing and player != null:
		velocity = chasing_movement_strategy.get_velocity(
			player.global_position,
			global_position,
			get_property("speed")
		)
		move_and_slide()

func attack():
	if !is_attacking:
		is_attacking = true
		direction = (player.global_position - self.global_position).normalized()
		
		var new_payload : Area2D = payload.instantiate()
		# collision setup
		new_payload.set_collision_layer_value(2, true); #Enemies
		new_payload.set_collision_mask_value(8, true); #Player
		
		new_payload.global_position = self.global_position + (direction * firing_offset)
		new_payload.direction = direction
		new_payload.rotation = get_target_rotation()
		get_parent().add_child(new_payload)
		AttackCooldownTimer.start(attack_cooldown)


func get_target_rotation():
	var target_direction = player.global_position - self.global_position
	var target_rotation = target_direction.angle()
	return target_rotation

func _on_attack_range_body_entered(body):
	if body is Player:
		self.call_deferred("attack")
		is_chasing = false

func _on_vision_range_body_entered(body):
	if body is Player:
		is_chasing = true
		is_looking = true

func _on_vision_range_body_exited(body):
	if body is Player:
		is_chasing = false
		is_looking = false

func _on_attack_range_body_exited(body):
	if body is Player:
		AttackCooldownTimer.stop()
		is_chasing = true

func _on_attack_cooldown_timeout():
	is_attacking = false
	self.call_deferred("attack")

func set_player_instance(player_instance):
	player = player_instance

func drop():
	var new_drop = drop_item_scene.instantiate()
	new_drop.drop_resource = drop_item_resource
	new_drop.position = self.global_position
	var drops_node_group = get_node("/root/Main")
	drops_node_group.call_deferred("add_child", new_drop)
	# TODO: Add graphic functionality

func die():
	Global.current_alien_count -= 1
	alien_death.emit()
	drop()
	super.die()
