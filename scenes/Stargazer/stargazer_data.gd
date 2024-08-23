extends Node2D

@export var space_size := Vector2(2000, 2000)

func _on_tree_entered() -> void:
	$BlackScreenCanvas.fade_outof_black()
