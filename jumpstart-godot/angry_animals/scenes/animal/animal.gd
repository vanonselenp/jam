extends RigidBody2D


enum ANIMAL_STATE { READY, DRAG, RELEASE }

const DRAG_LIMIT_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIMIT_MIN: Vector2 = Vector2(-60, 0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0

var _state: ANIMAL_STATE = ANIMAL_STATE.READY
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _previous_dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0
var _last_collision_count: int = 0

@onready var label = $Label
@onready var arrow = $Arrow
@onready var strech_sound = $StrechSound
@onready var launch_sound = $LaunchSound
@onready var kick_sound = $KickSound

# Called when the node enters the scene tree for the first time.
func _ready():
	_start = position
	arrow.hide()
	_arrow_scale_x = arrow.scale.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	update(delta)
	label.text = ANIMAL_STATE.keys()[_state]
	label.text += "\n%.1f,%.1f" % [_dragged_vector.x, _dragged_vector.y]


func _on_visible_on_screen_notifier_2d_screen_exited():
	die()


func _on_input_event(_viewport, event: InputEvent, _shape_idx):
	if _state == ANIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANIMAL_STATE.DRAG)


func update(_delta: float) -> void:
	match _state:
		ANIMAL_STATE.DRAG:
			update_drag()
		ANIMAL_STATE.RELEASE:
			update_flight()


func die() -> void:
	SignalManager.on_bird_die.emit()
	queue_free()


func set_drag() -> void:
	_drag_start = get_global_mouse_position()
	arrow.show()


func set_release() -> void:
	freeze = false
	apply_central_impulse(get_impulse())
	launch_sound.play()
	arrow.hide()	
	SignalManager.on_attempt_made.emit()


func set_new_state(new_state: ANIMAL_STATE) -> void:
	_state = new_state

	if _state == ANIMAL_STATE.RELEASE:
		set_release()
	elif _state == ANIMAL_STATE.DRAG:
		set_drag()


func play_steched_sound() -> void:
	if (_previous_dragged_vector - _dragged_vector).length() > 0 and strech_sound.playing == false:
		strech_sound.play()


func get_dragged_vector(gmp: Vector2) -> Vector2:
	return gmp - _drag_start


func get_impulse() -> Vector2:
	return _dragged_vector * -1 * IMPULSE_MULT


func scale_arrow() -> void:
	var impulse_length = get_impulse().length()
	var percentage = impulse_length / IMPULSE_MAX
	var arrow_length = (_arrow_scale_x * percentage) + _arrow_scale_x
	arrow.scale.x = arrow_length

	arrow.rotation = (_start - position).angle()


func drag_in_limits(gmp: Vector2) -> void:
	_previous_dragged_vector = _dragged_vector
	_dragged_vector = get_dragged_vector(gmp)
	
	_dragged_vector.x = clampf(
		_dragged_vector.x,
		DRAG_LIMIT_MIN.x,
		DRAG_LIMIT_MAX.x
	)
	_dragged_vector.y = clampf(
		_dragged_vector.y,
		DRAG_LIMIT_MIN.y,
		DRAG_LIMIT_MAX.y
	)
	position = _start + _dragged_vector


func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag") == true:
			set_new_state(ANIMAL_STATE.RELEASE)
			return true

	return false


func update_drag() -> void:
	if detect_release():
		return

	var gmp = get_global_mouse_position()
	play_steched_sound()
	drag_in_limits(gmp)
	scale_arrow()


func play_collision() -> void:
	if (_last_collision_count == 0
		and get_contact_count() > 0
		and kick_sound.playing == false):
		kick_sound.play()

	_last_collision_count = get_contact_count()


func update_flight() -> void:
	play_collision()


func _on_sleeping_state_changed():
	if sleeping:
		var cups: Array[Node2D] = get_colliding_bodies()
		for cup in cups:
			cup.remove_cup()

		call_deferred("die")
