extends Node
class_name PayloadMovementBehavior

func initialize(payload_owner, payloadStatsResource: PayloadStats):
	pass

func get_position_delta(payload_owner, direction, payloadStatsResource: PayloadStats ):
	return direction * payloadStatsResource.bullet_speed * payload_owner.get_process_delta_time();
