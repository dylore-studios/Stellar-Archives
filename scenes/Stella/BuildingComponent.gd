extends Node

var telescope_instance = preload("res://scenes/Telescope/telescope.tscn")

var is_handling = true

func _input(event):
	if Input.is_action_just_pressed("jump") and not is_handling:
		get_parent().get_parent().add_child(telescope_instance.instantiate())
		is_handling = true
	if Input.is_action_just_pressed("interact") and is_handling:
		is_handling = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
