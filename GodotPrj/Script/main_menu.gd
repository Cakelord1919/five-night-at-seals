extends Node2D

@onready var ogArrow: AnimationPlayer = $background/arrow/AnimationPlayer
@onready var ogStaticPicture: Sprite2D = $background/static_picture
@onready var okgPictureAnimationPlayer: AnimationPlayer = $background/static_picture/AnimationPlayer

var gbIsHIColor: bool = false
var gbSwitchingScene: bool = false

func OnGameStartHovered():
	ogArrow.play("item1")
	return

func OnLoadFromSaveHovered():
	ogArrow.play("item2")
	return

func OnSettingsHovered():
	ogArrow.play("item3")
	return

func OnCreditsHovered():
	ogArrow.play("item4")
	return

func OnExitHovered():
	ogArrow.play("item5")
	return

func OnGameStartPressed():
	gbSwitchingScene = true
	SceneMan.switchScene("res://main_scene.tscn")
	return

func _process(delta: float):
	if gbSwitchingScene:
		return
	var fRandomHIColor = randf_range(0.8, 1.0)
	var fRandomLOWColor = randf_range(0.55, 0.65)
	var cRNG = randi_range(0, 100)
	if gbIsHIColor:
		if cRNG > 50:
			gbIsHIColor = !gbIsHIColor
			#ogStaticPicture.modulate = Color(fRandomHIColor, fRandomHIColor, fRandomHIColor, 1.0)
			okgPictureAnimationPlayer.play("light")
	else:
		if cRNG > 96:
			gbIsHIColor = !gbIsHIColor
			#ogStaticPicture.modulate = Color(fRandomLOWColor, fRandomLOWColor, fRandomLOWColor, 1.0)
			okgPictureAnimationPlayer.play("dark")
	return
