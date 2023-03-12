extends Node

@export var initial_stream: AudioStreamPlayer2D

@onready var streams := get_children()

func mute():
    for stream in streams:
        stream.save_volume()
        stream.set_volume_db(-80)
    print(name + " muted")
    
func unmute():
    for stream in streams:
        stream.set_volume_db(stream.previous_volume)
    print(name + " unmuted")
            
func start_all_streams():
    for stream in streams:
        stream.play()
    print(name + " started")

func stop_all_streams():
    for stream in streams:
        stream.stop()
    print(name + " stopped")
    