extends Node2D

@onready var player = %Player
@onready var fade_in_screen = $FadeInScreen
@onready var label = $FadeInScreen/Label
@onready var hud = $HUD
@onready var title = $HUD/Control/Title
@onready var title_2 = $HUD/Control/Title2

func _ready():
	fade_in_screen.visible = true

func _on_alien_spawner_alien_spawned(alien_instance):
	add_child(alien_instance)
	alien_instance.set_player_instance(player)

func _process(delta):
	label.text = "fps: " + str(Engine.get_frames_per_second())

func _on_alien_spawner_all_aliens_spawned():
	trigger_new_level()
	

func trigger_new_level():
	hud.visible = true
	title.text = "[center][wave amp=50 freq=5]Completed Stage:[/wave][/center]"
	title_2.text = "[center][wave amp=50 freq=5]" + str(Global.current_stage) + "[/wave][/center]"
	Global.current_stage += 1
	#Global.save_game()
	Global.save_game(Global.SAVE_PATH)
	Global.save_game(Global.PROGRESS_PATH)
	#new_game.level_length = minimum_tiles + (((maximum_tiles-minimum_tiles)/player_max_level) * difficulty)
	# Save
	# progress
