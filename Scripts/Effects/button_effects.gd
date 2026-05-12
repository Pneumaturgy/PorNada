extends Button
class_name ButtonEffects
var sound_player : AudioStreamPlayer2D

@export var sounds : Array[AudioStreamMP3]

# Called when the node enters the scene tree for the first time.
func _ready():
	sound_player = AudioStreamPlayer2D.new()
	add_child(sound_player)
	
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	button_down.connect(on_button_down)
	button_up.connect(on_button_up)
	
	

func on_mouse_entered():
	play_sound(0)
	
func on_mouse_exited():
	play_sound(0)

func on_button_down():
	play_sound(1)

func on_button_up():
	play_sound(2)


func play_sound(i):
	if i < 0 or i >= sounds.size() or not sounds[i]:
		return
	if not is_instance_valid(sound_player) or not sound_player.is_inside_tree():
		return
	sound_player.stream = sounds[i]
	sound_player.play()
