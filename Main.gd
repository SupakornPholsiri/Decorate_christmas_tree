extends Node

@onready var timer = $Timer
@onready var world = $World
@onready var ingame_nodes = $World/InGameNodes
@onready var audino = $AudioStreamPlayer2D
@onready var ui_timer = $UI/Time

func _ready():
	start_game()
	audino.play()

func _process(delta):
	ui_timer.text = "%d" % timer.time_left

func start_game():
	timer.start(30)
	
func end_game():
	ingame_nodes.visible = false
	world.set_process(false)
	world.set_physics_process(false)
	
func _on_timer_timeout():
	end_game()
