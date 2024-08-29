extends Node2D
class_name Stargazer

@export var space_size := Vector2(2000, 2000)
@export var space_generator : SpaceGenerator

func _on_tree_entered() -> void:
	$BlackScreenCanvas.fade_outof_black()

func _on_tree_exited() -> void:
	$BlackScreenCanvas.reset()
