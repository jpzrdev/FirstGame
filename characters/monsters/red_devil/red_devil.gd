extends CharacterBody2D

@onready var player = get_node("/root/Game/player")
@onready var anim = $anim as AnimatedSprite2D
@onready var damage_popup = $damage_popup as Marker2D

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
		velocity = direction * 150
		
	if is_dead:
		velocity = Vector2.ZERO
	
	move_and_slide()
		
	
func apply_knockback(source_position, knockback_force):
	if recieve_knockback:
		var knockback_direction = source_position.direction_to(global_position)
		var knockback = global_position + (knockback_direction * knockback_force)
	
		var tween = create_tween()
		tween.tween_property(self, "position", knockback, 0.2).set_ease(Tween.EASE_IN_OUT)
	
		

func set_state(anim_name):
	anim.play(anim_name)

func _on_anim_animation_finished():
	if anim.animation == "hit":
		is_hurted = false
		set_state("walk")
		
	if anim.animation == "dead":
		is_dead = true
		queue_free()


func _on_health_component_damage_taken():
	if not is_dead:
		set_state("hit")
	
	is_hurted = true


func _on_health_component_health_depleted():
	set_state("dead")
	is_dead = true
