extends CharacterBody2D

@export var movement_speed: float = 100
@export_range(0, 1, 0.01) var accelleration: float = 0.1

var direction = Vector2()

func _physics_process(_delta):
	var input = Vector2.ZERO
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y =  Input.get_axis("ui_up", "ui_down")

	direction = direction.lerp(input, accelleration)
	velocity = direction.normalized() * movement_speed

	print(velocity)

	move_and_slide()
