extends Control

@onready
var remapable_keys = {
	"ui_up": "Move up", "ui_down": "Move down", "ui_left": "Move left", "ui_right": "Move right", "ui_accept": "Action"
}

@export
var remap_box: Resource

@onready
var accept_next_input: bool = false
var active_remap_id: String
var remap_boxes: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for key in remapable_keys:
		var box = remap_box.instantiate()
		$ScrollContainer/VBoxContainer.add_child(box)
		box.remap_box_id = key
		box.connect("remap_start", _remap_btn_pressed)
		remap_boxes[key] = box
	_refresh_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed and accept_next_input:
		accept_next_input = false
		KeyPersistence.remap_key(active_remap_id, event)
		KeyPersistence.keymaps[active_remap_id] = event
		KeyPersistence.save_keymap_to_file()
		_refresh_ui()


func _remap_btn_pressed(input_name: String):
	accept_next_input = true
	remap_boxes[input_name].get_node("RemapButton").text = "Press any key"
	for key in remap_boxes:
		if key != input_name:
			remap_boxes[key].get_node("RemapButton").disabled = true
	active_remap_id = input_name

func _refresh_ui():
	for key in remap_boxes:
		var box = remap_boxes[key]
		box.get_node("RemapButton").disabled = false
		box.get_node("InputMapLabel").text = remapable_keys[key]
		box.get_node("RemapButton").text = InputMap.action_get_events(key)[0].as_text()



func _on_reset_controls_button_pressed():
	InputMap.load_from_project_settings()
	_refresh_ui()
	KeyPersistence.load_project_input_map()
	KeyPersistence.save_keymap_to_file()
