'''
#########################################
		Variable Name Info
"g"lobal prefix means global variable
"o"bject prefix means node object variable
"b"inary prefix means binary variable
"w"ord   prefix means numberic variable
"f"loat  prefix means float variable
"s"tring prefix means string variable
lis"t"   prefix means list variable 
"k"id    preflx means child node object variable
CapitalFunction() means the function was execute directly
FULL_CAPITAL means a static numberic
full_lower_case means a signal
#########################################
'''

extends Node2D

@onready var ogCamera3D: Camera3D = $"../../Camera3D"

@onready var ogTurnLeftBtn: Button = $"../btnLeft"
@onready var ogTurnRightBtn: Button = $"../btnRight"
@onready var ogMapBtn: Button = $"../openMapBtn"
@onready var ogMonBtn: Button = $"../checkComBtn"
@onready var ogDoorsBtnLeft3DCtrl: Control = $"../../DoorsBtnLeft/BtnSceneLeft/Control"
@onready var ogDoorsBtnRight3DCtrl: Control = $"../../DoorsBtnRight/BtnSceneRight/Control"
@onready var ogDoorsBtnLeft3D: Button = $"../../DoorsBtnLeft/BtnSceneLeft/Control/Button"
@onready var ogDoorsBtnRight3D: Button = $"../../DoorsBtnRight/BtnSceneRight/Control/Button"
@onready var ogHallLeftLight3DCtrl: Control = $"../../LeftHallLightSwitch/LightSwitchSceneLeft/Control"
@onready var ogHallRightLight3DCtrl: Control = $"../../RightHallLightSwitch/LightSwitchSceneRight/Control"
@onready var ogHallLeftLight3DBtn: Button = $"../../LeftHallLightSwitch/LightSwitchSceneLeft/Control/Button"
@onready var ogHallRightLight3DBtn: Button = $"../../RightHallLightSwitch/LightSwitchSceneRight/Control/Button"


@export var okgComAnim: AnimationPlayer
@export var okgDoorLeftAnim: AnimationPlayer
@export var okgDoorRightAnim: AnimationPlayer
@export var okgHallLeftAnim: AnimationPlayer
@export var okgHallRightAnim: AnimationPlayer

var gwRotationTimes = 0
var gwRotationArrow = 0 #1 for left, -1 for right
var gbCheckCom = 0
var gfCameraDefaultAng = 0
var gbResetCam = 0 #1 for reset camera angle, 0 for not 
var gbDoorLeftStat = 0 #0 for open, 1 for close
var gbDoorRightStat = 0 #0 for open, 1 for close



const ROTATION_OFFSET = 15
const ROTATION_SPEED = 0.05

'''
#########################################
		Processing Function
#########################################
'''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Signal received from doors_btn_2d_subview.gd
	# attached to each side 3d button's Control node
	# and execute the correspond door animation function
	ogDoorsBtnLeft3DCtrl.door_3d_button_was_pressed.connect(OnDoorLeftBtn3DPressed)
	ogDoorsBtnRight3DCtrl.door_3d_button_was_pressed.connect(OnDoorRightBtn3DPressed)

	# Signal received from hall_light_switch_2d_subview.gd
	# attached to each side 3d button's Control node
	# and execute the correspond door animation function
	ogHallLeftLight3DCtrl.door_light_switch_pressed.connect(OnLightSwitchLeft3DPressed)
	ogHallRightLight3DCtrl.door_light_switch_pressed.connect(OnLightSwitchRight3DPressed)
	ogHallLeftLight3DCtrl.door_light_switch_released.connect(OnLightSwitchLeft3DReleased)
	ogHallRightLight3DCtrl.door_light_switch_released.connect(OnLightSwitchRight3DReleased)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ProcessingCameraAngle()
	ProcessingCameraReset()
	#print(gbCheckCom)
	pass

'''
#########################################
			Sub Function
#########################################
'''

func moveCameraLeft():
	if(gwRotationTimes < ROTATION_OFFSET):
		gwRotationTimes += 1
		moveCameraAngle(ROTATION_SPEED)
	else:
		gwRotationTimes = ROTATION_OFFSET
	pass

func moveCameraRight():
	if(gwRotationTimes > -ROTATION_OFFSET):
		gwRotationTimes -= 1
		moveCameraAngle(-ROTATION_SPEED)
	else:
		gwRotationTimes = -ROTATION_OFFSET
	pass

func moveCameraAngle(angle: float):
	ogCamera3D.rotate_y(angle)
	pass

func disableAllBtns():
	ogMonBtn.disabled = true
	ogMapBtn.disabled = true
	ogTurnLeftBtn.disabled = true
	ogTurnRightBtn.disabled = true
	#print("All buttons disabled")
	pass

func enableAllBtns():
	ogMonBtn.disabled = false
	ogMapBtn.disabled = false
	ogTurnLeftBtn.disabled = false
	ogTurnRightBtn.disabled = false
	# This shit fix the issues where in GD 4.4.1,
	# when you re-enabling the buttons after disabled,
	# it wont respond to your first click.
	ogMonBtn.grab_focus()
	ogMapBtn.grab_focus()
	ogTurnLeftBtn.grab_focus()
	ogTurnRightBtn.grab_focus()
	#print("All buttons enabled")
	pass

func disableAllBtns3D():
	ogDoorsBtnLeft3D.disabled = true
	ogDoorsBtnRight3D.disabled = true
	pass

func enableAllBtns3D():
	ogDoorsBtnLeft3D.disabled = false
	ogDoorsBtnRight3D.disabled = false
	ogDoorsBtnLeft3D.grab_focus()
	ogDoorsBtnRight3D.grab_focus()
	pass

func cameraReset():
	disableAllBtns()
	if gwRotationTimes < 0:
		gwRotationTimes += 1
		moveCameraAngle(ROTATION_SPEED)
		pass
	if gwRotationTimes > 0:
		gwRotationTimes -= 1
		moveCameraAngle(-ROTATION_SPEED)
		pass
	if gwRotationTimes == 0:
		gbResetCam = 0
		processingComAnim()
		pass

func processingComAnim():
	if gbCheckCom:
		#disableAllBtns()
		ogTurnLeftBtn.visible = false
		ogTurnRightBtn.visible = false
		okgComAnim.play("forward")
	else:
		#disableAllBtns()
		ogCamera3D.fov = 55.0
		okgComAnim.play("back")
	pass

func processingDoorLeftAnim():
	disableAllBtns3D()
	if gbDoorLeftStat:
		okgDoorLeftAnim.play("down")
	else:
		okgDoorLeftAnim.play("lift")
	pass

func processingDoorRightAnim():
	disableAllBtns3D()
	if gbDoorRightStat:
		okgDoorRightAnim.play("down")
	else:
		okgDoorRightAnim.play("lift")
	pass

func disableLeftLight():
	ogHallLeftLight3DBtn.disabled = true
	pass

func enableLeftLight():
	ogHallLeftLight3DBtn.disabled = false
	ogHallLeftLight3DBtn.grab_focus()
	pass

func disableRightLight():
	ogHallRightLight3DBtn.disabled = true
	pass

func enableRightLight():
	ogHallRightLight3DBtn.disabled = false
	ogHallRightLight3DBtn.grab_focus()
	pass

'''
#########################################
			Function Prime
#########################################
'''
func OnBtnLeftPressed():
	gwRotationArrow = 1
	pass

func OnBtnRightPressed():
	gwRotationArrow = -1
	pass

func OnBtnLeftRelease():
	gwRotationArrow = 0
	pass

func OnBtnRightRelease():
	gwRotationArrow = 0
	pass

func OnDoorLeftBtn3DPressed():
	gbDoorLeftStat = !gbDoorLeftStat
	# This disables the light switch when the door is going to close.
	if gbDoorLeftStat:
		disableLeftLight()
	processingDoorLeftAnim()
	pass

func OnDoorRightBtn3DPressed():
	gbDoorRightStat = !gbDoorRightStat
	# This disables the light switch when the door is going to close.
	if gbDoorRightStat:
		disableRightLight()
	processingDoorRightAnim()
	pass

func OnLightSwitchLeft3DPressed():
	#Left Lights on
	okgHallLeftAnim.play("light")
	pass

func OnLightSwitchRight3DPressed():
	#Right Lights on
	okgHallRightAnim.play("light")
	pass

func OnLightSwitchLeft3DReleased():
	#Left Lights off
	okgHallLeftAnim.play("dark")
	pass

func OnLightSwitchRight3DReleased():
	#Right Lights off
	okgHallRightAnim.play("dark")
	pass

func OnCheckComPressed():
	#print("btn pressed")
	gbCheckCom = !gbCheckCom
	gbResetCam = 1
	#processingComputerAnim()
	pass

func ComAnimFin(anim_name: StringName) -> void:
	if anim_name == "forward":
		ogMapBtn.visible = true
		ogCamera3D.fov = 45.0
		enableAllBtns()
	if anim_name == "back":
		ogTurnLeftBtn.visible = true
		ogTurnRightBtn.visible = true
		ogMapBtn.visible = false
		enableAllBtns()
	pass # Replace with function body.

func DoorLeftAnimFin(anim_name: StringName) -> void:
	if anim_name == "lift":
		enableAllBtns3D()
		#This re-enables the light switch after the door is opened
		enableLeftLight()
	if anim_name == "down":
		enableAllBtns3D()
	pass # Replace with function body.

func DoorRightAnimFin(anim_name: StringName) -> void:
	if anim_name == "lift":
		enableAllBtns3D()
		#This re-enables the light switch after the door is opened
		enableRightLight()
	if anim_name == "down":
		enableAllBtns3D()
	pass # Replace with function body.

func ProcessingCameraAngle():
	if gwRotationArrow > 0:
		moveCameraLeft()
	elif gwRotationArrow < 0:
		moveCameraRight()
	pass

func ProcessingCameraReset():
	if gbResetCam:
		cameraReset()
	pass
