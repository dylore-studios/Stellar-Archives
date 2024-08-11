extends Node

@export var layer1 : Sprite2D
@export var layer2 : Sprite2D

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
	match color:
		StarColor.RED:
			layer1.texture = preload("res://assets/Stars/Simple Stars/simple_red_1.png")
			layer2.texture = preload("res://assets/Stars/Simple Stars/simple_red_2.png")
		StarColor.ORANGE:
			layer1.texture = preload("res://assets/Stars/Simple Stars/simple_orange_1.png")
			layer2.texture = preload("res://assets/Stars/Simple Stars/simple_orange_2.png")
		StarColor.YELLOW:
			layer1.texture = preload("res://assets/Stars/Simple Stars/simple_yellow_1.png")
			layer2.texture = preload("res://assets/Stars/Simple Stars/simple_yellow_2.png")
		StarColor.WHITE:
			layer1.texture = preload("res://assets/Stars/Simple Stars/simple_white_1.png")
			layer2.texture = preload("res://assets/Stars/Simple Stars/simple_white_2.png")
		StarColor.BLUE:
			layer1.texture = preload("res://assets/Stars/Simple Stars/simple_blue_1.png")
			layer2.texture = preload("res://assets/Stars/Simple Stars/simple_blue_2.png")
