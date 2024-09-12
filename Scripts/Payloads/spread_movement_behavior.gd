extends PayloadMovementBehavior
class_name SpreadMovementBehavior

func initialize(payload_owner, payloadStatsResource: PayloadStats):
	if payloadStatsResource.spawn_children:
		for i in [-2, -1, 1, 2]:
			var new_bullet_instance = payloadStatsResource.child_payload.instantiate()
			new_bullet_instance.center_bullet = false
			var angle_offset = deg_to_rad(15 * i)
			var center_angle = payload_owner.direction.angle()
			var new_angle = center_angle + angle_offset
			var new_direction = Vector2(cos(new_angle), sin(new_angle)).normalized()
			new_bullet_instance.direction = new_direction
			new_bullet_instance.global_position = payload_owner.global_position
			new_bullet_instance.rotation = self.rotation
			get_parent().add_child(new_bullet_instance)
