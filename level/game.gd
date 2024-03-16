extends Node2D

@onready var path_follow_2d = $player/Path2D/PathFollow2D

@onready var game_over = $GameOver
@onready var player = $player

@export var max_normal_enemies = 10
@export var normal_enemies_to_boss = 20
var normal_enemy_count = 0
var to_boss_count = 0

var normal_enemy_list = [
	preload("res://characters/monsters/red_devil/red_devil.tscn"),
	preload("res://characters/monsters/purple_devil/purple_devil.tscn")
]

func spawn_mob():
	
	if normal_enemy_count < max_normal_enemies:
		if to_boss_count > normal_enemies_to_boss:
			#var boss = preload("res://characters/monsters/boss/boss.tscn").instantiate()
			#boss.global_position = path_follow_2d.global_position
			#add_child(boss)
			#boss.tree_exited.connect(_on_enemy_died)
			#to_boss_count = 0
			to_boss_count = 0
			pass
		else:
			var random_mob = randi_range(0, normal_enemy_list.size() -1)
			var new_mob = normal_enemy_list[random_mob].instantiate()
			path_follow_2d.progress_ratio = randf()
			new_mob.global_position = path_follow_2d.global_position
			add_child(new_mob)
			new_mob.tree_exited.connect(_on_enemy_died)
			normal_enemy_count += 1
			to_boss_count += 1

func _on_timer_timeout():
	spawn_mob()


func _on_player_health_depleted():
	game_over.visible = true
	get_tree().paused = true

func _on_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_enemy_died():
	player.recover_health()
	
