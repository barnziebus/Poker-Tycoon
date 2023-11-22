extends Node2D

var next_open_seat = null
var open_seat: bool = false

var respawn = 0.5
var npc_scene = preload("res://npc_state_machine.tscn")
var npcs = []

func _ready():
	pass


func _process(delta):
	respawn -= delta
	#print(respawn)
	if respawn < 0:
		respawn = randi_range(5,20)
		var instance = npc_scene.instantiate()
		instance.add_to_group('npcs')
		npcs.append(instance)
		add_child(instance)
	
	sendOpenChairs()


func _on_npc_state_machine_look_for_empty_seat(npc):
	var chairs = $"y-sort".get_children()
	for seat in chairs:
		if seat.open:
			npc.seat = seat
		else:
			npc.seat = null


func sendOpenChairs():
	var next_open_seat = get_open_seat()
	var next_npc = next_waiting_npc()
	if next_npc:
		next_npc.seat = next_open_seat


func next_waiting_npc():
	var npcs = get_tree().get_nodes_in_group("npcs")
	for npc in npcs:
		if npc.seat == null:
			return npc


func get_open_seat():
	var chairs = get_tree().get_nodes_in_group("chairs")
	
	for seat in chairs:
		if seat.open:
			return seat
