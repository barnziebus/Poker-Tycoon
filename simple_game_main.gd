extends Node2D

@onready var chairs = [$"y-sort/test-chair", $"y-sort/test-chair2"]

var next_open_seat = null
var open_seat: bool = false

func _ready():
	pass


func _process(delta):
	pass


func _on_npc_state_machine_look_for_empty_seat(npc):
	chairs = $"y-sort".get_children()
	if chairs:
		for seat in chairs:
			if seat.open:
				npc.seat = seat
	else:
		npc.seat = null
