extends Area2D
class_name Projectile

@export var speed : float


func _process(delta):
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	if area is Laser:
		queue_free()
