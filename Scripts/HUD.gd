extends Control


func _ready():
	GameManager.enemy_distroyed.connect(_on_enemy_distroyed)
	GameManager.player_hurt.connect(_on_player_hurt)


func _on_player_hurt():
	$Life.text = str(GameManager.life)


func _on_enemy_distroyed(_points):
	$Score.text = "Score: " + str(GameManager.score)
