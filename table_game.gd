extends Node2D

@export var table_name: String = 'Table 1'

@onready var seats = {
	"seat 1": $"Chairs/seat-1",
	"seat 2": $"Chairs/seat-2",
	"seat 3": $"Chairs/seat-3",
	"seat 4": $"Chairs/seat-4",
	"seat 5": $"Chairs/seat-5",
	"seat 6": $"Chairs/seat-6",
	"seat 7": $"Chairs/seat-7",
	"seat 8": $"Chairs/seat-8",
}


func _ready():
	load_seats(seats)
	$Label.text = table_name


func _process(delta):
	pass


func load_seats(seat_dict):
	for seat in seat_dict:
		seat_dict[seat].open = true


func find_empty_seat():
	for seat in seats:
		if seats[seat].open == true:
			return seats[seat]
