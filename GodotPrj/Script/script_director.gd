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
#########################################
'''

extends Node2D

@onready var ogCamera3D: Camera3D = $"../../Camera3D"

@onready var ogTurnLeftBtn: Button = $"../btnLeft"
@onready var ogTurnRightBtn: Button = $"../btnRight"
@onready var ogMapBtn: Button = $"../openMapBtn"
@onready var ogMonBtn: Button = $"../checkComBtn"


@export var ogDoorBtnLeft3D: Button
@export var ogDoorBtnRight3D: Button
@export var okgComAnim: AnimationPlayer
@export var ogDoorLeftAnim: AnimationPlayer
@export var ogDoorRightAnim: AnimationPlayer

var gwRotationTimes = 0
var gwRotationArrow = 0 #1 for left, -1 for right
var gbCheckCom = 0
var gfCameraDefaultAng = 0
var gbResetCam = 0
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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ProcessingCameraAngle()
	ProcessingCameraReset()
	#print(gwRotationTimes)
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
	pass

func enableAllBtns():
	ogMonBtn.disabled = false
	ogMapBtn.disabled = false
	ogTurnLeftBtn.disabled = false
	ogTurnRightBtn.disabled = false
	pass

func disableAllBtns3D():
	ogDoorBtnLeft3D.disabled = true
	ogDoorBtnRight3D.disabled = true
	pass

func enableAllBtns3D():
	ogDoorBtnLeft3D.disabled = false
	ogDoorBtnRight3D.disabled = false
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
		processingComputerAnim()
		pass

func processingComputerAnim():
	if gbCheckCom:
		#disableAllBtns()
		ogTurnLeftBtn.visible = false
		ogTurnRightBtn.visible = false
		okgComAnim.play("forward")
	else:
		#disableAllBtns()
		okgComAnim.play("back")
	pass

func processingDoorLeftAnim():
	disableAllBtns3D()
	if gbDoorLeftStat:
		ogDoorLeftAnim.play("down")
	else:
		ogDoorLeftAnim.play("lift")
	pass

func processingDoorRightAnim():
	disableAllBtns3D()
	if gbDoorRightStat:
		ogDoorRightAnim.play("down")
	else:
		ogDoorRightAnim.play("lift")
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
	#print("left!")
	gbDoorLeftStat =! gbDoorLeftStat
	processingDoorLeftAnim()
	pass

func OnDoorRightBtn3DPressed():
	#print("right!")
	gbDoorRightStat =! gbDoorRightStat
	processingDoorRightAnim()
	pass

func OnCheckComPressed():
	gbCheckCom = !gbCheckCom
	gbResetCam = 1
	#processingComputerAnim()
	pass

func MonAnimFin(anim_name: StringName) -> void:
	if anim_name == "forward":
		ogMapBtn.visible = true
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
	if anim_name == "down":
		enableAllBtns3D()
	pass # Replace with function body.

func DoorRightAnimFin(anim_name: StringName) -> void:
	if anim_name == "lift":
		enableAllBtns3D()
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
