extends Node2D
class_name PayloadEffect

func _ready():
	$GPUParticles2D.emitting = true
func _on_base_sfx_finished():
	queue_free()
