extends CanvasLayer

signal use_move_vector
signal use_aim_vector

func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if $TouchScreenButton1.is_pressed():
			var move_vector = calculate_vector($TouchScreenButton1,event.position)
			emit_signal("use_move_vector",move_vector)
		if $TouchScreenButton2.is_pressed():
			var aim_vector = calculate_vector($TouchScreenButton2,event.position)
			emit_signal("use_aim_vector", aim_vector)

func calculate_vector(button, event_position):
	var texture_center = button.position + Vector2(128,128)
	return (event_position - texture_center).normalized()
