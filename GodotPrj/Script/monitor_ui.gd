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

@onready var ogCameraView2D: AnimationPlayer = $SubViewport/StageCam/CameraView/AnimationPlayer
@onready var ogLoadingAnim: Sprite2D = $LoadingAnim
@onready var ogLoadingAnimPlayer: AnimationPlayer = $LoadingAnim/AnimationPlayer

const CAM_1: StringName = ""
const CAM_2: StringName = ""
const CAM_3: StringName = "stage"
const CAM_4: StringName = ""
const CAM_5: StringName = ""
const CAM_6: StringName = "washroom"

var gsCamera2DName: StringName = CAM_3
var gbAnimFin: bool = false

func disableAllCamBtns():
	ogCam1Btn.disabled = true
	ogCam2Btn.disabled = true
	ogCam3Btn.disabled = true
	ogCam4Btn.disabled = true
	ogCam5Btn.disabled = true
	ogCam6Btn.disabled = true	
	pass

func enableAllCamBtns():
	ogCam1Btn.disabled = false
	ogCam2Btn.disabled = false
	ogCam3Btn.disabled = false
	ogCam4Btn.disabled = false
	ogCam5Btn.disabled = false
	ogCam6Btn.disabled = false
	# This shit fix the issues where in GD 4.4.1,
	# when you re-enabling the buttons after disabled,
	# it wont respond to your first click.
	ogCam1Btn.grab_focus()
	ogCam2Btn.grab_focus()
	ogCam3Btn.grab_focus()
	ogCam4Btn.grab_focus()
	ogCam5Btn.grab_focus()
	ogCam6Btn.grab_focus()
	pass

func switchToStage():
	ogCameraView2D.play("stage")
	pass

func switchToWashroom():
	ogCameraView2D.play("washroom")
	pass

func processingCamera2D():
	match gsCamera2DName:
		CAM_3:
			switchToStage()
			pass
		CAM_6:
			switchToWashroom()
			pass
		"_":
			pass

func OnCam1BtnPressed():
	pass

func OnCam2BtnPressed():
	pass

func OnCam3BtnPressed():
	if gsCamera2DName != CAM_3:
		gsCamera2DName = CAM_3
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
	pass

func OnCam4BtnPressed():
	pass

func OnCam5BtnPressed():
	pass

func OnCam6BtnPressed():
	if gsCamera2DName != CAM_6:
		gsCamera2DName = CAM_6
		ogLoadingAnim.visible = true
		ogLoadingAnimPlayer.play("spin")
		ogCameraView2D.pause()
		disableAllCamBtns()
	pass

func OnLoadingAnimFin(anim: StringName):
	if anim == "spin":
		enableAllCamBtns()
		ogLoadingAnim.visible = false
		processingCamera2D()
	pass
