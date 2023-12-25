extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var loading_scene = preload("res://Subrooms/loading screen.tscn")

# Called when the node enters the scene tree for the first time.
func load_scene(current_scene, next_scene):
	var loading_scene_instance = loading_scene.instance()
	get_tree().get_root().call_deferred("add_child",loading_scene_instance)
	
	
	var loader = ResourceLoader.load_interactive(next_scene)
	
	if loader == null:
		print("An error occured!\nScene Missing")
		return
	
	current_scene.queue_free()
	
	yield(get_tree().create_timer(0.5),"timeout")
	
	while true:
		var error = loader.poll()
		
		if error == ERR_FILE_EOF:
			var scene = loader.get_resource().instance()
			
			get_tree().get_root().call_deferred("add_child",scene)
			
			loading_scene_instance.queue_free()
			return

