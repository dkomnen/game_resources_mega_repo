extends CharacterBody2D

@export var movement_speed = 100

func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
	else:
		velocity.y = 0
	

	velocity = velocity.normalized() * movement_speed

	move_and_slide()