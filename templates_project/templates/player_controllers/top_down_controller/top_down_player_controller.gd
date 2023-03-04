extends CharacterBody2D

@export var movement_speed: float = 500
@export var acceleration: float = 0.2

var direction = Vector2()

func _ready():
	pass

func _physics_process(_delta):
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y =  Input.get_axis("ui_up", "ui_down")
	velocity = velocity.lerp(direction.normalized() * movement_speed, acceleration)

	move_and_slide()
