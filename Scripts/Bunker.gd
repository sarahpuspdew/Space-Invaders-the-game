extends Area2D

@export var sprite : Sprite2D
@export var sprites : Array[Texture2D]

const MAX_DAMAGE : int = 3
var damage : int = 0


func _ready():
	self.area_entered.connect(_on_area_entered)


func _on_area_entered(area):
	if area is Laser or Projectile:
		area.queue_free()
		
		if damage < MAX_DAMAGE:
			damage += 1
			sprite.texture = sprites[damage - 1]
		else:
			queue_free()
	
	if area is Invader:
		queue_free()
