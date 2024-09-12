extends Node
## Please Update
const SAVE_PATH = "user://por_nada.save"
const PROGRESS_PATH = "user://por_nada_progress.save"
const PASSWORD = "por_nada"

var save_file
var total_wins : int
var current_stage : int


var current_alien_count = 0


func get_current_tree():
	return get_tree()


#region Save & Progress Dicts
## 5a: A new blank save that saves generic data
func new_save():
	return {
		"Save" = 0
	}

## 5b: A new blank progress save that saves different sort of progress data
func new_progress():
	return {
		"Progress": {
			"Total Wins": 0,
			"Current Stage": 1
		}
	}

## 2a: Generates a new save dictionary to save current data
func generate_save_dict():
	return {
		"Save" : save_file
	}

## 2b: Generates a new progress save dictionary to save current progress
func generate_progress_dict():
	return {
		"Progress": {
			"Total Wins": total_wins,
			"Current Stage": current_stage
			#"Wins": wins,
			#"Losses": losses
		}
	}
#endregion 

## 1: create a new savegame file and store it in local storage
func save_game(save_path = SAVE_PATH):
	var new_save_game = FileAccess.open_encrypted_with_pass(save_path, FileAccess.WRITE, PASSWORD)
	var json_string
	if save_path == SAVE_PATH:
		json_string = JSON.stringify(generate_save_dict())
	elif save_path == PROGRESS_PATH:
		json_string = JSON.stringify(generate_progress_dict())
	new_save_game.store_line(json_string)
	new_save_game.close()
	print("saved at {0}: {1}".format([save_path, json_string]))

## 5: return if a file already exists
func save_file_exists(save_path = SAVE_PATH):
	return FileAccess.file_exists(save_path)

## 4: access the save file to load data back into the game
func load_game(save_path = SAVE_PATH):
	if !save_file_exists(save_path):
		if save_path == SAVE_PATH:
			return new_save()
		if save_path == PROGRESS_PATH:
			return new_progress()
	else:
		var saveFile = FileAccess.open_encrypted_with_pass(save_path, FileAccess.READ, PASSWORD)
		var saveData = saveFile.get_as_text()
		saveFile.close()
		var jsonParser = JSON.new()
		var error = jsonParser.parse(saveData)
		if error == OK:
			return jsonParser.data
		else:
			print("JSON Parse Error: ", jsonParser.get_error_message(), " in ", saveData, " at line ", jsonParser.get_error_line())

## 3: access the save file to load progress back into the game
func load_progress_variables():
	var loaded_progress_vars = load_game(PROGRESS_PATH)
	var default_progress_values = new_progress() # For new versions of save files
	var progress = loaded_progress_vars.get("Progress", default_progress_values["Progress"])
	total_wins = progress.get("Total Wins", 0)
	current_stage = progress.get("Current Stage", 0)
	#wins = progress.get("Wins", 0)
	#losses = progress.get("Losses", 0)

## Put all necessary quitting logic here
func quit_game():
	get_tree().quit()
