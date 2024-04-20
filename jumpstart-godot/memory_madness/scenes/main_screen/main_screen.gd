extends Control


@onready var hb_sprites = $VBoxContainer/HBSprites


# Called when the node enters the scene tree for the first time.
func _ready():
	var random_items = [randf_range(0, 49),randf_range(0, 49),randf_range(0, 49),randf_range(0, 49)]
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
