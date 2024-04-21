extends TextureButton


@onready var label = $Label
@onready var sound = $Sound


var level_number: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_level_number(level_num: int) -> void:
	level_number = level_num
	var level = GameManager.LEVELS[level_number]
	label.text = "%sx%s" % [level.rows, level.cols]


func _on_pressed():
	SoundManager.play_button_click(sound)
	SignalManager.on_level_selected.emit(level_number)
