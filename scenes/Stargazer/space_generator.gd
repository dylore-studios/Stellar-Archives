extends Node

@export var stargazer : Node2D
@export var path_name : String
@export var star_parallax : Node2D
var minimum_num := 0
var maximum_num := 10

var array_of_stars : Array

signal done_generating

func _ready():
	var file_appender = FileAppender.new()
	file_appender.append_scenes_to_array(path_name, array_of_stars)
	generate_space()
	pass

func generate_space():
	var num_of_stars = randi_range(minimum_num, maximum_num)
	for i in num_of_stars:
		var star_instance = array_of_stars.pick_random().instantiate()
		
		var x_pos = randf_range(-stargazer.space_size.x/3, stargazer.space_size.x/3)
		var y_pos = randf_range(-stargazer.space_size.y/3, stargazer.space_size.y/3)
		
		star_instance.set_start_position(x_pos, y_pos)
		
		star_parallax.add_child(star_instance)
	done_generating.emit()
