extends Node2D

@onready var ogTimerForRNG: Timer = $TimerForRNG

var gcSealCurrentPosition: int = 0
var gcEndoSkeletonCurrentPosition: int = 0
var gcCoconutCurrentPosition: int = 0
var gcRabbitCurrentPosition: int = 0
var gcStarfishCurrentPosition: int = 0

signal has_movement


func OnTimer5s():
	ogTimerForRNG.stop()
	
	print("TIMES UP!")
	
	if global_def.sealStatus["isActive"] \
	and global_def.sealStatus["jumpscare"] == false \
	and global_def.sealStatus["beingWatched"] == false:
		var cActionFactorS = randi_range(0, 100)
		print(global_def.sealStatus)
		if cActionFactorS < global_def.sealStatus["aiLevel"]:
			sealMove()
	
	if global_def.coconutStatus["isActive"] and global_def.coconutStatus["phase"] < 3:
		var cActionFactorC = randi_range(0, 100)
		print(global_def.coconutStatus)
		if cActionFactorC < global_def.coconutStatus["aiLevel"]:
			cocoMove()
	
	if global_def.starfishStatus["isActive"] and global_def.starfishStatus["jumpscare"] == false:
		var cActionFactorF = randi_range(0, 100)
		print(global_def.starfishStatus)
		if cActionFactorF < global_def.starfishStatus["aiLevel"]:
			fishMove()

	if global_def.rabbitStatus["isActive"] and global_def.rabbitStatus["jumpscare"] == false:
		var cActionFactorR = randi_range(0, 100)
		print(global_def.rabbitStatus)
		if cActionFactorR < global_def.rabbitStatus["aiLevel"]:
			rabbitMove()

	if global_def.endoskeletonStatus["isActive"] and global_def.endoskeletonStatus["jumpscare"] == false:
		var cActionFactorE = randi_range(0, 100)
		print(global_def.endoskeletonStatus)
		if cActionFactorE < global_def.endoskeletonStatus["aiLevel"]:
			endoMove()

	ogTimerForRNG.start()
	return

func sealMove():
	print("Seal move")
	if (gcSealCurrentPosition < global_def.geSealPosition.RIGHT_DOOR):
		# Otherwise, it'll stay at its current location
		gcSealCurrentPosition += 1
	else:
		# If the seal isn't blocked by right door, jumpscare the player
		if (global_def.sealStatus["isBlocked"] == false):
			gcSealCurrentPosition = global_def.geSealPosition.JUMPSCARE
		# Otherwise, it'll stay at its current location
	global_def.sealStatus["location"] = global_def.sealStatus["trail"][gcSealCurrentPosition]
	if global_def.sealStatus["location"] == "jumpscare":
		global_def.sealStatus["jumpscare"] = true
	emit_signal("has_movement")
	return

func cocoMove():
	print("Coconut move")
	if (gcCoconutCurrentPosition == global_def.geCoconutPosition.OFFICE):
		global_def.coconutStatus["location"] = global_def.coconutStatus["trail"][global_def.geCoconutPosition.OFFICE]
		if global_def.coconutStatus["phase"] < 3:
			global_def.coconutStatus["phase"] += 1
		else:
			global_def.coconutStatus["cutThePower"] = true
	else:
		gcCoconutCurrentPosition += 1
		global_def.coconutStatus["location"] = global_def.coconutStatus["trail"][gcCoconutCurrentPosition]
	emit_signal("has_movement")
	return

func fishMove():
	print("Starfish move")
	var cFishLocation = randi_range(0, global_def.geStarfishPosition.MAXMIUM)
	global_def.starfishStatus["location"] = global_def.starfishStatus["trail"][cFishLocation]
	emit_signal("has_movement")
	return

func endoMove():
	print("Endoskeleton move")
	if (gcEndoSkeletonCurrentPosition < global_def.geSealPosition.MAXMIUM):
		if (global_def.endoskeletonStatus["isBlocked"] == false):
			gcEndoSkeletonCurrentPosition += 1
		else:
			gcEndoSkeletonCurrentPosition = randi_range(0, global_def.geEndoSkeletonPosition.MAXMIUM)
	global_def.endoskeletonStatus["location"] = global_def.endoskeletonStatus["trail"][gcEndoSkeletonCurrentPosition]
	emit_signal("has_movement")
	return
	
func rabbitMove():
	print("Rabbit move")
	# If rabbit is at stage, choose 3 random place to go.
	# They are: kitchen, washroom, office
	if (gcRabbitCurrentPosition == global_def.geRabbitPosition.STAGE):
		gcRabbitCurrentPosition = randi_range(global_def.geRabbitPosition.WASHROOM, global_def.geRabbitPosition.OFFICE)
	# If rabbit is at office, then it will directly go to left door
	elif (gcRabbitCurrentPosition == global_def.geRabbitPosition.OFFICE):
		gcRabbitCurrentPosition = global_def.geRabbitPosition.LEFT_DOOR
	# If rabbit is at left door, check if it could jumpscare the player
	elif (gcRabbitCurrentPosition == global_def.geRabbitPosition.LEFT_DOOR):
		if global_def.rabbitStatus["isBlocked"]:
			gcRabbitCurrentPosition = randi_range(global_def.geRabbitPosition.STAGE, global_def.geRabbitPosition.MAXMIUM)
		else:
			gcRabbitCurrentPosition = global_def.geRabbitPosition.JUMPSCARE
	# If rabbit is at other places, it will choose 3 random places to go
	# They are: stage, washroom, kitchen
	else:
		gcRabbitCurrentPosition = randi_range(global_def.geRabbitPosition.STAGE, global_def.geRabbitPosition.KITCHEN)
	global_def.rabbitStatus["location"] = global_def.rabbitStatus["trail"][gcRabbitCurrentPosition]
	if global_def.rabbitStatus["location"] == "jumpscare":
		global_def.rabbitStatus["jumpscare"] = true
	emit_signal("has_movement")
	return
