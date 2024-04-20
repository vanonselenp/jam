extends CharacterBody2D


@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer


const GRAVITY: float = 1500.0
const POWER: float = -500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	fly(delta)
	
	move_and_slide()
	
	if is_on_floor():
		animated_sprite_2d.stop()


func fly(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if Input.is_action_just_pressed("fly"):
		velocity.y = POWER
		animation_player.play("power")
		
		
func death(delta: float) -> void:
	set_physics_process(false)
	animated_sprite_2d.stop()
	
