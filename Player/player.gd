extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export_range(1, 2, 1) var which_player

var decor : Decoration = null

var player_move_left 
var player_move_right 
var player_move_up 
var player_move_down

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	# Temporary test code ----------------------------------------
	if which_player == 1:
		decor = preload("res://decorations/resources/candy_cane.tres")
	else:
		decor = preload("res://decorations/resources/mini_present.tres")
	# ------------------------------------------------------------
	player_move_left = "P%s_move_left" % which_player
	player_move_right = "P%s_move_right" % which_player
	player_move_up = "P%s_move_up" % which_player
	player_move_down = "P%s_move_down" % which_player
	
func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis(player_move_left, player_move_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	var target_area = nearest_overlapping_area()
	
	# Interaction code
	if target_area != null and Input.is_action_just_pressed("P%s_interact" % which_player):
		if target_area is DecorationSpot:
			if target_area.set_decor(decor):
				decor = null
		elif target_area is DecorationBox:
			target_area.give_decor(self)

# Get the nearest area that overlaps the InteractArea
func nearest_overlapping_area():

	var areas : Array[Area2D] = $InteractArea.get_overlapping_areas()
	var target_area : Area2D
	var area_distance = INF
	
	for area in areas:
		var new_area_distance = global_position.distance_to(area.global_position)
		if new_area_distance < area_distance:
			area_distance = new_area_distance
			target_area = area
			
	return target_area
