extends Node

@onready var timer = $Timer
@onready var world = $World
@onready var ingame_nodes = $World/InGameNodes
@onready var audio = $AudioStreamPlayer2D
@onready var ui_timer = $UI/Time
@onready var back = $UI/Back
@onready var p1_inventory = $UI/P1Inventory
@onready var p2_inventory = $UI/P2Inventory
@onready var p1 = $World/InGameNodes/P1
@onready var p2 = $World/InGameNodes/P2

func _ready():
	p1.connect("decor_changed", update_inventory)
	p2.connect("decor_changed", update_inventory)
	start_game()
	audio.play()

func _process(delta):
	ui_timer.text = "%d" % timer.time_left

func start_game():
	timer.start(30)
	
func end_game():
	ingame_nodes.visible = false
	world.set_process(false)
	world.set_physics_process(false)
	back.visible = true
	
func update_inventory(decor : Decoration, which_player : int):
	match which_player:
		1: 
			if decor != null : 
				p1_inventory.texture = decor.texture
			else :
				p1_inventory.texture = null
		2: 
			if decor != null : 
				p2_inventory.texture = decor.texture
			else :
				p2_inventory.texture = null
	
func _on_timer_timeout():
	end_game()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
