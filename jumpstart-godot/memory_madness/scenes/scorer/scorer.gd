extends Node


class_name Scorer


@onready var reveal_timer = $RevealTimer
@onready var sound = $Sound


var selections: Array = []
var target_pairs = 0
var moves_made = 0
var pairs_made = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_tile_selected.connect(on_tile_selected)
	SignalManager.on_game_exited_pressed.connect(on_game_exited_pressed)


func clear_new_game(_target_pairs: int) -> void:
	selections.clear()
	target_pairs = _target_pairs
	moves_made = 0
	pairs_made = 0


func check_pair_made(tile: MemoryTile) -> void:
	tile.reveal(true)
	
	if tile not in selections:
		selections.append(tile)
	
	if selections.size() != 2:
		return
		
	SignalManager.on_selection_disabled.emit()
	moves_made += 1

	update_selections()


func update_selections() -> void:
	reveal_timer.start()
	
	if selections[0].get_item_name() == selections[1].get_item_name():
		kill_tiles()


func check_game_over() -> void:
	if target_pairs == pairs_made:
		SignalManager.on_game_over.emit(moves_made)


func kill_tiles() -> void:
	for item in selections:
		item.kill_on_success()

	pairs_made += 1

	selections.clear()
	SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)


func on_tile_selected(tile: MemoryTile) -> void:
	SoundManager.play_tile_click(sound)
	check_pair_made(tile)


func hide_selections() -> void:
	for tile in selections:
		tile.reveal(false)
		
	selections.clear()


func _on_reveal_timer_timeout():
	SignalManager.on_selection_enabled.emit()
	hide_selections()
	check_game_over()


func on_game_exited_pressed() -> void:
	reveal_timer.stop()


func get_moves_made() -> String:
	return str(moves_made)


func get_pairs_made() -> String:
	return "%s / %s" % [pairs_made, target_pairs]
