extends CharacterBody2D
class_name Player

# movement
@export var max_speed : float
@export var acceleration : float
@export var decceleration : float
var current_speed : float = 0
var direction


func _physics_process(_delta):
	direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if direction:
		current_speed = move_toward(current_speed, max_speed, acceleration)
		velocity.x = current_speed * direction
	else:
		velocity.x = move_toward(velocity.x, 0, decceleration)
	
	move_and_slide()


func hurt():
	set_physics_process(false)
	$AnimationPlayer.play("destroy")


func _on_hurt_area_entered(area):
	if area is Projectile:
		area.queue_free()
		GameManager.player_hurt.emit()
		hurt()
