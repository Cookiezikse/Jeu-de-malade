extends CharacterBody2D

const SPEED = 300.0

func _physics_process(delta):


	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	var direction2 = Input.get_axis("ui_left", "ui_right")
	if direction2:
		velocity.y = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
