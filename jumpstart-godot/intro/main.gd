extends Node2D

class_name Main

const danger = 5

@onready var icon_2 = $Icon2
@onready var icon_3 = $Icon/Icon3

@export var start_lives = 20
var _lives


var _health: int:
	get = get_health, set = set_health


func get_health() -> int:
	print("getting")
	return _health


func set_health(value) -> void:
	print("setting")
	_health = value


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello") # Replace with function body.
	var score: int = 25
	var a = Animal.new()
	_lives = start_lives
	print(_lives)
	print(icon_3.position)
	print(icon_3.global_position)
	_health = 8
	print(_health)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	reduce_lives()
	
	icon_2.position.x += 1

func reduce_lives():
	if Input.is_action_just_pressed("ui_accept"):
		_lives -= 1
		if _lives <= 0:
			print("Dead")
		elif _lives <= danger:
			print("Danger: %s" % _lives)
		else:
			print("Lives: %s" % _lives)
