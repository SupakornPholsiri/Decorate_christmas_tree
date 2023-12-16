extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export_range(1, 2, 1) var which_player

var decor : Decoration = null
var decor_item = preload("res://decorations/decoration_item.tscn")

var player_move_left 
var player_move_right 
var player_move_up 
var player_move_down
var player_interact
var player_throw_up
var player_throw_down

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	player_move_left = "P%s_move_left" % which_player
	player_move_right = "P%s_move_right" % which_player
	player_move_up = "P%s_move_up" % which_player
	player_move_down = "P%s_move_down" % which_player
	player_interact = "P%s_interact" % which_player
	player_throw_up = "P%s_throw_up" % which_player
	player_throw_down = "P%s_throw_down" % which_player
	
func _physics_process(delta):
	
	#region movement
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
	#endregion

	var areas : Array[Area2D]	
	#region Check for DecorationItem and collect if there is

	for area in $InteractArea.get_overlapping_areas():
		if not area is DecorationItem:
			areas.append(area)
		else:
			if collect_decor(area.decor):
				area.queue_free()
	#endregion
	
	#region Interaction code
	var target_area = get_nearest_node(areas)
	
	if target_area != null and Input.is_action_just_pressed(player_interact):
		if target_area is DecorationSpot:
			if target_area.set_decor(decor):
				decor = null
		elif target_area is DecorationBox:
			target_area.give_decor(self)
	#endregion
			
	#region Ladder code
	if target_area is Ladder and target_area.is_ladder_ready:
		if target_area.ladder_type == "bottom" and Input.is_action_just_pressed(player_move_up):
			global_position.y -= target_area.ladder_height
		elif target_area.ladder_type == "top" and Input.is_action_just_pressed(player_move_down):
			global_position.y += target_area.ladder_height
		else:
			# TODO: Tell player that the ladder not ready
			pass
	#endregion
	
	#region Code of throwing decoration
	if Input.is_action_just_pressed(player_throw_up):
		throw_decor(global_position + Vector2.UP * 100)
		
	if Input.is_action_just_pressed(player_throw_down):
		throw_decor(global_position + Vector2.DOWN * 100)
	#endregion

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
	
# Get the nearest node from the Array
func get_nearest_node(nodes : Array):

	var target: Area2D
	var distance = INF
	
	for node in nodes:
		var new_distance = global_position.distance_to(node.global_position)
		if new_distance < distance:
			distance = new_distance
			target = node
			
	return target

# Attempt to collect the decor and return whether collected successfully or not 
func collect_decor(new_decor : Decoration):
	if decor == null:
		decor = new_decor
		return true
	return false

# Spawn a DecorationItem at the position
func throw_decor(pos : Vector2):
	if decor != null:
		var decor_item_instance = decor_item.instantiate()
		decor_item_instance.decor = decor
		decor_item_instance.global_position = pos
		get_tree().get_current_scene().add_child(decor_item_instance)
		decor = null
