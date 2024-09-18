extends PayloadMovementBehavior
class_name SpreadMovementBehavior

func initialize(payload_owner, payloadStatsResource: PayloadStats):
	if payloadStatsResource.spawn_children:
		for i in [-2, -1, 1, 2]:
			var new_bullet_instance = payloadStatsResource.child_payload.instantiate()
			##new_bullet_instance.spawn_children = false
			var angle_offset = deg_to_rad(15 * i)
			var center_angle = payload_owner.direction.angle()
			var new_angle = center_angle + angle_offset
			var new_direction = Vector2(cos(new_angle), sin(new_angle)).normalized()
			new_bullet_instance.direction = new_direction
			new_bullet_instance.global_position = payload_owner.global_position
			new_bullet_instance.rotation = payload_owner.rotation
			new_bullet_instance.set_collision_layer(payload_owner.get_collision_layer()); #Player
			new_bullet_instance.set_collision_mask(payload_owner.get_collision_mask()); #Enemies
			payload_owner.get_parent().add_child(new_bullet_instance)
