extends Node2D

@onready var sprite: AnimatedSprite2D = $"chair-sprite"
@onready var sprite_chair_back: AnimatedSprite2D = $"chair-back-sprite"

@export_enum("up", "down", "left", "right") var chair_direction: String = "up"

@export var map: TileMap

signal chair_is_empty(chair_position)

var open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if chair_direction == "up":
		sprite.play("up")
		sprite_chair_back.visible = true
	elif chair_direction == "down":
		sprite.play("down")
		sprite_chair_back.visible = false
	elif chair_direction == "left":
		sprite.play("right")
		sprite_chair_back.visible = false
	elif chair_direction == "right":
		sprite.flip_h = true
		sprite.play("right")
		sprite_chair_back.visible = false
	else:
		push_error("incorrect chair direction name")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	chair_handler()
	if open:
		$RichTextLabel.text = "open"
	else:
		$RichTextLabel.text = "closed"
		


func chair_handler():
	if open:
		emit_signal("chair_is_empty", position)
		map.set_cell(0, map.local_to_map(position), 0, Vector2(0,1))
	else:
		map.set_cell(0, map.local_to_map(position), 0, Vector2(1,0))

func _on_body_entered(body):
	print(body, "body")