extends TextureButton


@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage


var item_name: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_item_name() -> String:
	return item_image


func setup(item: Dictionary, frame_image_texture: CompressedTexture2D) -> void:
	frame_image.texture = frame_image_texture
	item_image.texture = item.texture
	item_name = item.name
