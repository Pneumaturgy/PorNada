extends Resource
class_name AlienResource

enum MOVEMENT_STRATEGIES { BASE_MOVEMENT_STRATEGY, TELEPORT_MOVEMENT_STRATEGY }
@export var chasingMovementStrategy : MOVEMENT_STRATEGIES


func get_chasing_movement_strategy():
	match chasingMovementStrategy:
		MOVEMENT_STRATEGIES.BASE_MOVEMENT_STRATEGY:
			return AlienMovementStrategy.new()
		MOVEMENT_STRATEGIES.TELEPORT_MOVEMENT_STRATEGY:
			return TeleportMovementStrategy.new()
