extends CharacterBody2D

@onready var player = get_node("/root/Game/player")
@onready var anim = $anim as AnimatedSprite2D
@onready var damage_popup = $damage_popup


@export var health = 30
@export var recieve_knockback = true

var is_hurted = false
var is_dead = false

signal enemy_died

func _ready():
	set_state("walk")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	
	if is_hurted:
		velocity = direction * 200
		
	if is_dead:
		velocity = Vector2.ZERO
	
	move_and_slide()
		

func take_damage(damage):
	health -= damage
	
	var floating_damage = preload("res://prefabs/floating_damage.tscn").instantiate()
	floating_damage.position = damage_popup.global_position
	
	get_tree().current_scene.add_child(floating_damage)
	get_tree().current_scene.move_child(floating_damage,0)
	floating_damage.popup_damage(damage)
	
	if not is_dead:
		set_state("hit")
	
	is_hurted = true
	
	if health <= 0:
		set_state("dead")
		is_dead = true
	

func apply_knockback(source_position, knockback_force):
	if recieve_knockback:
		var knockback_direction = source_position.direction_to(global_position)
		var knockback = global_position + (knockback_direction * (knockback_force * 0.6))
	
		var tween = create_tween()
		tween.tween_property(self, "position", knockback, 0.2).set_ease(Tween.EASE_IN_OUT)
	
		take_damage(1)
		

func set_state(anim_name):
	anim.play(anim_name)




func _on_anim_animation_finished():
	if anim.animation == "hit":
		is_hurted = false
		set_state("walk")	
		
	if anim.animation == "dead":
		is_dead = true
		queue_free() 
