extends Node2D

@onready var player = %Player
@onready var fade_in_screen = $FadeInScreen
@onready var label = $FadeInScreen/Label
@onready var animation_player = $FadeInScreen/AnimationPlayer

@onready var new_stage_canvas = $NewStageCanvas
@onready var stage_number = $NewStageCanvas/Control/StageNumber
@onready var next_stage_number = $NewStageCanvas/Control/NextStageNumber

@onready var kill_counter = $HUD/Control/HBoxContainer/KillCounter
@onready var timer_text = $HUD/Control/HBoxContainer/Time
@onready var current_stage_text = $HUD/Control/HBoxContainer/CurrentStageText

@onready var alien_spawner = $Player/AlienSpawner
@onready var day_timer = $DayTimer
@onready var night_timer = $NightTimer
@onready var dawn_timer = $DawnTimer

@onready var juke_box = $JukeBox
#var play_next_track = true
var trigger_next_track = false
var next_playlist 

var next_scene : String
var current_level_kill_count : int
var death_animation_trigger = false

func _ready():
	next_playlist = juke_box.dawn_playlist
	update_jukebox()
	new_dawn()
	current_stage_text.text = "[center][wave amp=50 freq=5]Current Stage: " + str(Global.current_stage) + "[/wave][/center]"
	current_level_kill_count = 0
	fade_in_screen.visible = true

func _on_alien_spawner_alien_spawned(alien_instance):
	add_child(alien_instance)
	alien_instance.set_player_instance(player)

func _on_drop_spawned(_drop_instance): # TODO: Do we need this?
	pass



func _process(_delta):
	label.text = "fps: " + str(Engine.get_frames_per_second())
	next_stage_number.text =  "[center][wave amp=50 freq=5]" + str(night_timer.get_time_left()).pad_decimals(1) + "[/wave][/center]"
	timer_text.text =  "[center][wave amp=50 freq=5]Time: " + str(day_timer.get_time_left()).pad_decimals(1) + "[/wave][/center]"

#region Day / Night Cycle
func new_dawn(): ## Prepare to fight!
	
	dawn_timer.start() # Begin timer
	print('dawn_timer')
	
	trigger_next_track = true
	next_playlist = juke_box.dawn_playlist
	#update_jukebox() # Update music
	# Update UI
	new_stage_canvas.visible = false 
	current_stage_text.text  = "[center][wave amp=50 freq=5]Current Stage: " + str(Global.current_stage) + "[/wave][/center]"

func _on_dawn_timer_timeout():
	new_day()

func new_day(): ## Time to fight!
	clean_all_drops()
	day_timer.start()
	
	trigger_next_track = true
	next_playlist = juke_box.day_playlist
	#update_jukebox()
	alien_spawner.update_difficulty()
	alien_spawner.can_spawn = true

func _on_day_timer_timeout():
	new_night()
	

func new_night(): ## Time to loot!
	night_timer.start()
	
	trigger_next_track = true
	next_playlist = juke_box.night_playlist
	#update_jukebox()
	alien_spawner.can_spawn = false
	kill_all_aliens()
	
	# Update UI
	new_stage_canvas.visible = true
	stage_number.text = "[center][wave amp=50 freq=5]" + str(Global.current_stage) + "[/wave][/center]"
	next_stage_number.text = "[center][wave amp=50 freq=5]" + str(night_timer.time_left) + "[/wave][/center]"
	
	Global.current_stage += 1
	Global.save_game(Global.SAVE_PATH)
	Global.save_game(Global.PROGRESS_PATH)

func _on_night_timer_timeout():
	new_dawn()
#endregion


func on_alien_death():
	current_level_kill_count += 1
	kill_counter.text = "[wave amp=50 freq=5]Kills: " + str(current_level_kill_count) + "[/wave]"


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


func _on_animation_player_animation_finished(_anim_name):
	if death_animation_trigger:
		get_tree().change_scene_to_file("res://Scenes/Levels/MainMenu.tscn")
	else:
		death_animation_trigger = true


func _on_juke_box_finished():
	#if trigger_next_track:
	update_jukebox()
		#trigger_next_track = false
		
	#play_next_track = true
	print('playnexttrack')
	
	pass # Replace with function body.

func update_jukebox():
	juke_box.stream = next_playlist.get_list_stream(randi_range(0,next_playlist.get_stream_count()-1))
	#if play_next_track:
	juke_box.play()
	print("jukebox is playing: " , juke_box.playing)
	print("next playlist is: " , next_playlist)
	print("current stream: " , juke_box.stream)

		#play_next_track = false
