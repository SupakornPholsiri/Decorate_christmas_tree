extends Area2D

class_name DecorationItem

@export var decor : Decoration : set = set_decor

var player

# Set the decor value and change sprite according to the decor
func set_decor(new_decor : Decoration):
	decor = new_decor
	$Sprite2D.texture = decor.texture
