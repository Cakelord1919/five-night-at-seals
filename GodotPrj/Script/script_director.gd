extends Node2D

@onready var camera_3d: Camera3D = $"../../Camera3D"

var gwRotationTimes = 0
var gwRotationArrow = 0

const ROTATION_OFFSET = 17
const ROTATION_SPEED = 0.03

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	processingCameraAngle()
	pass

func processCameraLeft():
	if(gwRotationTimes < ROTATION_OFFSET):
		gwRotationTimes += 1
		moveCameraAngle(ROTATION_SPEED)
	else:
		gwRotationTimes = ROTATION_OFFSET
	pass

func processCameraRight():
	if(gwRotationTimes > -ROTATION_OFFSET):
		gwRotationTimes -= 1
		moveCameraAngle(-ROTATION_SPEED)
	else:
		gwRotationTimes = -ROTATION_OFFSET
	pass

func moveCameraAngle(angle: float):
	camera_3d.rotate_y(angle)
	pass

func processingCameraAngle():
	if gwRotationArrow > 0:
		processCameraLeft()
	elif gwRotationArrow < 0:
		processCameraRight()
	pass

func onBtnLeftPressed():
	gwRotationArrow = 1
	pass


func onBtnRightPressed():
	gwRotationArrow = -1
	pass

func onBtnLeftRel():
	gwRotationArrow = 0
	pass

func onBtnRightRel():
	gwRotationArrow = 0
	pass
