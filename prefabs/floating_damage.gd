extends Marker2D
@onready var animation_player = $AnimationPlayer
@onready var label = $Label as Label

func popup_damage(damage):
	label.text = str(damage)
	animation_player.play("popup_damage")
