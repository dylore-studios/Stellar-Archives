extends Node

@export var layer1 : Sprite2D
@export var layer2 : Sprite2D
@export var layer3 : Sprite2D

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
			layer1.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_red_1.png")
			layer2.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_red_2.png")
			layer3.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_red_3.png")
		StarColor.ORANGE:
			layer1.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_orange_1.png")
			layer2.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_orange_2.png")
			layer3.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_orange_3.png")
		StarColor.YELLOW:
			layer1.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_yellow_1.png")
			layer2.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_yellow_2.png")
			layer3.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_yellow_3.png")
		StarColor.WHITE:
			layer1.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_white_1.png")
			layer2.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_white_2.png")
			layer3.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_white_3.png")
		StarColor.BLUE:
			layer1.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_blue_1.png")
			layer2.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_blue_2.png")
			layer3.texture = preload("res://assets/Stars/Enchanted Stars/enchanted_blue_3.png")
