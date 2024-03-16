extends Marker2D
class_name FloatingDamageComponent
@onready var label = $Label
@onready var animation_player = $AnimationPlayer

func popup_damage(damage):
	label.text = str(damage)
	animation_player.play("popup_damage")
