extends CharacterBody2D

@onready var hurt_box = $hurt_box as Area2D
@onready var wave_cooldown = $shock_wave/wave_cooldown as Timer
@onready var wave_area = $shock_wave/wave_area as Area2D
@onready var wave_cd_bar = $shock_wave/wave_cd_bar as ProgressBar
@onready var health_bar = $health_bar  as ProgressBar
@onready var wave_animation = $shock_wave/wave_animation as AnimatedSprite2D
@onready var animation = $animation as AnimatedSprite2D
@onready var player_1 = $player_1
@onready var marker_2d = $Marker2D

var wave_on_cooldown = false

signal health_depleted

var health = 100.0

func _unhandled_input(_event):
	if Input.is_action_just_pressed("push_wave"):
		push_enemies()

func _physics_process(delta):
	var direction  = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		player_1.play_walk_animation()
	else:
		player_1.play_idle_animation()

		
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	

	const DAMAGE_RATE = 15.0
	
	if overlapping_mobs.size() > 0:
		
		player_1.play_hurt_animation()
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		health_bar.value = health
		
		if health <= 0.0:
			health_depleted.emit()
			
	if wave_on_cooldown:
		wave_cd_bar.value = wave_cooldown.time_left
			
func push_enemies():
	if not wave_on_cooldown:
		wave_animation.play("shock_wave")
		wave_on_cooldown = true
		wave_cooldown.start()
		wave_cd_bar.show()
		var enemies = wave_area.get_overlapping_bodies()
	
		if enemies.size() > 0:
			for enemy in enemies:
				enemy.apply_knockback(global_position, 400)
		
		
		

func _on_push_cooldown_timeout():
	wave_on_cooldown = false
	wave_cd_bar.hide()
	
func recover_health():
	health += 10.0
	
	if health > 100.0:
		health = 100.0
	
	health_bar.value = health
