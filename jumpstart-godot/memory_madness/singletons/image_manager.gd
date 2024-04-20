extends Node


const IMAGE_PATH = "res://assets/glitch"
var items = []


# Called when the node enters the scene tree for the first time.
func _ready():
	load_item_images() # Replace with function body.


func add_file_to_list(filename: String):
	var path = "%s/%s" % [IMAGE_PATH, filename]
	var texture: CompressedTexture2D = load(path)
	
	items.append({
		"name": filename.rstrip(".png"),
		"texture": texture,
	})


func load_item_images() -> void:
	var directory = DirAccess.open(IMAGE_PATH)
	
	if not directory:
		print("ERROR: ", IMAGE_PATH)
		return
	
	var filenames = directory.get_files()
	
	for filename in filenames:
		if ".import" not in filename:
			add_file_to_list(filename)


func get_random_image() -> Dictionary:
	return items.pick_random()
	
