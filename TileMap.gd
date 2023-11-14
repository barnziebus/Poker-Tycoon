extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event.is_action_pressed('left-click'):
		var mouse_coord_pos = local_to_map(get_global_mouse_position())
		var tile_atlas_coord = get_cell_atlas_coords(0, mouse_coord_pos)
		
		#if tile_atlas_coord == Vector2i(0,0): 
		#	set_cell(0, mouse_coord_pos, 0, Vector2(1,1))
		#else:
		#	set_cell(0, mouse_coord_pos, 0, Vector2(0,0))
