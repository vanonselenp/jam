extends StaticBody2D


@onready var animation_player = $AnimationPlayer


func remove_cup() -> void:
	animation_player.play("vanish")


func _on_animation_player_animation_finished(_anim_name):
	SignalManager.on_cup_removed.emit()
	queue_free()
