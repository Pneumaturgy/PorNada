extends Node
class_name PayloadSpawnBehavior

func initialize(payload_owner, layer_value, mask_value, _payloadStatsResource: PayloadStats):
	set_collisions(payload_owner, layer_value, mask_value)

func set_collisions(payload_owner, layer_value, mask_value):
	payload_owner.set_collision_layer(layer_value)
	payload_owner.set_collision_mask(mask_value)
