extends TextureButton


const HOVER_SCALE = Vector2(1.1, 1.1)
const DEFAULT_SCALE = Vector2(1.0, 1.0)


@export var level_number: int = 1


@onready var animation_player = $AnimationPlayer
@onready var level_label = $MC/VBoxContainer/LevelLabel
@onready var score_label = $MC/VBoxContainer/ScoreLabel


var _level_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = "%s" % level_number
	_level_scene = load("res://scenes/level/level_%s.tscn" % level_number)


func _on_mouse_entered():
	animation_player.play("hover")


func _on_mouse_exited():
	animation_player.play("RESET")


func _on_pressed():
	get_tree().change_scene_to_packed(_level_scene)