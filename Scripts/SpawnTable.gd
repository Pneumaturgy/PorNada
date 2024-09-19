
extends Resource
class_name SpawnTable

@export var spawnTableRows: Array[SpawnTableRow]

# format:
# {
#	stage_number: {
#		"aliens": {
#			alien_index: {
#				"weight"
#			}
#		},
#		"total_weight"
#	}
# }
var spawnTableLookup: Dictionary = {}
const ALIENS_KEY = "aliens"
const ALIEN_WEIGHT_KEY = "weight"
const STAGE_TOTAL_WEIGHT_KEY = "total_weight"
const WILDCARD_STAGE = "*"

func _init() -> void:
	for spawnTableRow in spawnTableRows:
		if spawnTableRow.is_valid():
			var stage_number = WILDCARD_STAGE if spawnTableRow.is_wildcard() else spawnTableRow.stage_number
			var alien_index = spawnTableRow.alien_index
			var alien_weight = spawnTableRow.weight
			var existingSpawnInformation = spawnTableLookup.get(stage_number, {})
			spawnTableLookup[stage_number] = existingSpawnInformation
			var currentAliensSection = existingSpawnInformation.get(ALIENS_KEY, {})
			spawnTableLookup[stage_number][ALIENS_KEY] = currentAliensSection
			var currentAlien = currentAliensSection.get(alien_index, {})
			spawnTableLookup[stage_number][ALIENS_KEY][alien_index] = currentAlien
			var currentWeight = currentAlien.get(ALIEN_WEIGHT_KEY, 0)
			spawnTableLookup[stage_number][ALIENS_KEY][alien_index][ALIEN_WEIGHT_KEY] = currentWeight + alien_weight
			var currentTotalWeight = existingSpawnInformation.get(STAGE_TOTAL_WEIGHT_KEY, 0)
			spawnTableLookup[stage_number][STAGE_TOTAL_WEIGHT_KEY] = currentTotalWeight + alien_weight

func get_current_stage_in_table():
	return Global.current_stage if Global.current_stage in spawnTableLookup else WILDCARD_STAGE

func is_current_stage_in_table_wildcard():
	return str(get_current_stage_in_table()) == WILDCARD_STAGE

## potential future todo after discussion: should we mutate the wildcard stage for a given run every time it is beaten?
func mutate_stage_in_table(_stage_id):
	pass

func mutate_wildcard_stage():
	mutate_stage_in_table(WILDCARD_STAGE)

# 1 alien type, always picks that
# 2 alien types, evenly weighted, total weight 2:
# 	pick a number from 1, 2...
#	let's say die roll is 1:
#		loop over aliens
#			first alien has weight of 1, accumulate 1, first alien is selected
#	let's say die roll is 2:
#		loop over aliens
#			first alien has weight of 1, accumulate 1, first alien is not selected
#			second alien has weight of 1, accumulate 2, second alien is selected
# 3 alien types, evenly weighted, total weight 3:
# 	pick a number from 1, 2, 3...
#	let's say die roll is 1:
#		loop over aliens
#			first alien has weight of 1, accumulate 1, first alien is selected
#	let's say die roll is 2:
#		loop over aliens
#			first alien has weight of 1, accumulate 1, first alien is not selected
#			second alien has weight of 1, accumulate 2, second alien is selected
#	let's say die roll is 3:
#		loop over aliens
#			first alien has weight of 1, accumulate 1, first alien is not selected
#			second alien has weight of 1, accumulate 2, second alien is not selected
#			third alien has weight of 1, accumulate 3, third alien is selected

func pick_an_alien_type():
	var current_stage = get_current_stage_in_table()
	var existingSpawnInformation = spawnTableLookup[current_stage]
	var dieRoll = randi_range(1, existingSpawnInformation[STAGE_TOTAL_WEIGHT_KEY])
	var accumulatedWeight = 0
	var aliens = existingSpawnInformation[ALIENS_KEY]
	var last_alien_index_seen = null
	for alien_index in aliens.keys():
		accumulatedWeight += aliens[alien_index][ALIEN_WEIGHT_KEY]
		if dieRoll <= accumulatedWeight:
			return alien_index
		else:
			last_alien_index_seen = alien_index
	return last_alien_index_seen
