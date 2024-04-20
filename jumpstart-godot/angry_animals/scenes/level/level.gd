extends Node2D


@onready var animal_start = $AnimalStart


const ANIMAL = preload("res://scenes/animal/animal.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_bird_die.connect(create_animal)
	create_animal()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func create_animal():
	var animal = ANIMAL.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	animal.position = animal_start.position
	add_child(animal)
