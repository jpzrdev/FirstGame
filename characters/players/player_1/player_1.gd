extends Node2D

@onready var animation = $animation as AnimatedSprite2D

func play_walk_animation():
	animation.play("walk")
	
func play_idle_animation():
	animation.play("idle")
	
func play_hurt_animation():
	animation.play("hurt")
