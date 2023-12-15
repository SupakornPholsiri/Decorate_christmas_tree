extends Area2D

class_name DecorationSpot

var decor : Decoration = null
@onready var no_decor_texture : Texture2D = $Sprite2D.texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Call this function from the object that can put up decorations.
# Also return whether the decoration was put or not
func set_decor(new_decor : Decoration):
	if decor == null and new_decor != null:
		decor = new_decor
		$Sprite2D.texture = decor.texture
		# Successfully put up the decoration.
		return true
	# Another decoration already up.
	return false
	
func remove_decor():
	decor = null
	$Sprite2D.texture = no_decor_texture
