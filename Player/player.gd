extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export_range(1, 2, 1) var which_player

var player_move_left 
var player_move_right 
var player_move_up 
var player_move_down

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player_move_left = "P%s_move_left" % which_player
	player_move_right = "P%s_move_right" % which_player
	player_move_up = "P%s_move_up" % which_player
	player_move_down = "P%s_move_down" % which_player
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed(player_move_up) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(player_move_left, player_move_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
