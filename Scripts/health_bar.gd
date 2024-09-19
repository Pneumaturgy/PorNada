extends ProgressBar


@export var entity : Entity


func _ready():
	entity.healthChanged.connect(update)
	update()
	
func update():
	print("Updating health bar")
	value = entity.get_property("health")
