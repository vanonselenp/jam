extends Control


@export var mem_tile_scene: PackedScene

@onready var sound = $Sound
@onready var tile_container = $HBoxContainer/MarginGrid/TileContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)

	for child in tile_container.get_children():
		child.queue_free()

	SignalManager.on_game_exited_pressed.emit()


func add_memory_tile(item: Dictionary, frame_image: CompressedTexture2D) -> void:
	var tile = mem_tile_scene.instantiate()
	tile_container.add_child(tile)
	tile.setup(item, frame_image)


func on_level_selected(level_selected: int) -> void:
	var level_selection = GameManager.get_level_selection(level_selected)
	var frame_image = ImageManager.get_random_frame()
	
	tile_container.columns = level_selection.level.cols
	
	for item in level_selection.images:
		add_memory_tile(item, frame_image)

