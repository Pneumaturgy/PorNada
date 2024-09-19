
extends Resource
class_name SpawnTableRow

@export var stage_number: int
@export var alien_index: int
@export var weight: int = 0

### is_wildcard
### this method causes this row to be considered as the last entry
###		on the spawn table when all other available stage numbers
###		have been exhausted
###	we consider all negative stage numbers to be a magic number to
###		indicate that this is a wildcard entry
func is_wildcard():
	return stage_number < 0

### is_valid
### is this row a valid entry in the spawn table?
###		if not, then we do not take it into account
###		to be considered valid, the following criteria must be met:
###			- weight must be greater than zero (otherwise we should ignore this entry)
###			- alien_index must be within the bounds of the preloaded alien array on AlienSpawner
func is_valid():
	return weight > 0 and alien_index >= 0 and alien_index < Global.number_of_alien_types
