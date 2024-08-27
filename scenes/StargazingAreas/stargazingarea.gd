extends Node3D
class_name StargazingArea

@export var star_name : String
@export var random_value : int
var telescope_entered : Telescope

func update_telescope_info():
	print("yo!!")
	telescope_entered.object_component.generate_interface([star_name, random_value])

func _on_area_entered(area: Area3D) -> void:
	if area.get_parent() is Telescope:
		print("zamn")
		telescope_entered = area.get_parent()
		area.get_parent().building_component.building_placed.connect(update_telescope_info)

func _on_area_exited(area: Area3D) -> void:
	if area.get_parent() is Telescope:
		print("woah")
		area.get_parent().building_component.building_placed.disconnect(update_telescope_info)
		telescope_entered = null
