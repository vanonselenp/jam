extends Node2D


@onready var animal_start = $AnimalStart


const ANIMAL = preload("res://scenes/animal/animal.tscn")
const MAIN = preload("res://scenes/main/main.tscn")


func _ready():
	SignalManager.on_bird_die.connect(create_animal)
	create_animal()


func _process(_delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene_to_packed(MAIN)


func create_animal():
	var animal = ANIMAL.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	animal.position = animal_start.position
	add_child(animal)
