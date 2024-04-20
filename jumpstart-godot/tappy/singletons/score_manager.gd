extends Node


var _score: int = 0
var _high_score: int = 0


func get_score() -> int:
	return _score


func set_score(amount: int) -> void:
	_score = amount
	print("set_score:", _score)
	if _score > _high_score:
		_high_score = _score
		print("_high_score:", _score)
	SignalManager.on_score_updated.emit(_score)


func increment_score() -> void:
	set_score(_score + 1)


func get_high_score() -> int:
	return _high_score


