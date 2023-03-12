extends Node

@onready
var bass_track = $Bass
@onready
var harm_track = $Harmony
@onready
var mel_track = $Melody
@onready
var rhythm_track = $Rhythm

@export
var crossfade_time_in_seconds: float
@export
var track_max_db: float
@export
var track_min_db: float

@export var hot_swap_1: AudioStreamPlayer2D
@export var hot_swap_2: AudioStreamPlayer2D

var slot_1

var current_time

func _ready():
	current_time = Time.get_ticks_msec()
	hot_swap_1.volume_db = track_max_db
	hot_swap_2.volume_db = track_min_db
	slot_1 = true


func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var fadeout_track: AudioStreamPlayer2D
		var fadein_track: AudioStreamPlayer2D
		if slot_1:
			fadeout_track = hot_swap_1
			fadein_track = hot_swap_2
		else:
			fadeout_track = hot_swap_2
			fadein_track = hot_swap_1
		slot_1 = !slot_1

		fadein_track.volume_db = -20

		var tween1 = create_tween()
		var tween2 = create_tween()

		tween1.tween_property(fadeout_track, "volume_db", track_min_db, crossfade_time_in_seconds)
		tween2.tween_property(fadein_track, "volume_db", track_max_db, crossfade_time_in_seconds)


func _on_timer_timeout():
	print("Hot swap 1 volume = " + str(hot_swap_1.volume_db) + "Hot swap 2 volume = " + str(hot_swap_2.volume_db))
		

