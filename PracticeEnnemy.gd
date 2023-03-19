extends Node2D

onready var animation_player := $AnimationPlayer

func take_damage(amount: int) -> void:
	animation_player.play("hit") #animation du joueur lorsqu'il prend un coup
	print("Damage: ", amount)
