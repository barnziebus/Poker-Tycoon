extends State
class_name NPCMoveToSeat

var move_direction : Vector2
var target_position: Vector2

@export var _NPC: CharacterBody2D
@export var navigation: NavigationAgent2D
@export var move_speed := 30.0
@export var sprite: AnimatedSprite2D


func Enter():
	target_position = _NPC.seat.global_position
	navigation.target_position = target_position
	
	_NPC.seat.open = false


func Exit():
	pass


func Update(delta: float):
	pass


func Physics_Update(delta: float):
	if target_position:
		move()
		
		if navigation.is_navigation_finished():
			Transitioned.emit(self, "NPCPlaying")
			print('npc is now playing')
	
	else:
		Transitioned.emit(self, "NPCIdle")


func move():
	var current_agent_position: Vector2 = _NPC.global_position
	var next_path_position: Vector2 = navigation.get_next_path_position()
	
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * move_speed
	
	_NPC.velocity = new_velocity
