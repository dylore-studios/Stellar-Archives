extends Area2D

var has_point = false

@export var generator : Node

func _ready():
	generator.generate()
