extends Control
@onready var button: Button = $Button


# Connect and forward to script_director.gd
signal door_light_switch_pressed
signal door_light_switch_released


func OnLightSwitchBtn3DPressed():
	emit_signal("door_light_switch_pressed")
	pass

func OnLightSwitchBtn3DReleased():
	emit_signal("door_light_switch_released")
	pass

'''
func _process(delta: float):
	print(button.button_pressed)
	pass
'''
