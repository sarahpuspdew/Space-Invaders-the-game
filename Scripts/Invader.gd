extends Area2D
class_name Invader

@export var config : InvaderResource


func _ready():
	$Sprite2D.texture = config.sprite
	$AnimationPlayer.play(config.animation_name)
	$CollisionShape2D.shape.size = Vector2(config.width, 8)


func _on_area_entered(area):
	if area is Laser:
		area.queue_free()
		$AnimationPlayer.play("destroy")
		GameManager.enemy_distroyed.emit(config.points)
