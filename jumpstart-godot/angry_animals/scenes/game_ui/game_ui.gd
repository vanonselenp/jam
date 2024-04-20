extends Control


const MAIN = preload("res://scenes/main/main.tscn")


@onready var level_label = $MarginContainer/HudBox/LevelLabel
@onready var attempts_label = $MarginContainer/HudBox/AttemptsLabel
@onready var game_over_box = $MarginContainer/GameOverBox
@onready var game_sound = $GameSound


# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "Level %s" % ScoreManager.get_level_selected()
	update_attempt(0)
	SignalManager.on_score_updated.connect(update_attempt)
	SignalManager.on_level_complete.connect(on_level_complete)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("menu"): 
		get_tree().change_scene_to_packed(MAIN)


func update_attempt(attempts: int) -> void:
	attempts_label.text = "Attempts %s" % attempts


func on_level_complete() -> void:
	game_over_box.show() 
	game_sound.play()
