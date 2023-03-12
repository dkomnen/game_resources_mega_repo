extends AudioStreamPlayer2D

## Volume before crossfade.
var previous_volume

func _ready():
    save_volume()

func save_volume():
    previous_volume = volume_db