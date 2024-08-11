extends Node2D
class_name modulate_children

@export var color : String

var to_modulate = {}

func _ready():
	for index in self.get_child(0).get_children().size():
		to_modulate[index] = get_child(0).get_child(index)
	for index in to_modulate:
		to_modulate[index].self_modulate = Color(color)
	print(to_modulate)
