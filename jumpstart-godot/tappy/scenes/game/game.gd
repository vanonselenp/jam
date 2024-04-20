extends Node2D


@export var pipes_scene: PackedScene
@export var pipe_spawn_speed: float
@export var difficulty: int = 5

@onready var game_over = $CanvasLayer/GameOver
@onready var spawn_upper = $"Spawn Upper"
@onready var spawn_lower = $"Spawn Lower"
@onready var spawn_timer = $"Spawn Timer"


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.start(pipe_spawn_speed)
	spawn_pipe()
	SignalManager.on_player_death.connect(_on_player_death)
	ScoreManager.set_score(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func spawn_pipe():
	var new_pipe = pipes_scene.instantiate()
	var y_pos = randf_range(
		spawn_upper.position.y, 
		spawn_lower.position.y
	)
	new_pipe.position = Vector2(spawn_lower.position.x, y_pos)
	add_child(new_pipe)


func _on_timer_timeout():
	spawn_timer.start(pipe_spawn_speed - ScoreManager.get_score() * (difficulty / 100.0))
	spawn_pipe()


func _on_player_death():
	stop_pipes()


func stop_pipes():
	spawn_timer.stop()
