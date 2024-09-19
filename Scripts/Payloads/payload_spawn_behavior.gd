extends Node
class_name PayloadSpawnBehavior

func initialize(payload_owner, layer_value, mask_value, _payloadStatsResource: PayloadStats):
	set_collisions(payload_owner, layer_value, mask_value)

func set_collisions(payload_owner, layer_value, mask_value):
	payload_owner.set_collision_layer_value(layer_value, true);
	payload_owner.set_collision_mask_value(mask_value, true);
