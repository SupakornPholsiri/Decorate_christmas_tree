extends Node2D

# For testing
@onready var decor1 = preload("res://decorations/resources/candy_cane.tres")
@onready var decor2 = preload("res://decorations/resources/mini_present.tres")
func decorations_tests():
	 # Put up decorations on all empty spots
	for decor_spot in $Decorations.get_children():
		decor_spot.set_decor(decor1)
	await get_tree().create_timer(1).timeout
	 # Try to put up decorations on all spots
	for decor_spot in $Decorations.get_children():
		decor_spot.set_decor(decor2)
	await get_tree().create_timer(1).timeout
	 # Remove decorations from the tree
	remove_decorations()
	await get_tree().create_timer(1).timeout
	 # Put up decorations on all empty spots
	for decor_spot in $Decorations.get_children():
		decor_spot.set_decor(decor2)
	await get_tree().create_timer(2).timeout
	 # Remove decorations from the tree
	remove_decorations()

# Called when the node enters the scene tree for the first time.
func _ready():
	decorations_tests()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Remove all decorations from the tree.
func remove_decorations():
	for decor_spot in $Decorations.get_children():
		decor_spot.remove_decor()
