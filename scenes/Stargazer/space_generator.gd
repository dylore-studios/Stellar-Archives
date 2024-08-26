extends Node

@export var stargazer : Node2D
@export var path_name : String
@export var star_parallax : Node2D
var minimum_num := 0
var maximum_num := 10

var array_of_stars : Array

var rng = RandomNumberGenerator.new()

var star_rarity := {
	"Simple Star" : 1000,
	"Great Star" : 400,
	"Enchanted Star" : 50,
	"Ancient Star" : 10,
	"Farther Star" : 5
}

signal done_generating

func _ready():
	var file_appender = FileAppender.new()
	file_appender.append_scenes_to_array(path_name, array_of_stars)
	generate_space()
	pass

func generate_space():
	var num_of_stars := randi_range(minimum_num, maximum_num)
	for i in num_of_stars:
		var star_instance = create_random_star()
		
		var x_pos := randf_range(-stargazer.space_size.x/3, stargazer.space_size.x/3)
		var y_pos := randf_range(-stargazer.space_size.y/3, stargazer.space_size.y/3)
		
		star_instance.set_start_position(x_pos, y_pos)
		
		star_parallax.add_child(star_instance)
	done_generating.emit()

func create_random_star():
	rng.randomize()
	var weighted_sum := 0
	
	for n in star_rarity:
		weighted_sum += star_rarity[n]
	
	var item := rng.randi_range(0, weighted_sum)
	var star_name : String
	
	for n in star_rarity:
		if item <= star_rarity[n]:
			star_name = n
			break
		item -= star_rarity[n]
	
	for star in array_of_stars:
		var star_instance = star.instantiate()
		if star_instance.name == star_name:
			return star_instance
