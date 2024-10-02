extends Node2D
class_name DestroyOnSoundFinished

func _ready():
	$GPUParticles2D.emitting = true
func _on_base_sfx_finished():
	queue_free()
