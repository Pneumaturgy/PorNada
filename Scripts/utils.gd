class_name Utils

static func getRandomVector2(scale):
	var x = randi_range(0, 255)
	var y = randi_range(0, 255)
	return Vector2(x, y) * scale 


static func random_true_with(integer_percentage):
	if randi_range(0, 100) <= integer_percentage:
		return true
	return false
