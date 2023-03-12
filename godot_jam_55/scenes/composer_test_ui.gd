extends CanvasLayer

@export var dropdowns_parent: Node

@onready var composer = get_node("../Composer")
@onready var tracks := composer.get_children()

var streams_dropdowns: Array[OptionButton]

func _ready():

	for track in tracks:
		var button := OptionButton.new()
		streams_dropdowns.push_back(button)
		button.item_selected.connect(_get_stream_name_from_id.bind(button))

		for stream_player in track.stream_players:
			button.add_item(stream_player.name)
			
		dropdowns_parent.add_child(button)

func _get_stream_name_from_id(id: int, button: OptionButton):
	var stream_name := button.get_item_text(id)
	composer.on_stream_selected(stream_name)
