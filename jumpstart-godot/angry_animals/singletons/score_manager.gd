extends Node


const DEFAULT_SCORE = 1000
const SCORES_PATH = "user://animals.json"


var _current_level: int = -1
var _level_scores: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	_level_scores = load_file()


func set_level_selected(level_selected: int) -> void:
	_current_level = level_selected


func get_level_selected() -> int:
	return _current_level


func set_score_for_level(level: String, score: int) -> void:
	if not _level_scores.has(level) or _level_scores[level] > score:
		_level_scores[level] = score
		save_scores()


func get_score_for_level(level: String) -> int:
	if _level_scores.has(level):
		return _level_scores[level]
		
	return DEFAULT_SCORE


func save_scores() -> void:
	var score_file = FileAccess.open(SCORES_PATH, FileAccess.WRITE)
	score_file.store_string(JSON.stringify(_level_scores))


func load_file() -> Dictionary:
	if FileAccess.file_exists(SCORES_PATH):
		var file = FileAccess.open(SCORES_PATH, FileAccess.READ)
		return JSON.parse_string(file.get_as_text())
		
	return {}
