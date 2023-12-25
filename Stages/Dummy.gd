extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	
	
	pass

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0

func _on_Area2D_area_entered(area):
	if area.is_in_group("hit1"):
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("slash"):
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("hit2"):
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
		
	if area.is_in_group("hit3"):
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$multihurt.start()
		$multihurtrepeat.start()
		$hurt.play()

		
		
	if area.is_in_group("airhit"):
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$multihurt.start()
		$multihurtrepeat.start()
		$hurt.play()

		

	

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()


func _on_multihurtrepeat_timeout():
	if !$multihurt.is_stopped():
		$multihurtrepeat.start()
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

