extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 5
var active = false
var BSpeed = 200
var Shootsound = preload("res://Audio/SE/SHuskShoot.wav")
var activate = preload("res://Audio/SE/Detected.wav")
var projallowed = 1
onready var hpbar = $EnemHealth

var pos

# Called when the node enters the scene tree for the first time.
func _ready():
	var pos = position

func _process(delta):
	
	
	
	if hp <= 0:
		queue_free()
		
		
	hpbar.value = hp
	hpbar.max_value = 5
	hpbar.min_value = 0
	
	$hptween.interpolate_property(hpbar,"value",hpbar.value, hpbar.value, 0.7, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$hptween.start()
	if Globals.ded == 1:
		position = pos
		active = false
	
	pass

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0

func _on_Area2D_area_entered(area):
	if area.is_in_group("hit1"):
		Globals.combotimer = 60 * 10
		Globals.combo += 1
		hp -= 0.8 + Globals.atkmult
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("slash"):
		Globals.combotimer = 60 * 10
		hp -= 0.5 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
	if area.is_in_group("hit2"):
		Globals.combotimer = 60 * 10
		hp -=  1 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()

		
		
	if area.is_in_group("hit3"):
		Globals.combotimer = 60 * 10
		hp -= 0.4 + Globals.atkmult
		Globals.combo += 1
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$multihurt.start()
		$multihurtrepeat.start()
		$hurt.play()

		
		
	if area.is_in_group("airhit"):
		Globals.combotimer = 60 * 10
		hp -= 1 + Globals.atkmult
		Globals.combo += 1
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



func _on_HorizDetect_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = false
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
		
	pass # Replace with function body.


func _on_HorizDetectright_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = true
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
	pass # Replace with function body.


func _on_DiagDetLeft_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = false
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
			
	pass # Replace with function body.


func _on_DiagDetRight_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = true
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
	pass # Replace with function body.


func _on_VertDetectLeft_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = false
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
	pass # Replace with function body.


func _on_VertDetectRight_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = true
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "shoot"
			active = true
	pass # Replace with function body.


func _on_Stickhusk_animation_finished():
	if $Stickhusk.animation == "shoot":
		projallowed = 1
