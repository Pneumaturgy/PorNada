extends Alien
class_name RangedAlien


func _ready():
	super._ready()


func _on_attack_range_body_entered(body):
	if body is Player:
		self.call_deferred("attack")
		is_chasing = false


func _on_attack_range_body_exited(body):
	if body is Player:
		AttackCooldownTimer.stop()
		is_chasing = true
