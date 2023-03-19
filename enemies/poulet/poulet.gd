extends CharacterBody2D

enum CHICKEN_STATE { IDLE, RUN }
var current_state : CHICKEN_STATE = CHICKEN_STATE.IDLE

var move_speed : float = 20
var move_direction : Vector2 = Vector2.ZERO

@export var idle_time : float = 2
@export var run_time : float = 2

@onready var animation_chicken = $AnimationPlayer
@onready var chicken_idle = $ChickenIdle
@onready var chicken_run = $ChickenRun
@onready var timer = $Timer


func _ready():
	pick_new_state()

func _physics_process(delta):
	if(current_state == CHICKEN_STATE.RUN):
		velocity = move_direction * move_speed
		move_and_slide()

func select_new_direction():
	move_direction = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	if move_direction.x < 0:
		chicken_run.flip_h = false
	elif move_direction.x > 0:
		chicken_run.flip_h = true

#change entre courir et rester sur place
func pick_new_state():
	#Passer en RUN STATE
	if(current_state == CHICKEN_STATE.IDLE):
		chicken_idle.hide()
		chicken_run.show()
		animation_loop("run")
		current_state = CHICKEN_STATE.RUN
		select_new_direction()
		timer.start(run_time)
		
	#Passer en IDLE STATE
	elif(current_state == CHICKEN_STATE.RUN):
		chicken_run.hide()
		chicken_idle.show()
		animation_loop("idle")
		current_state = CHICKEN_STATE.IDLE
		timer.start(idle_time)

func _on_timer_timeout():
	pick_new_state()

#fonction d'animation  
func animation_loop(animation):
	if animation_chicken.current_animation != animation:
		animation_chicken.play(animation)
