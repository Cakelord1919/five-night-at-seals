'''
#########################################
		Variable Name Info
"g"lobal prefix means global variable
"o"bject prefix means node object variable
"b"inary prefix means binary variable
"w"ord   prefix means numberic variable
"s"tring prefix means string variable
lis"t"   prefix means list variable 
"k"id    preflx means child node object variable
FULL_CAPITAL means a static numberic 
#########################################
'''

'''
#########################################
			Extends section
#########################################
'''
extends Node2D

'''
#########################################
			Import section
#########################################
'''
@onready var ogMonRoomObj: Sprite2D = $"../monitorRoom"

@onready var ogTurnLeftBtn: Button = $"../turnLeftButton"
@onready var ogTurnRightBtn: Button = $"../turnRightButton"
@onready var ogMonBtn: Button = $"../openMonitorButton"
@onready var ogMapBtn: Button = $"../openMapButton"

# Import monitor pad sub scene
@onready var ogMonPad: Sprite2D = $"../monitorPad"
@export var ocgMonAnim: AnimationPlayer
# Insert map panel sub scene
@onready var ogMapPanel: Sprite2D = $"../mapPanel"
@export var ocgMapAnim: AnimationPlayer

'''
#########################################
		Global var decearing section
#########################################
'''
var gtViewDir = [0, 0]
var giMovementLimit = 0
var gbMonitorVisibility = false
var gbMapVisibility = false
'''
#########################################
		Global var decearing section
#########################################
'''
const PER_MOVEMENT = 20
const LIMIT_OFFSET = 30

'''
#########################################
		Physics processing section
#########################################
'''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ogMonPad.visible = false
	ogMapPanel.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	processingViewPoint()
	pass

'''
#########################################
		User functions section
#########################################
'''

func moveLeft():
	if giMovementLimit < LIMIT_OFFSET:
		giMovementLimit += 1
		ogMonRoomObj.global_position.x -= PER_MOVEMENT
	else:
		giMovementLimit = LIMIT_OFFSET
	#print(giMovementLimit)
	pass

func moveRight():
	if giMovementLimit > -LIMIT_OFFSET:
		giMovementLimit -= 1
		ogMonRoomObj.global_position.x += PER_MOVEMENT
	else:
		giMovementLimit = -LIMIT_OFFSET
	#print(giMovementLimit)
	pass

func onLeftPressed():
	gtViewDir[0] = 1
	pass

func onLeftReleased():
	gtViewDir[0] = 0;
	pass

func onRightPressed():
	gtViewDir[1] = 1
	pass

func onRightReleased():
	gtViewDir[1] = 0;
	pass

func onOpenMonitorPressed():
	gbMonitorVisibility = !gbMonitorVisibility
	processingMonitorVisible()
	pass

func onOpenMapPressed():
	gbMapVisibility = !gbMapVisibility
	processingMapVisible()
	pass

func processingViewPoint():
	if gtViewDir[0] == 1:
		moveLeft()
	if gtViewDir[1] == 1:
		moveRight()
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

func processingMonitorVisible():
	if gbMonitorVisibility:
		ogMonPad.visible = true
		ogMapBtn.visible = false
		disableAllBtns()
		ocgMonAnim.play("open")
	else:
		ogMonRoomObj.visible = true
		ogTurnLeftBtn.visible = true
		ogTurnRightBtn.visible = true
		disableAllBtns()
		ocgMonAnim.play("closed")
	pass

func processingMapVisible():
	if gbMapVisibility:
		ogMapPanel.visible = true
		ogMonBtn.visible = false
		disableAllBtns()
		ocgMapAnim.play("open")
	else:
		ogMonRoomObj.visible = true
		ogTurnLeftBtn.visible = true
		ogTurnRightBtn.visible = true
		disableAllBtns()
		ocgMapAnim.play("closed")
	pass


func mapAnimFin(anim_name: StringName) -> void:
	if anim_name == "open":
		ogMonRoomObj.visible = false
		ogTurnLeftBtn.visible = false
		ogTurnRightBtn.visible = false
		enableAllBtns()
	if anim_name == "closed":
		ogMapPanel.visible = false
		ogMonBtn.visible = true
		enableAllBtns()
	pass # Replace with function body.

func monAnimFin(anim_name: StringName) -> void:
	if anim_name == "open":
		ogMonRoomObj.visible = false
		ogTurnLeftBtn.visible = false
		ogTurnRightBtn.visible = false
		enableAllBtns()
	if anim_name == "closed":
		ogMonPad.visible = false
		ogMapBtn.visible = true
		enableAllBtns()
	pass # Replace with function body.
