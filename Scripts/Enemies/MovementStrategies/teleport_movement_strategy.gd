extends AlienMovementStrategy
class_name TeleportMovementStrategy

@export var teleportTimeout = 3
@export var teleportScale = 750

var teleportTimer
var willTeleportFlag = false
var shouldOverwriteVelocity = false

func _init(scene_tree):
	teleportTimer = Timer.new()
	scene_tree.get_root().add_child(teleportTimer)
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
	if randi_range(0, 2) == 1: #TODO 33% teleport chance - refactor to a func
		shouldOverwriteVelocity = true
		
