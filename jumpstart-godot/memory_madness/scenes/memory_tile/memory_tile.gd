extends TextureButton


class_name MemoryTile


@onready var frame_image = $FrameImage
@onready var item_image = $ItemImage


var item_name: String
var can_select: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.on_selection_disabled.connect(on_selection_disabled)
	SignalManager.on_selection_enabled.connect(on_selection_enabled)
	pass # Replace with function body.


func get_item_name() -> String:
	return item_name


func setup(item: Dictionary, frame_image_texture: CompressedTexture2D) -> void:
	frame_image.texture = frame_image_texture
	item_image.texture = item.texture
	item_name = item.name
	reveal(false)


func kill_on_success() -> void:
	z_index = 1
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "disabled", true, 0)
	tween.tween_property(self, "rotation", deg_to_rad(720), 0.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 0.5)
	tween.set_parallel(false)
	tween.tween_interval(0.6)
	tween.tween_property(self, "scale", Vector2(0.0, 0.0), 0.1)


func reveal(r: bool) -> void:
	frame_image.visible = r
	item_image.visible = r


func _on_pressed():
	if can_select:
		SignalManager.on_tile_selected.emit(self)


func on_selection_disabled() -> void:
	can_select = false


func on_selection_enabled() -> void:
	can_select = true
