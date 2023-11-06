extends Node2D
class_name InvaderSpawner

@export var ROWS = 5
@export var COLUMNS = 11
@export var HORIZONTAL_SPACING = 32
@export var VERTICAL_SPACING = 32
@export var INVADER_HEIGHT = 24
@export var INVADERS_POSITION_X_INCREMENT = 2
@export var INVADERS_POSITION_Y_INCREMENT = 2
@export var START_Y_POSITION = -50

var invader_total_count = ROWS * COLUMNS
var invader_destroyed_count = 0
var movement_direction = 1

var invaders
var invader_projectile = preload("res://Scenes/Projectile.tscn")


func _ready():
	#GameManager.enemy_distroyed.connect(_on_enemy_distroyed)
	#GameManager.game_over.connect(_on_game_over)
	
	var invader_1_res = preload("res://Resources/Invader_1.tres")
	var invader_2_res = preload("res://Resources/Invader_2.tres")
	var invader_3_res = preload("res://Resources/Invader_3.tres")
	invaders = preload("res://Scenes/Invader.tscn")
	
	var invader_config
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif  row == 1 or row == 2:
			invader_config = invader_2_res
		elif row == 3 or row == 4:
			invader_config = invader_3_res
			
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		var START_X_POSITION = (position.x - row_width) / 2
		
		for col in COLUMNS:
			var x = START_X_POSITION + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			
			var spawn_position = Vector2(x, y)
			spawn_invader(invader_config, spawn_position)


func spawn_invader(invader_config, spawn_position):
	var invader = invaders.instantiate() as Invader
	invader.config = invader_config
	invader.position = spawn_position
	add_child(invader)


func move_invaders():
	position.x += INVADERS_POSITION_X_INCREMENT * movement_direction


func invader_shoot():
	var random_child_position = get_children().filter(func (child): return child is Invader).map(func (invader): return invader.global_position).pick_random()

	var projectile = invader_projectile.instantiate() as Projectile
	projectile.global_position = random_child_position
	get_tree().root.add_child(projectile)


func _on_movement_timer_timeout():
	move_invaders()


func _on_shoot_timer_timeout():
	invader_shoot()


func _on_left_boundary_area_entered(_area):
	if(movement_direction == -1):
		position.y += INVADERS_POSITION_Y_INCREMENT 
		movement_direction *= -1


func _on_right_boundary_area_entered(_area):
	if(movement_direction == 1):
			position.y += INVADERS_POSITION_Y_INCREMENT
			movement_direction *= -1


func _on_enemy_distroyed(_points):
	invader_destroyed_count += 1

	if invader_destroyed_count == invader_total_count:
		GameManager.game_won.emit()
		$MovementTimer.stop()
		$ShootTimer.stop()


func _on_game_over():
	$MovementTimer.stop()
	$ShootTimer.stop()
