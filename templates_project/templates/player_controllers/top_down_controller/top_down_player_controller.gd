extends CharacterBody2D

@export var movement_speed = 100

func _physics_process(_delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -movement_speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = movement_speed
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -movement_speed
	elif Input.is_action_pressed("ui_down"):
		velocity.y = movement_speed

	velocity = velocity.normalized()

	move_and_slide()
