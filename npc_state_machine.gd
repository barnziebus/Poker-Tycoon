extends CharacterBody2D
class_name NPC

var open_seat: bool = false
var seat_position: Vector2
var seat: Area2D

signal look_for_empty_seat(npc)

func _physics_process(delta):
	move_and_slide()
	$RichTextLabel.text = $"State Machine".current_state.name


func _on_npc_idle_look_for_empty_seat():
	look_for_empty_seat.emit(self)
	
