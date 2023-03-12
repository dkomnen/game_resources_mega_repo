extends CanvasLayer

@export
var panning_speed : float = 5
var panning_direction = Vector2(0,0)
var panning_direction_keyboard = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	panning_direction_keyboard.x = Input.get_axis("ui_left", "ui_right")
	panning_direction_keyboard.y =  Input.get_axis("ui_up", "ui_down")
	pan_camera()

func _input(event):
	if event is InputEventMouseMotion:
		panning_direction = Vector2(0,0)
		print(str(get_viewport().size.x) + " - " + str(event.position.x))
		$MouseCursor.position = event.position
		if event.position.x <= 0:
			panning_direction.x = -1
		if event.position.y <= 0:
			panning_direction.y = -1
		if event.position.x >= get_viewport().size.x - 1:
			panning_direction.x = 1
		if event.position.y >= get_viewport().size.y - 1:
			panning_direction.y = 1

func pan_camera():
	get_viewport().get_camera_2d().position += (panning_direction + panning_direction_keyboard).normalized() * panning_speed