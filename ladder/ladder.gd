extends Area2D

class_name Ladder

var ladder_height: float
var is_ladder_ready: bool
@export_enum("bottom", "top") var ladder_type: String

@onready var sprite2D = get_node("../Sprite2D")
@onready var texture : Texture2D = sprite2D.texture
@onready var texture_highlight : Texture2D = preload("res://ladder/Ladder_highlight.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	is_ladder_ready = true
	ladder_height = sprite2D.region_rect.size.y - 20
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_check_player_area_body_entered(body):
	is_ladder_ready = false

func _on_check_player_area_body_exited(body):
	is_ladder_ready = true

func highlight_area(area: Area2D):
	if not is_ladder_ready:
		return
	if self == area:
		sprite2D.texture = texture_highlight
	else:
		sprite2D.texture = texture

func _on_body_exited(body):
	sprite2D.texture = texture
