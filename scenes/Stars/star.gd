extends Area2D

var has_point = false

@export var generator : Node
@export var connector : Node2D

func _ready():
	generator.generate()

func set_start_position(x, y) -> void:
	position = Vector2(x, y)
