extends State
class_name PlayerDefault

@export var UI: Control

func Enter():
	print('Player Default Entered')


func Exit():
	pass


func Update(delta: float):
	if UI.buy_button.button_pressed:
		Transitioned.emit(self, "PlayerBuy")


func Physics_Update(delta:float):
	pass


func Handle_Input(event):
	pass
