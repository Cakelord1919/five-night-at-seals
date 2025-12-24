extends Control
@onready var button: Button = $Button
# Connect and forward to script_director.gd
signal door_3d_button_was_pressed

func OnDoorBtn3DPressed():
	emit_signal("door_3d_button_was_pressed")
	return
