extends Area2D
@onready var shooting_point = $weapon_pivot/Pistol/shooting_point
@onready var pistol = $weapon_pivot/Pistol

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		

func shoot():
	const BULLET = preload("res://prefabs/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.damage = 5
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	shooting_point.add_child(new_bullet)


func _on_timer_timeout():
	shoot() # Replace with function body.
