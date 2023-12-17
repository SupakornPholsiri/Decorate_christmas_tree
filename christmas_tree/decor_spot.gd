extends Area2D

class_name DecorationSpot

var decor : Decoration = null
var is_player_on_top : bool
var is_spot_empty : bool = true
@onready var no_decor_texture : Texture2D = $Sprite2D.texture
@onready var no_decor_texture_highlight : Texture2D = preload("res://empty_spot_highlight.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_spot_empty:
		$Sprite2D.texture = no_decor_texture_highlight if is_player_on_top else no_decor_texture
		is_player_on_top = false

# Call this function from the object that can put up decorations.
# Also return whether the decoration was put or not
func set_decor(new_decor : Decoration):
	if decor == null and new_decor != null:
		decor = new_decor
		$Sprite2D.texture = decor.texture
		is_spot_empty = false
		# Successfully put up the decoration.
		return true
	# Another decoration already up.
	return false
	
func remove_decor():
	decor = null
	$Sprite2D.texture = no_decor_texture
	is_spot_empty = true
	
func highlight_area():
	is_player_on_top = true
