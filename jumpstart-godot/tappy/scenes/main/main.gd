extends Control

@onready var high_score = $MarginContainer/HighScore


func _ready():
	high_score.text = str(ScoreManager.get_high_score())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
