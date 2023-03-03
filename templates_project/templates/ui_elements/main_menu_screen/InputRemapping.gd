extends Control

@onready
var remapable_keys = [
	"ui_up", "ui_down", "ui_left", "ui_right"
]

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
		box.get_node("InputMapLabel").text = key
		box.get_node("RemapButton").text = InputMap.action_get_events(key)[0].as_text()
		box.remap_box_id = key
		box.connect("remap_start", _remap_btn_pressed)
		remap_boxes[key] = box


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey and event.pressed and accept_next_input:
		accept_next_input = false
		remap_boxes[active_remap_id].get_node("RemapButton").text = event.as_text()
		KeyPersistence.keymaps[active_remap_id] = event
		KeyPersistence.save_keymap()

func _remap_btn_pressed(input_name: String):
	accept_next_input = true
	active_remap_id = input_name

