extends Area2D

@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_death.connect(_on_player_death)


func _on_player_death():
	animation_player.stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
