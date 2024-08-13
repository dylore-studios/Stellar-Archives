extends Node

@export var layers : Node2D
@export var type : String

enum StarColor {
	RED,
	ORANGE,
	YELLOW,
	WHITE,
	BLUE
}

func generate():
	var rand_color = randi_range(0, StarColor.size() - 1)
	set_color(rand_color)

# Changes the sprite depending on what color was set
func set_color(color : int):
	var color_name : String
	match color:
		StarColor.RED:
			color_name = "red"
		StarColor.ORANGE:
			color_name = "orange"
		StarColor.YELLOW:
			color_name = "yellow"
		StarColor.WHITE:
			color_name = "white"
		StarColor.BLUE:
			color_name = "blue"
	var counter = layers.get_children().size()
	for layer in layers.get_children():
		var star_path : String = "res://assets/Stars/" + type.to_pascal_case() + " Stars/" + type.to_lower() + "_" + color_name + "_" + str(counter) + ".png"
		print(star_path)
		counter -= 1
		layer.texture = load(star_path)
