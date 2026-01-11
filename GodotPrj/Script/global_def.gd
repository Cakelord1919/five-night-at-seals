# Autoloads when the game starts
# All of these variables could be called by using
# global_def.<variable_name> or global_def.<function_name>
extends Node

'''======Global Variables======'''
var _target_scene_path = ""
var _loading_screen_instance = null
var _loading_screen_scene = preload("res://loading_screen.tscn")

# DESCRIPTION:
# This part defines the enemy and their ability
# location: string value. their current location,
# will only be changed by functions inside enemy_ai.gd
# ======
# jumpscare: boolean value, check if they could
# jumpscare the player when the player leave the
# monitor. Will only be changed by enemy_ai.gd,
# but will be checked every time when the player
# leave the monitor.
# ======
# isBlocked: boolean value. To mark if they were
# blocked or being repelled. Will also be changed by
# only enemy_ai.gd. After they got shocked or blocked
# by doors, they will choose a random room in the map
# ======
# isActive: boolean value. To decide if they could move.
# ======
# aiLevel: interger value. Maxmium is 20, the script
# will check every 3 seconds to see if a RNG number is
# bigger or smaller than this value, only if the RNG is 
# smaller, the enemy could move. Set it to 0 makes them
# never move(or just disable their active status).
# It decides the chance of appearance on the starfish
# However, it has no use for uklele.
# ======
# SPECIAL CHARACTER PARAMETER:
# appearanceDurationTime: interger value. It decides
# how long will starfish stay in a location.
# ======
# heatResistanceLevel: interger value. It decides how long
# will it need to repell the endoskeleton by enabling the
# vent's heating system.
# ======
# rewindTimeLimit: interger value. It decides how long will
# it take to activate the uklele. Just like the puppet's music
# box from FNAF 2.
var sealStatus = {
	"location":"stage",
	"jumpscare":false,
	"isBlocked":false,
	"beingWatched": false,
	"isActive":false,
	"aiLevel": 0,
	"trail": ["stage", "kitchen", "backroom", "hallway", "rightdoor", "jumpscare"]
}

enum geSealPosition {
	STAGE, 
	KITCHEN, 
	BACKROOM, 
	HALLWAY, 
	RIGHT_DOOR, 
	JUMPSCARE, 
	MINIUM = 0, 
	MAXMIUM = JUMPSCARE
}

var rabbitStatus = {
	"location":"stage",
	"jumpscare":false,
	"isBlocked":false,
	"isActive":false,
	"aiLevel": 0,
	"trail": ["stage", "washroom", "kitchen", "office", "leftdoor", "jumpscare"]
}

enum geRabbitPosition {
	STAGE, 
	WASHROOM, 
	KITCHEN, 
	OFFICE, 
	LEFT_DOOR, 
	JUMPSCARE, 
	MINIUM = 0, 
	MAXMIUM = JUMPSCARE
}

var starfishStatus = {
	"location":"outside",
	"jumpscare":false,
	"isBlocked":false,
	"isActive":false,
	"aiLevel": 0,
	"trail": ["outside","stage", "kitchen", "backroom", "washroom", "jumpscare"],
	"appearanceDurationTime": 0
}

enum geStarfishPosition {
	STAGE, 
	KITCHEN, 
	WASHROOM, 
	BACKROOM,  
	HALLWAY, 
	JUMPSCARE, 
	MINIUM = 0, 
	MAXMIUM = JUMPSCARE
}

var coconutStatus = {
	"location":"stage",
	"jumpscare":false,
	"isBlocked":false,
	"isActive":false,
	"trail": ["stage", "office"],
	"aiLevel": 0,
	"phase":0,
	"cutThePower": false,
}

enum geCoconutPosition {
	STAGE, 
	OFFICE, 
	MINIUM = 0, 
	MAXMIUM = OFFICE
}

var endoskeletonStatus = {
	"location":"outside",
	"jumpscare":false,
	"isBlocked":false,
	"isActive":false,
	"trail": ["outside", "washroom", "backroom", "vent", "jumpscare"],
	"aiLevel": 0,
	"heatResistanceLevel": 0
}

enum geEndoSkeletonPosition {
	OUTSIDE, 
	WASHROOM, 
	BACKROOM, 
	VENT, 
	JUMPSCARE, 
	MINIUM = 0, 
	MAXMIUM = JUMPSCARE
}

var ukleleStatus = {
	"location":"storage",
	"jumpscare":false,
	"blocked":false,
	"isActive":false,
	"aiLevel": 0,
	"trail": ["storage", "jumpscare"],
	"rewindTimeLimit": 60
}

enum geUklelePosition {
	STORAGE,
	JUMPSCARE,
	MINIUM = 0, 
	MAXMIUM = JUMPSCARE
}

'''======Global Functions======'''
# The main function to call from anywhere in your game
func switchScene(scene_path):
	# Prevent starting a new load if one is already in progress
	if !_target_scene_path.is_empty():
		return

	_target_scene_path = scene_path

	# Create the loading screen and add it to the scene tree
	_loading_screen_instance = _loading_screen_scene.instantiate()
	get_tree().get_root().add_child(_loading_screen_instance)

	# --- Optional: Play a looping animation ---
	# If you added an AnimationPlayer to your loading screen named "AnimationPlayer"
	# and have an animation named "spinner", you can start it like this.
	# if _loading_screen_instance.has_node("AnimationPlayer"):
	#     _loading_screen_instance.get_node("AnimationPlayer").play("spinner")

	# Start loading the scene in the background
	ResourceLoader.load_threaded_request(_target_scene_path)

# Initialize the enemies difficulty.
func initEnemyByNights(currentNight:int=1):
	match currentNight:
		1:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		2:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		3:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		4:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		5:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		6:#Custom mode?
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
		_:
			# Set if an enemy is active
			sealStatus["isActive"] = false
			rabbitStatus["isActive"] = true
			starfishStatus["isActive"] = false
			coconutStatus["isActive"] = true
			endoskeletonStatus["isActive"] = false
			ukleleStatus["isActive"] = true
			# Set their AI level
			sealStatus["aiLevel"] = 0
			rabbitStatus["aiLevel"] = 10
			starfishStatus["aiLevel"] = 0
			coconutStatus["aiLevel"] = 5
			endoskeletonStatus["aiLevel"] = 0
			ukleleStatus["aiLevel"] = 0
			# Set their special abilities
			starfishStatus["appearanceDurationTime"] = 0
			endoskeletonStatus["heatResistanceLevel"] = 0
			ukleleStatus["rewindTimeLimit"] = 45
	return

# This function runs every frame to check the loading status
func _process(_delta):
	# If _target_scene_path is empty, we are not loading anything.
	if _target_scene_path.is_empty():
		return

	# Check the status of the background load. We don't need the progress array anymore.
	var status = ResourceLoader.load_threaded_get_status(_target_scene_path)

	# We only care about when the loading is fully complete.
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		# Get the loaded scene resource
		var packed_scene = ResourceLoader.load_threaded_get(_target_scene_path)

		# IMPORTANT: Reset the target path *before* changing the scene.
		_target_scene_path = ""
		
		# Switch to the newly loaded scene
		get_tree().change_scene_to_packed(packed_scene)
		
		# Clean up and remove the loading screen
		if _loading_screen_instance:
			_loading_screen_instance.queue_free()
			_loading_screen_instance = null
			
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		# Handle the error case
		print("Error: Failed to load scene ", _target_scene_path)
		_target_scene_path = ""
		if _loading_screen_instance:
			_loading_screen_instance.queue_free()
			_loading_screen_instance = null
