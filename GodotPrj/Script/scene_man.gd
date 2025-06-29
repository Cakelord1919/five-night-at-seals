# Autoloads when the game starts

extends Node

var _target_scene_path = ""
var _loading_screen_instance = null
var _loading_screen_scene = preload("res://loading_screen.tscn")

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
