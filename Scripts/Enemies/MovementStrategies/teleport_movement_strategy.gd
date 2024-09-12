extends AlienMovementStrategy
class_name TeleportMovementStrategy

# TODO: consider how to configure this from the Inspector
@export var teleportTimeout = 3
@export var teleportScale = 750
@export var teleportChancePercentage = 66

var teleportTimer
var willTeleportFlag = false
var shouldOverwriteVelocity = false

func _init():
	teleportTimer = Timer.new()
	Global.get_current_tree().get_root().add_child(teleportTimer)
	teleportTimer.wait_time = teleportTimeout
	teleportTimer.one_shot = false
	teleportTimer.timeout.connect(teleport)
	teleportTimer.start()

func get_velocity(player_global_position, global_position, speed):
	var velocity = super.get_velocity(player_global_position, global_position, speed)
	var offset = Vector2(0, 0)
	if shouldOverwriteVelocity:
		offset = Utils.getRandomVector2(teleportScale)
	return velocity + offset

func teleport():
	if Utils.random_true_with(teleportChancePercentage):
		shouldOverwriteVelocity = true
