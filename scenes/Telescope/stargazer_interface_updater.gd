extends InterfaceUpdater
class_name StargazerInterfaceUpdater

@export var lookbox : Area3D

var stargazing_area : StargazingArea

func _ready():
	lookbox.area_entered.connect(_on_stargazer_area_entered)
	lookbox.area_exited.connect(_on_stargazer_area_exited)

func update_information(stargazer : Stargazer):
	increase_star_amount(stargazer)
	improve_star_rarity(stargazer)

func increase_star_amount(stargazer : Stargazer):
	if stargazing_area:
		if stargazing_area.increase_stars:
			stargazer.space_generator.minimum_num = stargazing_area.star_min_amount
			stargazer.space_generator.maximum_num = stargazing_area.star_max_amount

func improve_star_rarity(stargazer : Stargazer):
	if stargazing_area:
		if stargazing_area.improve_stars:
			stargazer.space_generator.star_rarity[stargazing_area.star_name] = stargazing_area.star_random_value

func _on_stargazer_area_entered(area):
	if area is StargazingArea:
		stargazing_area = area

func _on_stargazer_area_exited(area):
	if area is StargazingArea:
		stargazing_area = null
