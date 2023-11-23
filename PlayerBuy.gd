extends State
class_name PlayerBuy

@export var map: TileMap

func Enter():
	print('player buy entered')


func Exit():
	pass


func Update(delta: float):
	var mouse_position = map.get_global_mouse_position()
	var tile_coords = map.local_to_map(mouse_position)
	map.set_cell(1, tile_coords, 0, Vector2i(0,0))
	


func Physics_Update(delta:float):
	map.clear_layer(1)


func Handle_Input(event):
	if event.is_action_pressed("left-click"):
		pass
