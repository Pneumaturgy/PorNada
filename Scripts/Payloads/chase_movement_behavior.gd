extends PayloadMovementBehavior
class_name ChaseMovementBehavior

var enemy_target

func initialize(_payload_owner, _payloadStatsResource: PayloadStats):
	pass

func get_position_delta(payload_owner, direction, payloadStatsResource: PayloadStats):
	if enemy_target == null:
		enemy_target = get_nearest_enemy(payload_owner)
	if enemy_target:
		var target_direction = enemy_target.global_position - payload_owner.global_position
		var target_rotation = target_direction.angle()
		payload_owner.rotation = lerp_angle(payload_owner.rotation, target_rotation, payloadStatsResource.rotation_speed * payload_owner.get_process_delta_time())
		var move_direction = Vector2(cos(payload_owner.rotation), sin(payload_owner.rotation))
		return move_direction * payloadStatsResource.bullet_speed * payload_owner.get_process_delta_time();
	else:
		return direction * payloadStatsResource.bullet_speed * payload_owner.get_process_delta_time();

func get_nearest_enemy(payload_owner):
	var nearest_enemy = null
	var shortest_distance = INF
	var enemies = Global.get_current_tree().get_nodes_in_group("enemies")
	for enemy in enemies:
		var distance = payload_owner.global_position.distance_to(enemy.global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_enemy = enemy
	return nearest_enemy
