extends Node


var _current_level: int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func set_level_selected(level_selected: int) -> void:
	_current_level = level_selected


func get_level_selected() -> int:
	return _current_level
