extends CanvasLayer

@export var dropdowns_parent: Node

@onready var composer = get_node("../Composer")
@onready var tracks := composer.get_children()

var streams_dropdowns: Array[OptionButton]

func _ready():

	for track in tracks:
		var button := OptionButton.new()
		streams_dropdowns.push_back(button)
		button.item_selected.connect(composer._on_stream_selected.bind(track))

		for stream in track.streams:
			button.add_item(stream.name)
			
		dropdowns_parent.add_child(button)
