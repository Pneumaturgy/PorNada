extends PayloadSpawnBehavior
class_name SpreadSpawnBehavior

func initialize(payload_owner, layer_value, mask_value, payloadStatsResource: PayloadStats):
	super.initialize(payload_owner, layer_value, mask_value, payloadStatsResource)

	for i in [-2, -1, 1, 2]:
		var new_bullet_instance = payloadStatsResource.child_payload.instantiate()
		var angle_offset = deg_to_rad(10 * i)
		var center_angle = payload_owner.direction.angle()
		var new_angle = center_angle + angle_offset
		var new_direction = Vector2(cos(new_angle), sin(new_angle)).normalized()
		new_bullet_instance.direction = new_direction
		new_bullet_instance.global_position = payload_owner.global_position
		new_bullet_instance.rotation = payload_owner.rotation
		new_bullet_instance.mask_value = mask_value
		new_bullet_instance.layer_value = layer_value
		payload_owner.get_parent().add_child(new_bullet_instance)

#func set_collisions(payload_owner, layer_value, mask_value):
	#payload_owner.set_collision_layer_value(layer_value, true);
	#payload_owner.set_collision_mask_value(mask_value, true);
