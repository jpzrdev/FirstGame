extends Area2D
class_name HurtboxComponent

@export var healt_component : HealthComponent
@export var resistance_component : ResistanceWeaknessComponent
@onready var floating_damage_component = $FloatingDamageComponent

var can_take_damage = true

func apply_damage(attack : Attack):	
	if can_take_damage:
		var recalculated_damage = resistance_component.apply_res_weakness_factor_multiplier(attack.damage, attack.types)
		healt_component.take_damage(recalculated_damage)
		var floating_damage = preload("res://scenes/FloatingDamageComponent.tscn").instantiate()
		
		floating_damage.position = global_position

		get_tree().current_scene.add_child(floating_damage)
		floating_damage.popup_damage(recalculated_damage)
	
	

func _on_health_component_health_depleted():
	can_take_damage = false
