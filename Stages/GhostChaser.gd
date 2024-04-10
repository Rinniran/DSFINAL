extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 3
var active = false
var BSpeed = 200
var Shootsound = preload("res://Audio/SE/SHuskShoot.wav")
var activate = preload("res://Audio/SE/Detected.wav")
var projallowed = 1
onready var hpbar = $EnemHealth
var dead = 0
var dielol = 0
var grazecnt = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	if hp <= 0:
		if dielol == 0:
			frameFreeze(0.05, 0.75)
			Globals.camera.shake(50,0.8,300)
			dielol = 1
		
		
	hpbar.value = hp
	hpbar.max_value = 3
	hpbar.min_value = 0
	
	
	
	
	
	
	
	
	if Globals.ded:
		active = false
		$Stickhusk.play()
	
	
	if dielol == 1:
		$CollisionShape2D.disabled = true
	
	#$hptween.interpolate_property(hpbar,"hp",hpbar.value, hp,0.4,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		
	
	pass

func frameFreeze(timeScale, duration):
	if hp <= 0:
		var DS = preload("res://Subrooms/Dspark.tscn").instance()
		DS.position = position
		get_parent().add_child(DS)
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	Globals.canthurt = 0
	var diesound = preload("res://Audio/SE/Enemdie.wav")
	#Globals.atkmult += (.3)
	if hp <= 0:
		Globals.score += 40
		$Stickhusk/Sounds.stream = diesound
		$Stickhusk/Sounds.play()
		$Stickhusk.play("die")
	





	

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()


func _on_multihurtrepeat_timeout():
	if !$multihurt.is_stopped():
		$multihurtrepeat.start()
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()
		Globals.combotimer = 60 * 10
		hp -= 0.3 + Globals.atkmult
		
		var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
		var damobj = damage.instance()
		damobj.rect_position = $Stickhusk.position
		damobj.value = str(0.3 + Globals.atkmult)
		get_parent().add_child(damobj)
		
		var jj = preload("res://Subrooms/hitspark.tscn")
		var ba = jj.instance()
		ba.position = global_position
		get_parent().add_child(ba)
		if hp > 0:
			frameFreeze(0.05, 0.3)





func _on_HorizDetect_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = true
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "chase"
			active = true
		
	pass # Replace with function body.


func _on_HorizDetectright_area_entered(area):
	if area.is_in_group("hurtbox"):
		$Stickhusk.flip_h = false
		if !active:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			$Stickhusk.animation = "chase"
			active = true
	pass # Replace with function body.


func _on_Stickhusk_animation_finished():
	if $Stickhusk.animation == "chase":
		projallowed = 1
		
	if $Stickhusk.animation == "die":
		dead = 1


func _on_multihit_timeout():
	$CollisionShape2D.disabled = !$CollisionShape2D.disabled


func _on_hurtbox_area_entered(area):
	if (area.is_in_group("hurtbox") && Globals.player.dashing) || area.is_in_group("Odachi"):
		Globals.combotimer = 60 * 10
		hp -= 7 + Globals.atkmult
		Globals.combo += 1
		
		var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
		var damobj = damage.instance()
		damobj.position = $Stickhusk.position
		damobj.scale = Vector2(2,2)
		damobj.value = str(7 + Globals.atkmult)
		get_parent().add_child(damobj)
		
		Input.start_joy_vibration(0, 1, 1, 0.2) 
		$hurt.play()
		var jj = preload("res://Subrooms/hitspark.tscn")
		var ba = jj.instance()
		ba.position = position
		get_parent().add_child(ba)
		if hp > 0:
			frameFreeze(0.05, 0.3)
	pass # Replace with function body.
