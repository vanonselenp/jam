extends CharacterBody2D


class_name Player


@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer


const GRAVITY: float = 1000.0
const RUN_SPEED: float = 120.0
const MAX_FALL: float = 400.0
const HURT_TIME: float = 0.3
const JUMP_VELOCITY: float = -400.0


enum PLAYER_STATE {
	Idle, Jump, Run, Hurt, Fall
}

var current_state = PLAYER_STATE.Idle


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	get_input()
	move_and_slide()
	calculate_state()


func get_input() -> void:
	velocity.x = 0
	
	if Input.is_action_pressed("left"):
		velocity.x = -RUN_SPEED
		sprite_2d.flip_h = true

	if Input.is_action_pressed("right"):
		velocity.x = RUN_SPEED
		sprite_2d.flip_h = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y = clampf(velocity.y, JUMP_VELOCITY, MAX_FALL)


func calculate_state() -> void:
	if current_state == PLAYER_STATE.Hurt:
		return

	if is_on_floor():
		if velocity.x == 0:
			set_player_state(PLAYER_STATE.Idle)
		else: 
			set_player_state(PLAYER_STATE.Run)
	
	else:
		if velocity.y < 0:
			set_player_state(PLAYER_STATE.Jump)
		else:
			set_player_state(PLAYER_STATE.Fall)


func set_player_state(new_state: PLAYER_STATE) -> void:
	if new_state == current_state:
		return

	current_state = new_state

	match current_state:
		PLAYER_STATE.Idle:
			animation_player.play("idle")

		PLAYER_STATE.Run:
			animation_player.play("run")

		PLAYER_STATE.Jump:
			animation_player.play("jump")

		PLAYER_STATE.Fall:
			animation_player.play("fall")

