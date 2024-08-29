extends Node3D
class_name StargazingArea

@export var increase_stars := true
@export var star_min_amount : int
@export var star_max_amount : int

@export var improve_stars := true
@export var star_name : String
@export var star_random_value : int
var telescope_entered : Telescope
