extends Node
class_name EnemyMovementStrategy


func get_velocity(player_global_position, global_position, speed):
	var direction = (player_global_position - global_position).normalized()
	var velocity = direction * speed
	return velocity
