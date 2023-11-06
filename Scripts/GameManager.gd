extends Node

signal player_hurt
signal enemy_distroyed(points)
signal game_over
signal game_won

var life : int = 3
var score : int = 0


func _ready():
	enemy_distroyed.connect(_on_enemy_distroyed)
	player_hurt.connect(_on_player_hurt)


func _on_enemy_distroyed(points):
	score += points


func _on_player_hurt():
	life -= 1
	
	if life <= 0:
		game_over.emit()
