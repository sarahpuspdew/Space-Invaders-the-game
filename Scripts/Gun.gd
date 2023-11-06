extends Node2D
class_name Gun

@export var bullet : PackedScene
@export var bullet_speed : float
@export var pos : int

var can_shoot : bool = true


func _physics_process(_delta):
	if Input.is_action_just_pressed("shoot"):
		if can_shoot:
			shoot()


func shoot():
	var bullets = bullet.instantiate()
	bullets.global_position = get_parent().global_position - Vector2(0,pos)
	get_tree().root.get_node("Main").add_child(bullets)

	bullets.speed = bullet_speed
	can_shoot = false


func _on_shoot_timer_timeout():
	can_shoot = true
