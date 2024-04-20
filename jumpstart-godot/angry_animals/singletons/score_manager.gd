extends Node


const DEFAULT_SCORE = 1000


var _current_level: int = -1
var _level_scores: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_level_selected(level_selected: int) -> void:
	_current_level = level_selected


func get_level_selected() -> int:
	return _current_level


func set_score_for_level(level: String, score: int) -> void:
	if not _level_scores.has(level) or _level_scores[level] > score:
		_level_scores[level] = score


func get_score_for_level(level: String) -> int:
	if _level_scores.has(level):
		return _level_scores[level]
		
	return DEFAULT_SCORE
