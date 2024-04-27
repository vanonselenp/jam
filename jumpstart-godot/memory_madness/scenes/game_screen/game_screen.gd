extends Control


@export var mem_tile_scene: PackedScene

@onready var sound = $Sound
@onready var tile_container = $HBoxContainer/MarginGrid/TileContainer
@onready var scorer: Scorer = $Scorer
@onready var moves_label = $HBoxContainer/MarginLabels/VBoxContainer/HB/MovesLabel
@onready var pairs_label = $HBoxContainer/MarginLabels/VBoxContainer/HB2/PairsLabel
@onready var h_box_container = $HBoxContainer
@onready var game_over = $GameOver


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_level_selected.connect(on_level_selected)
	SignalManager.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	moves_label.text = scorer.get_moves_made()
	pairs_label.text = scorer.get_pairs_made()


func _on_exit_button_pressed():
	SoundManager.play_button_click(sound)
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
	
	scorer.clear_new_game(level_selection.target_pairs)
	h_box_container.show()
	game_over.hide()


func on_game_over(_moves: int) -> void:
	h_box_container.hide()

