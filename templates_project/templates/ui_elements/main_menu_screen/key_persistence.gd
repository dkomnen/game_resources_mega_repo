extends Node

const keymaps_path = "user://keymaps.dat"
var keymaps: Dictionary


func _ready() -> void:
	# First we create the keymap dictionary on startup with all
	# the keymap actions we have.
	load_project_input_map()
	load_keymap_from_file()

func load_project_input_map():
	for action in InputMap.get_actions():
		if InputMap.action_get_events(action).size() != 0:
			keymaps[action] = InputMap.action_get_events(action)[0]

func load_keymap_from_file() -> void:
	if not FileAccess.file_exists(keymaps_path):
		save_keymap_to_file() # There is no save file yet, so let's create one.
		return
	var file = FileAccess.open(keymaps_path, FileAccess.READ)
	var temp_keymap = file.get_var(true) as Dictionary
	file.close()
	# We don't just replace the keymaps dictionary, because if you
	# updated your game and removed/added keymaps, the data of this
	# save file may have invalid actions. So we check one by one to
	# make sure that the keymap dictionary really has all current actions.
	for action in keymaps.keys():
		if temp_keymap.has(action):
			keymaps[action] = temp_keymap[action]
			# Whilst setting the keymap dictionary, we also set the
			# correct InputMap event
			remap_key(action, keymaps[action])

func remap_key(action: String, event: InputEvent) -> void:
	InputMap.action_erase_events(action)
	InputMap.action_add_event(action, event)

func save_keymap_to_file() -> void:
	# For saving the keymap, we just save the entire dictionary as a var.
	var file = FileAccess.open(keymaps_path, FileAccess.WRITE)
	file.store_var(keymaps, true)
	# file.store_var({"a":1, "b":2})
	file.close()
