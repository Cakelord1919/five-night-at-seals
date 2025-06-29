extends Node2D

@onready var ogArrow: AnimationPlayer = $background/arrow/AnimationPlayer


func OnGameStartHovered():
	ogArrow.play("item1")
	pass

func OnLoadFromSaveHovered():
	ogArrow.play("item2")
	pass

func OnSettingsHovered():
	ogArrow.play("item3")
	pass

func OnCreditsHovered():
	ogArrow.play("item4")
	pass

func OnExitHovered():
	ogArrow.play("item5")
	pass

func OnGameStartPressed():
	SceneMan.switchScene("res://main_scene.tscn")
	pass
