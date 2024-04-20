extends ParallaxBackground


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_death.connect(on_player_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset.x -= delta * GameManager.SCROLL_SPEED


func on_player_death():
	set_process(false)
