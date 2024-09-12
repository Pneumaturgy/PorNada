extends Resource
class_name PayloadBehavior

enum PAYLOAD_BEHAVIORS { BASE_PAYLOAD_BEHAVIOR, CHASE_PAYLOAD_BEHAVIOR, SPREAD_PAYLOAD_BEHAVIOR }
@export var payloadBehavior : PAYLOAD_BEHAVIORS


func get_chasing_movement_strategy():
	match payloadBehavior:
		PAYLOAD_BEHAVIORS.BASE_PAYLOAD_BEHAVIOR:
			return PayloadMovementBehavior.new()
		PAYLOAD_BEHAVIORS.CHASE_PAYLOAD_BEHAVIOR:
			return ChaseMovementBehavior.new()
		PAYLOAD_BEHAVIORS.SPREAD_PAYLOAD_BEHAVIOR:
			return SpreadMovementBehavior.new()
