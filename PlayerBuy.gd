extends State
class_name PlayerBuy

@export var map: TileMap
@export var chair_node_container: Node2D

@onready var chair_scene = preload("res://test_chair.tscn")
@onready var table_scene = preload("res://test_table.tscn")

@onready var object = {
	'chair': chair_scene,
	'table': table_scene,
}

func Enter():
	print('player buy entered')


func Exit():
	pass


func Update(delta: float):
	var tile_coords = map.local_to_map(map.get_global_mouse_position())
	map.set_cell(1, tile_coords, 0, Vector2i(0,0))
	


func Physics_Update(delta:float):
	map.clear_layer(1)


func Handle_Input(event):
	if event.is_action_pressed("left-click"):
		place_object(object['table'])


func place_object(object): #change to place object func then pass the preload to place?
	#get the tile for the chair then convert to local coords to get consistent chair pos
	var target_tile_coords = map.local_to_map(map.get_global_mouse_position()) 
	var object_position = map.map_to_local(target_tile_coords)
	
	var instance = object.instantiate()
	instance.position = object_position
	chair_node_container.add_child(instance)
