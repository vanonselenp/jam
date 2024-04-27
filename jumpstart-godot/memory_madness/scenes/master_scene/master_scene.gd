extends CanvasLayer


@onready var sound = $Sound
@onready var main_screen = $MainScreen
@onready var game_screen = $GameScreen


enum GAME_STATE {
	GAME,
	MAIN
}


func _ready():
	on_game_exited_pressed()
	SignalManager.on_game_exited_pressed.connect(on_game_exited_pressed)
	SignalManager.on_level_selected.connect(on_level_selected)


func show_game(state: GAME_STATE) -> void:
	game_screen.visible = state == GAME_STATE.GAME
	main_screen.visible = state == GAME_STATE.MAIN


func on_game_exited_pressed() -> void:
	show_game(GAME_STATE.MAIN)
	GameManager.clear_nodes_of_group(GameManager.TILE_GROUP)
	SoundManager.play_sound(sound, SoundManager.SOUND_MAIN_MENU)


func on_level_selected(_level_num: int) -> void:
	show_game(GAME_STATE.GAME)
	SoundManager.play_sound(sound, SoundManager.SOUND_IN_GAME)
	
