extends Node2D
class_name ResistanceWeaknessComponent

@export var has_fire_res_weak = false
@export var fire_res_weak_factor = 0.0
@export var has_water_res_weak = false
@export var water_res_weak_factor = 0.0
@export var has_wind_res_weak = false
@export var wind_res_weak_factor = 0.0
@export var has_earth_res_weak = false
@export var earth_res_weak_factor = 0.0

var factor_sum = 0

func apply_res_weakness_factor_multiplier(damage,types):
	for type in types:
		if type == Attack.FIRE and has_fire_res_weak:
			factor_sum += fire_res_weak_factor 
		if type == Attack.WATER and has_water_res_weak:
			factor_sum += water_res_weak_factor
		if type == Attack.WIND and has_wind_res_weak:
			factor_sum += wind_res_weak_factor
		if type == Attack.EARTH and has_earth_res_weak:
			factor_sum +=earth_res_weak_factor
	
	if factor_sum != 0:
		return damage * (factor_sum / types.size())
	else: 
		return damage 
