extends Control


@onready var label = $MarginContainer/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_score_updated.connect(on_score_updated)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_score_updated(value: int) -> void:
	label.text = str(value)
	
