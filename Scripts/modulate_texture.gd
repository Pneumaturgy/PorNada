extends Node
class_name modulate_texture

@export var color : String

var to_modulate = {}

func _ready():
	var texture = self.texture
	texture.self_modulate = Color(color)
