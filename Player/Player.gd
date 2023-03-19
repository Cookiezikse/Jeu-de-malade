extends CharacterBody2D

@onready var animation_player = $AnimationPlayer

const SPEED = 150.0


func _physics_process(delta):
	
	if animation_player.current_animation == "attack" or animation_player.current_animation == "dash_attack":
		return
	else:
		movement_loop()
		attack_movement()
		move_and_slide()
	
func movement_loop():
	
	var horizontale = Input.get_axis("ui_left", "ui_right") 
	var verticale = Input.get_axis("ui_up", "ui_down")
	
	#direction horizontale
	if horizontale == 1:
		velocity.x = horizontale * SPEED 
		animation_loop("run")
		$Sprite2D.flip_h = false
	elif horizontale == -1:
		velocity.x = horizontale * SPEED 
		animation_loop("run")
		$Sprite2D.flip_h = true
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
		
	#direction verticale
	if verticale:
		velocity.y = verticale * SPEED
		animation_loop("run")
	
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if !horizontale and !verticale:
		animation_loop("idle")

#fonction d'attaque 	
func attack_movement():
	
	#dash attaque
	if Input.is_action_pressed("ui_accept") and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
		animation_loop("dash_attack")
		
	#attaque simple
	elif Input.is_action_pressed("ui_accept"):
		animation_loop("attack")
		
#fonction d'animation  
func animation_loop(animation):

	if animation_player.current_animation != animation:
		animation_player.play(animation)

func take_damage(amount: int) -> void:
	animation_player.play("hurt_effect")
	print("Damage: ", amount)
