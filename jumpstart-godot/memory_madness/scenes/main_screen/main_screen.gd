extends Control


@export var level_button_scene: PackedScene

@onready var hb_levels = $VBoxContainer/HBLevels

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()


func setup_grid() -> void:
	for level in GameManager.LEVELS:
		create_level_button(level)


func create_level_button(level_num: int) -> void:
	var button = level_button_scene.instantiate()
	hb_levels.add_child(button)
	button.set_level_number(level_num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
