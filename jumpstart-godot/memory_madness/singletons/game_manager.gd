extends Node


const TILE_GROUP = "tile"
const LEVELS: Dictionary = {
	1: { "rows": 2, "cols": 2 },
	2: { "rows": 3, "cols": 4 },
	3: { "rows": 4, "cols": 4 },
	4: { "rows": 4, "cols": 6 },
	5: { "rows": 5, "cols": 6 },
	6: { "rows": 6, "cols": 6 },
}


func get_level_selection(level_number: int) -> Dictionary:
	var level = GameManager.LEVELS[level_number]
	var total_tiles = level.rows * level.cols
	var target_pairs: int = total_tiles / 2
	var selected_images = []
	
	ImageManager.shuffle_images()
	
	for image in range(target_pairs):
		selected_images.append(ImageManager.get_image(image))
		selected_images.append(ImageManager.get_image(image))
	
	selected_images.shuffle()
	
	return {
		"target_pairs": target_pairs,
		"level": level,
		"images": selected_images
	}


func clear_nodes_of_group(group_name: String) -> void:
	for node in get_tree().get_nodes_in_group(group_name):
		node.queue_free()
