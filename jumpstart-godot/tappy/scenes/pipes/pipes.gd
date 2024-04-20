extends Node2D

@onready var sound_score = $SoundScore


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_player_death.connect(on_player_death)


func on_player_death():
	set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta * GameManager.SCROLL_SPEED
	

func _on_pipes_screen_exited():
	queue_free()


func _on_pipe_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER):
		body.death()


func _on_laser_body_entered(body):
	if body.is_in_group(GameManager.GROUP_PLAYER) == true:
		ScoreManager.increment_score()
		sound_score.play()
		
