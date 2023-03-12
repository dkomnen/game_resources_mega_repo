class_name Composer
extends Node

@onready var tracks = get_children()

@export
var crossfade_time_in_seconds: float
@export
var track_min_db: float

func _ready():
	mute_all_tracks()
	stop_all_tracks()

func crossfade(stream_out: AudioStreamPlayer, stream_in: AudioStreamPlayer):
	var tween_out = create_tween()
	var tween_in = create_tween()

	stream_out.previous_volume = stream_out.volume_db

	tween_out.tween_property(stream_out, "volume_db", track_min_db, crossfade_time_in_seconds)
	tween_in.parallel().tween_property(stream_in, "volume_db", stream_in.previous_volume, crossfade_time_in_seconds)

func on_stream_selected(stream_name: String):
	print(stream_name)

func mute_all_tracks():
	for track in tracks:
		for stream_player in track.stream_players:
			stream_player.set_volume_db(0)

func unmute_all_tracks():
	for track in tracks:
		for stream_player in track.stream_players:
			stream_player.set_volume_db(0)

func stop_all_tracks():
	for track in tracks:
		for stream_player in track.stream_players:
			stream_player.stop()

func play_all_tracks():
	for track in tracks:
		for stream_player in track.stream_players:
			stream_player.play()
