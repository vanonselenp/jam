extends Node

const GROUP_PLAYER: String = "player"
const SCROLL_SPEED: float = 120.0

var main_scene: PackedScene = preload("res://scenes/main/main.tscn")
var game_scene: PackedScene = preload("res://scenes/game/game.tscn")
var game_over_scene: PackedScene = preload("res://scenes/gameover/game_over.tscn")


func load_game_scene() -> void:
	get_tree().change_scene_to_packed(game_scene)


func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)


func load_game_over_scene() -> void:
	get_tree().scene(game_over_scene)
