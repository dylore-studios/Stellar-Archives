extends Sprite3D

@onready var body_bob_animation = $BodyBobAnimation
@onready var player = $"../.."

var flipped_right = true

# Flips the body depending on input
func flip_body():
	if Input.is_action_just_pressed("move_left") and flipped_right:
		flip_h = true
		flipped_right = false
	elif Input.is_action_just_pressed("move_right") and not flipped_right:
		flip_h = false
		flipped_right = true

# Plays bob animation based on player movement
func bob_body():
	if player.is_sprinting and player.is_moving:
		body_bob_animation.play("sprint_bob")
	elif player.is_moving:
		body_bob_animation.play("walk_bob")
	else:
		body_bob_animation.play("idle_bob")

func _process(delta):
	flip_body()
	bob_body()
