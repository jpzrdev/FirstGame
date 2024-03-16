extends Node2D
class_name HealthComponent

@export var max_health = 10
var health : float

signal health_depleted
signal damage_taken

func _ready():
	health = max_health
	
func take_damage(damage):
	health -= damage
	
	if health <= 0:
		health_depleted.emit()
	else:
		damage_taken.emit()
		

