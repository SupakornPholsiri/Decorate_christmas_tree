extends Area2D

class_name LadderBottom

var test: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	test = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	body
