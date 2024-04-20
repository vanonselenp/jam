extends Node


var _attempts: int = 0
var _cup_hits: int = 0
var _total_cups: int = 0
var _level_number: int = 1


func _ready():
	_total_cups = get_tree().get_nodes_in_group("cup").size()
	_level_number = ScoreManager.get_level_selected()
	SignalManager.on_attempt_made.connect(on_attempt_made)
	SignalManager.on_cup_removed.connect(on_cup_removed)


func on_attempt_made():
	_attempts += 1
	SignalManager.on_score_updated.emit(_attempts)


func on_cup_removed():
	_cup_hits += 1
	if _cup_hits == _total_cups:
		SignalManager.on_level_complete.emit()
		ScoreManager.set_score_for_level(str(_level_number), _attempts)
