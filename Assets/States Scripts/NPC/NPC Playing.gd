extends State
class_name NPCPlaying

var facing = 'right'

@export var _NPC: CharacterBody2D
@export var sprite: AnimatedSprite2D

var timer = 3

func Enter():
	facing = _NPC.seat.chair_direction
	timer = 10
	
	_NPC.seat.open = false
	_NPC.position = _NPC.seat.global_position
	_NPC.velocity = Vector2.ZERO
	
	animation_controller()

func Exit():
	_NPC.seat.open = true
	_NPC.seat = null


func Update(delta: float):
	pass


func Physics_Update(delta: float):
	timer -= delta
	if timer < 0:
		Transitioned.emit(self, "NPCLeaving")


func Handle_Input(event):
	pass


func animation_controller():
	var animation_names = sprite.sprite_frames.get_animation_names()
	if facing == "right" and "playing-right" in animation_names:
		sprite.play('playing-right')
	if facing == "left" and "playing-left" in animation_names:
		sprite.play('playing-left')
	if facing == "up" and "playing-up" in animation_names:
		sprite.play('playing-up')
	if facing == "down" and "playing-down" in animation_names:
		sprite.play('playing-down')

	
