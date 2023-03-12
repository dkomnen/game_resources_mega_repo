extends Camera2D

@export
var zoom_intensity : float = 0.05
@export
var min_allowed_zoom : float = 0.5
@export
var max_allowed_zoom : float = 2.0
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom.x = min(zoom.x + zoom_intensity, max_allowed_zoom)
			zoom.y = min(zoom.y + zoom_intensity, max_allowed_zoom)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom.x = max(zoom.x - zoom_intensity, min_allowed_zoom)
			zoom.y = max(zoom.y - zoom_intensity, min_allowed_zoom)
