extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 0.5
var active = false
var BSpeed = 1
var Shootsound = preload("res://Audio/SE/SHuskShoot.wav")
var activate = preload("res://Audio/SE/Detected.wav")
var projallowed = 1
export var facedir = 0
var dielol = 0
onready var hpbar = $EnemHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	match(facedir):
		0:
			scale.x = 0.5
		1:
			scale.x = -0.5
	pass

func _process(delta):
	if hp <= 0:
		if dielol == 0:
			frameFreeze(0.05, 0.75)
			Globals.camera.shake(100,0.5,900 * 2)
			
			dielol = 1
		
	if position.x < Globals.camera.limit_left || position.x > Globals.camera.limit_right || position.y < Globals.camera.limit_top || position.y > Globals.camera.limit_bottom:
		queue_free()
		
		
	hpbar.value = hp
	hpbar.max_value = 0.5
	hpbar.min_value = 0
	
	
	#$hptween.interpolate_property(hpbar,"hp",hpbar.value, hp,0.4,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		
	if !Globals.ded:
		if $Blobhusk.animation == "shoot":
			if $Blobhusk.frame == 1:
				if Globals.playerpos.x > position.x:
					if facedir == 0:
						$Blobhusk.flip_h = true
					if facedir == 1:
						$Blobhusk.flip_h = false
				else:
					if facedir == 0:
						$Blobhusk.flip_h = false
					if facedir == 1:
						$Blobhusk.flip_h = true
				if projallowed == 1:

					var BulletB = preload("res://Subrooms/Basic Proj Undodgeable.tscn").instance()

					
					
					
					$Blobhusk/Sounds.stream = Shootsound
					$Blobhusk/Sounds.play()

					BulletB.mode = 1
					BulletB.sp = 300

					

					
					get_parent().add_child(BulletB)
					BulletB.scale.y = 2

					if $Blobhusk.flip_h == false && facedir == 0|| $Blobhusk.flip_h == true && facedir == 1:


						BulletB.position.x = position.x - 48
						BulletB.position.y = position.y - 32

						

						BulletB.scale.x = -2



					if $Blobhusk.flip_h == true && facedir == 0 || $Blobhusk.flip_h == false && facedir == 1:

						BulletB.position.x = position.x + 48
						BulletB.position.y = position.y - 32
						BulletB.scale.x = 2

						
					
					
						
						
					projallowed = 0
				
	
	
	if Globals.ded:
		active = false
	
	
	pass

func frameFreeze(timeScale, duration):
	
	
	if hp <= 0:
		var DS = preload("res://Subrooms/Dspark.tscn")
		var buble = DS.instance()
		buble.position = global_position
		get_parent().add_child(buble)
	Globals.canthurt = 1
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0
	Globals.canthurt = 0
	var diesound = preload("res://Audio/SE/Enemdie.wav")
	#Globals.atkmult += (.3)
	if hp <= 0:
		Globals.score += 40
		$Blobhusk/Sounds.stream = diesound
		$Blobhusk/Sounds.play()
		$Blobhusk.play("die")
	
	
	
	

func _on_Area2D_area_entered(area):
	if hp > 0:
		
		if area.is_in_group("hurtbox") && active:
			if $Blobhusk.animation != "scared":
				$Blobhusk.play("scared")
		
		if area.is_in_group("hit1"):
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			hp -= 0.8 + Globals.atkmult
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)

			
		if area.is_in_group("slash"):
			hp -= 0.5 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)


			
		if area.is_in_group("hit2"):
			hp -=  1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)

			
			
		if area.is_in_group("hit3"):
			hp -= 0.4 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$multihurt.start()
			$multihurtrepeat.start()
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)
				
		if area.is_in_group("undodgeable"):
			hp -= 2 
			Globals.combotimer = 60 * 10
			Globals.combo += 4
			$hurt.play()
			Globals.score += 100
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				Globals.score += 600
#
			
			
		if area.is_in_group("airhit"):
			hp -= 1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			$multihurt.start()
			$multihurtrepeat.start()
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)


		if area.is_in_group("BIGDAMAGE"):
			hp -= 7 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.3)


	

func _on_multihurt_timeout():
	$multihurtrepeat.stop()
	


func _on_Area2D_area_exited(area):
	$multihurt.stop()


func _on_multihurtrepeat_timeout():
	if !$multihurt.is_stopped():
		if hp > 0:
			$multihurtrepeat.start()
			Input.start_joy_vibration(0, 1, 1, 0.2) 
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			hp -= 0.3 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			if hp > 0:
				frameFreeze(0.05, 0.3)




func _on_HorizDetect_area_entered(area):
	if area.is_in_group("hurtbox"):
		if !active && hp > 0:
			$Blobhusk/Sounds.stream = activate
			$Blobhusk/Sounds.play()
			if $Blobhusk.animation != "scared":
				$Blobhusk.animation = "shoot"
			active = true
	
	pass # Replace with function body.



func _on_Stickhusk_animation_finished():
	if $Blobhusk.animation == "scared":
		if Globals.playerpos.x > position.x - 48 && Globals.playerpos.x < position.x + 200:
			var telegraph = preload("res://Audio/SE/Detected.wav")
			#$Blobhusk/Sounds.stream = telegraph
			#$Blobhusk/Sounds.play()
			$Blobhusk.play("scared")
		else:
			$Blobhusk.play("shoot")
	if $Blobhusk.animation == "shoot": 
		if Globals.playerpos.x > position.x - 48 && Globals.playerpos.x < position.x + 200:
			$Blobhusk.play("scared")
		else:
			$Blobhusk.play("shoot")
		projallowed = 1
		if active == false:
			$Blobhusk.play("default")
		
	if $Blobhusk.animation == "die":
		queue_free()
