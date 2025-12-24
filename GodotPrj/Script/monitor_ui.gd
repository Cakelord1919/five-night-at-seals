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

'''
#########################################
			Note
This script controls monitor UI and 
switching camera viewpoint.
Attached to monitor_ui.tscn scene
(Aka MonitorUI node)
#########################################
'''

extends Node2D

@onready var ogCam1Btn: Button = $Cam1Btn
@onready var ogCam2Btn: Button = $Cam2Btn
@onready var ogCam3Btn: Button = $Cam3Btn
@onready var ogCam4Btn: Button = $Cam4Btn
@onready var ogCam5Btn: Button = $Cam5Btn
@onready var ogCam6Btn: Button = $Cam6Btn
@onready var ogCam7Btn: Button = $Cam7Btn
@onready var ogCam8Btn: Button = $Cam8Btn

@onready var ogCam1Selected: Sprite2D = $MonitorProgram/CAM1Selected
@onready var ogCam2Selected: Sprite2D = $MonitorProgram/CAM2Selected
@onready var ogCam3Selected: Sprite2D = $MonitorProgram/CAM3Selected
@onready var ogCam4Selected: Sprite2D = $MonitorProgram/CAM4Selected
@onready var ogCam5Selected: Sprite2D = $MonitorProgram/CAM5Selected
@onready var ogCam6Selected: Sprite2D = $MonitorProgram/CAM6Selected
@onready var ogCam7Selected: Sprite2D = $MonitorProgram/CAM7Selected
@onready var ogCam8Selected: Sprite2D = $MonitorProgram/CAM8Selected
@onready var ogTextureRect: ColorRect = $TextureRect2

@onready var ogCameraView2D: AnimationPlayer = $SubViewport/StageCam/CameraView/AnimationPlayer
@onready var ogLoadingAnim: Sprite2D = $LoadingAnim
@onready var ogLoadingAnimPlayer: AnimationPlayer = $LoadingAnim/AnimationPlayer

@onready var ogEnemyAI: Node2D = $"../EnemyAI"

const CAM_1: StringName = "kitchen"
const CAM_2: StringName = "office"
const CAM_3: StringName = "stage"
const CAM_4: StringName = "storage"
const CAM_5: StringName = "backroom"
const CAM_6: StringName = "washroom"
const CAM_7: StringName = "hallway"
const CAM_8: StringName = "vent"
const ROLL_SPEED_ZERO = 0.0
const ROLL_SPEED_DEFAULT = 2.0
const ROLL_SIZE_ZERO = 0.0
const ROLL_SIZE_DEFAULT = 15.0

var gsCamera2DName: StringName = CAM_3
var gbAnimFin: bool = false
'''
var sealPos: Array = ["S", # Stage
						"", # Washroom
						"", # Bathroom
						"", # Backroom
						"", # Hallway
						"", # Office
						]

var cocoPos: Array = ["C", # Stage
						"", # Office1
						"", # Office2
						"", # Office3
						"", # Office4
						]

var rabbitPos: Array = ["R", # Stage
						"", # Kitchen
						"", # Washroom
						"", # Backroom
						"", # Office
						]

var starfishPos: Array = ["F", # Stage
						"", # Kitchen
						"", # Washroom
						"", # Backroom
						"", # Hallway
						]
'''
func _ready():
	# Signalss received from enemy_ai.gd
	# emitted when RNG confirm one AI's action
	ogEnemyAI.seal_move.connect(OnSealMoveSigRecv)
	ogEnemyAI.coconut_move.connect(OnCocoMoveSigRecv)
	ogEnemyAI.rabbit_move.connect(OnRabbitMoveSigRecv)
	ogEnemyAI.starfish_move.connect(OnFishMoveSigRecv)
	ogEnemyAI.endoskeleton_move.connect(OnEndoMoveSigRecv)
	return

func pauseShader(bRollStat: bool):
	var gShaderCRT: ShaderMaterial = ogTextureRect.material
	gShaderCRT.set_shader_parameter("roll", bRollStat)
	return

func modifyShader(fRollSize: float):
	var gShaderCRT: ShaderMaterial = ogTextureRect.material
	gShaderCRT.set_shader_parameter("roll_size", fRollSize)
	return

func hideAllCamSelected():
	ogCam1Selected.visible = false
	ogCam2Selected.visible = false
	ogCam3Selected.visible = false
	ogCam4Selected.visible = false
	ogCam5Selected.visible = false
	ogCam6Selected.visible = false
	ogCam7Selected.visible = false
	ogCam8Selected.visible = false
	return

func disableAllCamBtns():
	ogCam1Btn.disabled = true
	ogCam2Btn.disabled = true
	ogCam3Btn.disabled = true
	ogCam4Btn.disabled = true
	ogCam5Btn.disabled = true
	ogCam6Btn.disabled = true
	ogCam7Btn.disabled = true
	ogCam8Btn.disabled = true
	return

func enableAllCamBtns():
	ogCam1Btn.disabled = false
	ogCam2Btn.disabled = false
	ogCam3Btn.disabled = false
	ogCam4Btn.disabled = false
	ogCam5Btn.disabled = false
	ogCam6Btn.disabled = false
	ogCam7Btn.disabled = false
	ogCam8Btn.disabled = false
	# This shit fix the issues where in GD 4.4.1,
	# when you re-enabling the buttons after disabled,
	# it wont respond to your first click.
	ogCam1Btn.grab_focus()
	ogCam2Btn.grab_focus()
	ogCam3Btn.grab_focus()
	ogCam4Btn.grab_focus()
	ogCam5Btn.grab_focus()
	ogCam6Btn.grab_focus()
	ogCam7Btn.grab_focus()
	ogCam8Btn.grab_focus()
	return

func switchToStage():
	ogCameraView2D.play("stage")
	#ogCameraView2D.play("stage"+enemyFactors[0])
	return

func switchToWashroom():
	ogCameraView2D.play("washroom")
	#ogCameraView2D.play("washroom"+enemyFactors[1])
	return

func switchToBackroom():
	ogCameraView2D.play("backroom")
	#ogCameraView2D.play("backroom"+enemyFactors[2])
	return

func switchToKitchen():
	ogCameraView2D.play("kitchen")
	#ogCameraView2D.play("kitchen"+enemyFactors[3])
	return

func switchToOffice():
	ogCameraView2D.play("office")
	return

func switchToHallway():
	ogCameraView2D.play("hallway")
	return

func switchToVent():
	ogCameraView2D.play("vent")
	return

func processingCamera2D():
	match gsCamera2DName:
		CAM_1:
			switchToKitchen()
			return
		CAM_2:
			switchToOffice()
			return
		CAM_3:
			switchToStage()
			return
		CAM_5:
			switchToBackroom()
			return
		CAM_6:
			switchToWashroom()
			return
		CAM_7:
			switchToHallway()
			return
		CAM_8:
			switchToVent()
			return
		"_":
			return

func OnCam1BtnPressed():
	hideAllCamSelected()
	ogCam1Selected.visible = true
	if gsCamera2DName != CAM_1:
		gsCamera2DName = CAM_1
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam2BtnPressed():
	hideAllCamSelected()
	ogCam2Selected.visible = true
	if gsCamera2DName != CAM_2:
		gsCamera2DName = CAM_2
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam3BtnPressed():
	hideAllCamSelected()
	ogCam3Selected.visible = true
	if gsCamera2DName != CAM_3:
		gsCamera2DName = CAM_3
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam4BtnPressed():
	hideAllCamSelected()
	ogCam4Selected.visible = true
	return

func OnCam5BtnPressed():
	hideAllCamSelected()
	ogCam5Selected.visible = true
	if gsCamera2DName != CAM_5:
		gsCamera2DName = CAM_5
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam6BtnPressed():
	hideAllCamSelected()
	ogCam6Selected.visible = true
	if gsCamera2DName != CAM_6:
		gsCamera2DName = CAM_6
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam7BtnPressed():
	hideAllCamSelected()
	ogCam7Selected.visible = true
	if gsCamera2DName != CAM_7:
		gsCamera2DName = CAM_7
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnCam8BtnPressed():
	hideAllCamSelected()
	ogCam8Selected.visible = true
	if gsCamera2DName != CAM_8:
		gsCamera2DName = CAM_8
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
		pauseShader(false)
	return

func OnLoadingAnimFin(anim: StringName):
	if anim == "spin":
		enableAllCamBtns()
		ogLoadingAnim.visible = false
		processingCamera2D()
		var fRandomShaderSizeFactor = randf_range(0.0, 100.0)
		modifyShader(fRandomShaderSizeFactor)
		pauseShader(true)
	return

func OnSealMoveSigRecv():
	print("Seal move")
	return

func OnCocoMoveSigRecv():
	print("Coconut move")
	return

func OnFishMoveSigRecv():
	print("Starfish move")
	return

func OnRabbitMoveSigRecv():
	print("Rabbit move")
	return

func OnEndoMoveSigRecv():
	print("Endoskeleton move")
	return
