extends Control

@onready var player = %Player

func _on_alien_spawner_alien_spawned(alien_instance):
	add_child(alien_instance)
	alien_instance.set_player_instance(player)
