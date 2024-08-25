extends Node

@export var stargazer : Node2D
@export var path_name : String
@export var star_parallax : Node2D
var minimum_num := 0
var maximum_num := 10

var array_of_stars : Array

signal done_generating

func _ready():
	append_files_to_array()
	generate_space()
	pass

func append_files_to_array():
	var dir = DirAccess.open(path_name)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		else:
			array_of_stars.append(load(path_name + file_name))
	dir.list_dir_end()

func generate_space():
	var num_of_stars = randi_range(minimum_num, maximum_num)
	for i in num_of_stars:
		var star_index = randi_range(0, array_of_stars.size() - 1)
		var star_instance = array_of_stars[star_index].instantiate()
		
		var x_pos = randf_range(-stargazer.space_size.x/3, stargazer.space_size.x/3)
		var y_pos = randf_range(-stargazer.space_size.y/3, stargazer.space_size.y/3)
		
		star_instance.set_start_position(x_pos, y_pos)
		
		star_parallax.add_child(star_instance)
	done_generating.emit()
