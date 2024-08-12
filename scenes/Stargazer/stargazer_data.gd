extends Node2D

@export var space_size := Vector2(2000, 2000)
@export var world = "res://world.tscn"

func _input(event):
	if Input.is_action_just_pressed("sprint"):
		pass
