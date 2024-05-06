extends CharacterBody2D


class_name Player


@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer


const GRAVITY: float = 1000.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	get_input()

	move_and_slide()


func get_input():
	velocity.x = 0
	
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED

	if Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)
