extends State
class_name NPCPlaying

var facing = 'right'

@export var _NPC: CharacterBody2D
@export var sprite: AnimatedSprite2D

var timer = 3

func Enter():
	_NPC.seat.open = false
	timer = 10
	animation_controller()
	_NPC.position = _NPC.seat.global_position
	_NPC.velocity = Vector2.ZERO


func Exit():
	_NPC.seat.open = true
	_NPC.seat = null


func Update(delta: float):
	pass


func Physics_Update(delta: float):
	timer -= delta
	if timer < 0:
		Transitioned.emit(self, "NPCLeaving")


func animation_controller():
	var animation_names = sprite.sprite_frames.get_animation_names()
	if facing == "right" and "playing-right" in animation_names:
		sprite.play('playing-right')
	
