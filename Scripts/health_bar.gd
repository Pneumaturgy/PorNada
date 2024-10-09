extends ProgressBar


@onready var progress_bar = $"."
@onready var entity : Entity
@onready var offset

func _ready():
	entity = get_parent()
	entity.healthChanged.connect(update)
	 # TODO: adjust if enemy recovers health with time and the initial is not the max
	max_value = entity.properties["health"]
	value = max_value
	offset =  global_position - entity.global_position
	update()


func _process(delta):
	global_position = entity.global_position + offset
	var negative_rotation = (-1) * entity.global_rotation
	rotation = negative_rotation


func update():
	value = entity.get_property("health")
