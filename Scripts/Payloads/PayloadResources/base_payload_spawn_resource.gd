extends Resource
class_name PayloadSpawn

enum PAYLOAD_SPAWNS { BASE_PAYLOAD_SPAWN, CHASE_PAYLOAD_SPAWN, SPREAD_PAYLOAD_SPAWN }
@export var payloadSpawn : PAYLOAD_SPAWNS


func get_spawn_strategy():
	match payloadSpawn:
		PAYLOAD_SPAWNS.BASE_PAYLOAD_SPAWN:
			return PayloadSpawnBehavior.new()
		PAYLOAD_SPAWNS.CHASE_PAYLOAD_SPAWN:
			return PayloadSpawnBehavior.new()
		PAYLOAD_SPAWNS.SPREAD_PAYLOAD_SPAWN:
			return SpreadSpawnBehavior.new()
