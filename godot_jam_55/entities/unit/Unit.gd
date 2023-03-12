extends Area2D


var unit_sprite : Sprite2D
var idle_move_timer : Timer

var unit_idle_move : bool = true
var idle_move_target : Vector2
var idle_move_speed : float = 30
var idle_move_range : int = 80

# Called when the node enters the scene tree for the first time.
func _ready():
	unit_sprite = $UnitSprite
	idle_move_timer = $MoveTimer

	idle_move_target = get_new_idle_move_target()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if unit_idle_move:
		unit_sprite.position.direction_to(idle_move_target)
		unit_sprite.position += unit_sprite.position.direction_to(idle_move_target) * idle_move_speed * delta
		if unit_sprite.position.distance_to(idle_move_target) < 1:
			unit_idle_move = false
			idle_move_timer.start()

func start_move_anim() -> void:
	unit_idle_move = true

func get_new_idle_move_target() -> Vector2:
	var new_target = Vector2(randi_range(-idle_move_range,idle_move_range), randi_range(-idle_move_range,idle_move_range))
	return new_target

func _on_move_timer_timeout():
	idle_move_target = get_new_idle_move_target()
	start_move_anim()
