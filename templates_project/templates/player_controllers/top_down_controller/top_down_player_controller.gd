extends CharacterBody2D

@export var movement_speed: float = 100
@export var accelleration: float = 0.1

var direction = Vector2()

func _physics_process(delta):
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y =  Input.get_axis("ui_up", "ui_down")

	velocity = velocity.lerp(direction.normalized() * movement_speed, accelleration * delta)

	move_and_slide()
