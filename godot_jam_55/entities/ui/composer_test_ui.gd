extends CanvasLayer

@export var dropdowns_parent: Node
@export var toggles_parent: Node

@onready var composer = get_node("../Composer")
@onready var tracks := composer.get_children()

func _ready():
	_add_dropdowns()
	_add_toggles()


func _add_dropdowns():
	for track in tracks:
		var labeled_button := VBoxContainer.new()
		labeled_button.alignment = BoxContainer.ALIGNMENT_CENTER
		labeled_button.size_flags_horizontal = Control.SIZE_EXPAND

		var button := OptionButton.new()
		button.item_selected.connect(composer._on_stream_selected.bind(track))

		for stream in track.streams:
			button.add_item(stream.name)
			
		labeled_button.add_child(button)
		labeled_button.add_child(_get_dropdown_label(track))

		dropdowns_parent.add_child(labeled_button)

func _get_dropdown_label(track) -> Label:
	var label := Label.new()
	label.text = track.name
	return label
	

func _add_toggles():
	var play_toggle := CheckButton.new()
	play_toggle.text = "PLAY"
	play_toggle.toggled.connect(_play_stop_toggle)
	toggles_parent.add_child(play_toggle)
	
	var mute_toggle := CheckButton.new()
	mute_toggle.text = "MUTE ALL"
	mute_toggle.toggled.connect(_mute_unmute_toggle)
	toggles_parent.add_child(mute_toggle)


func _play_stop_toggle(pressed: bool):
	if pressed:
		composer.play_all_tracks()
	else:
		composer.stop_all_tracks()

func _mute_unmute_toggle(pressed: bool):
	if pressed:
		composer.mute_all_tracks()
	else:
		composer.unmute_all_tracks()
