extends Node2D


@export var speed = 120

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= delta * speed
	

func _on_pipes_screen_exited():
	queue_free()


func _on_laser_body_exited(body):
	if body.is_in_group("player") == true:
		print("point scored")


func _on_pipe_body_entered(body):
	if body.is_in_group("player"):
		print("pipe entered: ", body)
		body.death()
