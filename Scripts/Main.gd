extends Node2D

@onready var player = %Player
@onready var fade_in_screen = $FadeInScreen
@onready var label = $FadeInScreen/Label
@onready var animation_player = $FadeInScreen/AnimationPlayer

@onready var end_game = $EndGame
@onready var stage_number = $EndGame/Control/StageNumber
@onready var next_stage_number = $EndGame/Control/NextStageNumber

@onready var kill_counter = $HUD/Control/HBoxContainer/KillCounter
@onready var timer_text = $HUD/Control/HBoxContainer/Time
@onready var current_stage_text = $HUD/Control/HBoxContainer/CurrentStageText

@onready var alien_spawner = $Player/AlienSpawner
@onready var day_timer = $DayTimer
@onready var night_timer = $NightTimer

var next_scene : String
var current_level_kill_count : int
var death_animation_trigger = false

func _ready():
	current_stage_text.text = "[center][wave amp=50 freq=5]Current Stage: " + str(Global.current_stage) + "[/wave][/center]"
	current_level_kill_count = 0
	fade_in_screen.visible = true

func _on_alien_spawner_alien_spawned(alien_instance):
	add_child(alien_instance)
	alien_instance.set_player_instance(player)

func _on_drop_spawned(drop_instance): # TODO: Do we need this?
	pass

func _process(delta):
	label.text = "fps: " + str(Engine.get_frames_per_second())
	next_stage_number.text =  "[center][wave amp=50 freq=5]" + str(night_timer.get_time_left()).pad_decimals(1) + "[/wave][/center]"
	timer_text.text =  "[center][wave amp=50 freq=5]Time: " + str(day_timer.get_time_left()).pad_decimals(1) + "[/wave][/center]"

func trigger_new_level():
	alien_spawner.can_spawn = false
	kill_all_aliens()
	
	end_game.visible = true
	stage_number.text = "[center][wave amp=50 freq=5]" + str(Global.current_stage) + "[/wave][/center]"
	next_stage_number.text = "[center][wave amp=50 freq=5]" + str(night_timer.time_left) + "[/wave][/center]"
	
	Global.current_stage += 1
	Global.save_game(Global.SAVE_PATH)
	Global.save_game(Global.PROGRESS_PATH)

func on_alien_death():
	current_level_kill_count += 1
	kill_counter.text = "[wave amp=50 freq=5]Kills: " + str(current_level_kill_count) + "[/wave]"

func _on_day_timer_timeout():
	print("Welcome to the next level!")
	trigger_new_level()
	night_timer.start()

func _on_night_timer_timeout():
	end_game.visible = false
	alien_spawner.update_difficulty()
	alien_spawner.can_spawn = true
	day_timer.start()
	current_stage_text.text  = "[center][wave amp=50 freq=5]Current Stage: " + str(Global.current_stage) + "[/wave][/center]"
	clean_all_drops()


func kill_all_aliens():
	var current_aliens = get_tree().get_nodes_in_group("enemies")
	for alien in current_aliens:
		alien.delete()

func clean_all_drops(): # TODO: This needs to be hooked up to stage finish /// Nope, we need the aliens who die at end of stage to not drop anything
	var current_drops = get_tree().get_nodes_in_group("drops")
	for drop in current_drops:
		drop.free()

func _on_player_player_died():
	var default_new_progress = Global.new_progress()
	Global.current_stage = default_new_progress["Progress"]["Current Stage"]
	fade_in_screen.visible = true
	animation_player.play_backwards()


func _on_animation_player_animation_finished(anim_name):
	if death_animation_trigger:
		get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
	else:
		death_animation_trigger = true
