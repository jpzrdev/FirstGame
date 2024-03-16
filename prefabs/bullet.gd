extends Area2D

var travalled_distance = 0
const SPEED = 1000
const RANGE = 1200

var damage = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travalled_distance += SPEED * delta
	if travalled_distance > RANGE:
		queue_free()
	

func _on_area_entered(area):
	queue_free()
	if area is HurtboxComponent:
		var hurtbox : HurtboxComponent = area
		
		var attack = Attack.new()
		attack.damage = damage
		attack.types = [attack.FIRE]
		attack.knockback_force = 100
		
		hurtbox.apply_damage(attack)
