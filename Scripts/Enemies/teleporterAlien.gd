extends Alien
class_name TeleporterAlien

@export var teleportTimeout = 3.0
@export var teleportScale = 750

var teleportTimer
var willTeleportFlag = false

func _ready():
	super._ready()
	teleportTimer = Timer.new()
	add_child(teleportTimer)
	teleportTimer.wait_time = teleportTimeout
	teleportTimer.one_shot = false
	teleportTimer.timeout.connect(teleport)
	teleportTimer.start()


func _process(_delta):
	if is_chasing and player != null:
		direction = (player.global_position - global_position).normalized()
		velocity = direction * get_property("speed")
		look_at(player.global_position)
		move_and_slide()


func getRandomVector2(scale):
	var x = randi_range(0, 255)
	var y = randi_range(0, 255)
	return Vector2(x, y) * scale


func teleport():
	if randi_range(0, 2) == 1: #TODO 33% teleport chance - refactor to a func
		velocity += getRandomVector2(teleportScale)
		move_and_slide()
