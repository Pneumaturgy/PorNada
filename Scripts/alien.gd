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
	AttackCooldownTimer.start(attack_cooldown)

func _on_attack_range_body_entered(body):
	if body is Player:
		self.call_deferred("attack")

func _on_vision_range_body_entered(body):
	if body is Player:
		is_chasing = true

func _on_vision_range_body_exited(body):
	if body is Player:
		is_chasing = false

func _on_attack_range_body_exited(body):
	if body is Player:
		AttackCooldownTimer.stop()

func _on_attack_cooldown_timeout():
	self.call_deferred("attack")

func set_player_instance(player_instance):
	player = player_instance

func die():
	Global.current_alien_count -= 1
	alien_death.emit()
	super.die()
