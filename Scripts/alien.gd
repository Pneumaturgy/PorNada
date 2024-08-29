extends Entity
class_name Alien


signal alien_death

# affect player health
	#on collision 
	# if collisoin is player
	# player.affect health
# move towards player
	# set up vision radius
	# on enter, move towards player
		# up to a limit

var player
@export var payload : PackedScene
@onready var AttackCooldownTimer = $AttackCooldown

@export var attack_cooldown = 1.0

const pneuma_scene = preload("res://Scenes/Entities/DroppedResources/Pneuma.tscn")

var firing_offset = 20
var is_chasing = false
var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	alien_death.connect(get_parent().on_alien_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_chasing and player != null:
		direction = (player.global_position - global_position).normalized()
		velocity = direction * get_property("speed")
		look_at(player.global_position)
		move_and_slide()


func attack():
	direction = (player.global_position - self.global_position).normalized()
	var new_payload = payload.instantiate()
	new_payload.global_position = self.global_position + (direction * firing_offset)
	new_payload.direction = direction
	new_payload.rotation = self.rotation
	get_parent().add_child(new_payload)
	#print("die human")
	AttackCooldownTimer.start(attack_cooldown)
	#print("time left: ", AttackCooldownTimer.get_time_left())

func _on_attack_range_body_entered(body):
	if body is Player:
		#print("burn baby burn")
		self.call_deferred("attack")


func _on_vision_range_body_entered(body):
	if body is Player:
		is_chasing = true
		#print('coming to geeeet you!!')


func _on_vision_range_body_exited(body):
	if body is Player:
		is_chasing = false
		#print('where did you go??')


func _on_attack_range_body_exited(body):
	if body is Player:
		AttackCooldownTimer.stop()
		#print("that one got away")


func _on_attack_cooldown_timeout():
	self.call_deferred("attack")

func set_player_instance(player_instance):
	player = player_instance

func die():
	Global.current_alien_count -= 1
	alien_death.emit()
	#print("An alien died, current count: ", Global.current_alien_count)
	var new_pneuma = pneuma_scene.instantiate()
	new_pneuma.position = self.global_position
	var drops_node_group = get_node("/root/Main")
	drops_node_group.add_child(new_pneuma)
	super.die()
