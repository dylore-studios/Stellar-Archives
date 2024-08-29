extends StaticBody3D
class_name Telescope

@onready var object_component = $ObjectComponent
@onready var building_component = $BuildingComponent
@onready var fadeiftoonear_component = $FadeIfTooNearComponent

var placed := false
