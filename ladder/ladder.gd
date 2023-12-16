extends Area2D

class_name Ladder

var is_ladder_ready: bool
@export_enum("bottom", "top") var ladder_type: String

# Called when the node enters the scene tree for the first time.
func _ready():
	is_ladder_ready = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_check_player_area_body_entered(body):
	is_ladder_ready = false
	print(body.name, "enter", ladder_type)


func _on_check_player_area_body_exited(body):
	is_ladder_ready = true
	print(body.name, "exit", ladder_type)
