extends Area2D

class_name DecorationBox

var decor_files : Array[String]
var decors : Array[Decoration]

var is_player_on_top : bool
@onready var texture : Texture2D = $Sprite2D.texture
@onready var texture_highlight : Texture2D = preload("res://decorations/DecorationBox_highlight.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	decor_files = get_all_decor_file("res://decorations/resources/")
	for file in decor_files:
		decors.append(load(file))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func give_decor(player : CharacterBody2D):
	if player.decor == null:
		player.decor = decors[randi_range(0, len(decors)-1)]
		
func get_all_decor_file(path : String):
	var file_paths : Array[String] = []
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var file_path = path + "/" + file_name
		file_paths.append(file_path)
		file_name = dir.get_next()
	return file_paths
	
func highlight_area(area: Area2D):
	if self == area:
		$Sprite2D.texture = texture_highlight
	else:
		$Sprite2D.texture = texture


func _on_body_exited(body):
	$Sprite2D.texture = texture
