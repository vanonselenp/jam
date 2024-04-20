extends Control

@onready var timer = $Timer
@onready var end = $MarginContainer/End
@onready var space = $MarginContainer/Space
@onready var game_over_sound = $GameOverSound


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	SignalManager.on_player_death.connect(_on_player_death)


func _process(_delta):
	if Input.is_action_just_pressed("fly") and space.visible:
		GameManager.load_main_scene()


func _on_player_death():
	show()
	timer.start()
	game_over_sound.play()


func _on_timer_timeout():
	end.hide()
	space.show()
