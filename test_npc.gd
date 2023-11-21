extends CharacterBody2D

@export var movement_speed: float = 50.0
@export var map_size: Vector2 = Vector2(320, 320) #map size in px

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AniSprite2D

var action = 'walking'
var states = ["wandering", "walking to seat", "leaving", "playing"]

func _ready():
	randomize()
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 20.0
	navigation_agent.debug_enabled = true

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		if action == 'targetting':
			action = 'sitting-left'
		else:
			var random = RandomNumberGenerator.new()
			random.randomize()
			var target_position = Vector2(randi_range(0, map_size.x), randi_range(0, map_size.y))
			set_movement_target(target_position)
	
	if action == "walking" or action == "targetting":
		move()
	
	aninmaiton_handler()


func aninmaiton_handler():
	if action == "walking" or action == "targetting":
		if velocity.x > 0:
			sprite.play("walk-right")
			z_index = 0
		else:
			sprite.play("walk-left")
			z_index = 0
	
	elif action == "sitting-right":
		sprite.play("sitting-right")
		z_index = 1
	elif action == "sitting-left":
		sprite.play("sitting-left")
		z_index = 1
	elif action == "sitting-up":
		sprite.play("sitting-up")
	elif action == "sitting-down":
		sprite.play("sitting-down")


func move():
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	velocity = new_velocity
	move_and_slide()


func _input(event):
	if event.is_action_pressed("left-click"):
		set_movement_target(get_global_mouse_position())


func move_to_seat(seat_node: Node2D) -> void:
	var offset = Vector2(0,0) #used for sprite alignment as required
	
	action = 'moving to seat'
	
	set_movement_target(seat_node.position + offset)
	
