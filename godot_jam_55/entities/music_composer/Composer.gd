class_name Composer
extends Node

@export var crossfade_time_in_seconds: float
@export var crossfade_floor: float

@onready var tracks := get_children()

var current_streams := {}

func _ready():
	mute_all_tracks()

	for track in tracks:
		current_streams[track] = track.initial_stream
		track.initial_stream.set_volume_db(track.initial_stream.previous_volume)
		

func crossfade(stream_out: AudioStreamPlayer2D, stream_in: AudioStreamPlayer2D):
	var tween_out = create_tween()
	var tween_in = create_tween()

	stream_out.save_volume()
	stream_in.set_volume_db(crossfade_floor)

	tween_out.tween_property(stream_out, "volume_db", crossfade_floor, crossfade_time_in_seconds)
	tween_in.parallel().tween_property(stream_in, "volume_db", stream_in.previous_volume, crossfade_time_in_seconds)

func _on_stream_selected(stream_index: int, changed_track: Node):
	var new_stream = changed_track.streams[stream_index]
	crossfade(current_streams[changed_track], new_stream)
	current_streams[changed_track] = new_stream
	print(changed_track.name, stream_index)


func mute_all_tracks():
	for track in tracks:
		track.mute()

func unmute_all_tracks():
	for track in tracks:
		track.unmute()

func stop_all_tracks():
	for track in tracks:
		track.stop_all_streams()

func play_all_tracks():
	for track in tracks:
		track.start_all_streams()
