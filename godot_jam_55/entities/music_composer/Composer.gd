extends Node

@onready
var base_track = $BaseTrack
@onready
var hot_swap_1 = $HotSwap1
@onready
var hot_swap_2 = $HotSwap2

@export
var track_transition_time_in_seconds: float
var slot_1

var current_time
# Called when the node enters the scene tree for the first time.
func _ready():
	current_time = Time.get_ticks_msec()
	hot_swap_2.volume_db = -100
	slot_1 = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		var fadeout_track
		var fadein_track
		if slot_1:
			fadeout_track = hot_swap_1
			fadein_track = hot_swap_2
		else:
			fadeout_track = hot_swap_2
			fadein_track = hot_swap_1
		slot_1 = !slot_1
		var tween1 = get_tree().create_tween()
		tween1.tween_property(fadeout_track, "volume_db", -100, track_transition_time_in_seconds)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(fadein_track, "volume_db", 0, track_transition_time_in_seconds)




func _on_timer_timeout():
	print("Hot swap 1 volume = " + str(hot_swap_1.volume_db))
	print("Hot swap 2 volume = " + str(hot_swap_2.volume_db))

