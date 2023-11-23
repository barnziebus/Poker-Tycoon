extends State
class_name NPCLeaving

var move_direction : Vector2
var wander_time : float
var target_position: Vector2

@export var _NPC: CharacterBody2D
@export var navigation: NavigationAgent2D
@export var move_speed := 30.0
@export var sprite: AnimatedSprite2D

@export var leave_position: Vector2 = Vector2(60,60)


func Enter():
	call_deferred("actor_setup")
	
	_NPC.seat = null
	
	navigation.path_desired_distance = 4.0
	navigation.target_desired_distance = 20.0
	navigation.debug_enabled = true
	
	leave()


func Exit():
	_NPC.velocity = Vector2.ZERO


func Update(delta: float):
	if navigation.is_navigation_finished():
		_NPC.queue_free()


func Physics_Update(delta: float):
	if _NPC:
		move()
	
	animation_handler()


func Handle_Input(event):
	pass


func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame


func leave():
	navigation.target_position = leave_position



func animation_handler():
	if _NPC.velocity > Vector2.ZERO:
		sprite.play('walk-right')
	else:
		sprite.play('walk-left')


func move():
	var current_agent_position: Vector2 = _NPC.global_position
	var next_path_position: Vector2 = navigation.get_next_path_position()
	
	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * move_speed
	
	_NPC.velocity = new_velocity
