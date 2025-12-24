extends Node2D

@onready var ogTimerForRNG: Timer = $TimerForRNG

const AI_LVL_S = 5
const AI_LVL_E = 20
const AI_LVL_C = 20
const AI_LVL_R = 20
const AI_LVL_F = 20

signal seal_move
signal rabbit_move
signal starfish_move
signal coconut_move
signal endoskeleton_move

func OnTimer5s():
	ogTimerForRNG.stop()
	
	var cActionFactorS = randi_range(0, 100)
	var cActionFactorC = randi_range(0, 100)
	var cActionFactorR = randi_range(0, 100)
	var cActionFactorF = randi_range(0, 100)
	var cActionFactorE = randi_range(0, 100)
	
	print("TIMES UP!")
	
	if AI_LVL_S:
		if cActionFactorS < AI_LVL_S:
			sealMove()
	
	if AI_LVL_C:
		if cActionFactorC < AI_LVL_C:
			cocoMove()
	
	if AI_LVL_F:
		if cActionFactorF < AI_LVL_F:
			fishMove()

	if AI_LVL_R:
		if cActionFactorR < AI_LVL_R:
			rabbitMove()

	if AI_LVL_E:
		if cActionFactorE < AI_LVL_E:
			endoMove()

	ogTimerForRNG.start()
	return

func sealMove():
	#print("Seal move")
	emit_signal("seal_move")
	return

func cocoMove():
	#print("Coconut move")
	emit_signal("coconut_move")
	return

func fishMove():
	#print("Starfish move")
	emit_signal("starfish_move")
	return

func endoMove():
	#print("Endoskeleton move")
	emit_signal("endoskeleton_move")
	return
	
func rabbitMove():
	#print("Rabbit move")
	emit_signal("rabbit_move")
	return
