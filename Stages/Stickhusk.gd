extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp = 1.8
var active = false
var BSpeed = 200
var Shootsound = preload("res://Audio/SE/SHuskShoot.wav")
var activate = preload("res://Audio/SE/Detected.wav")
var projallowed = 1

var dielol = 0
onready var hpbar = $EnemHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	
	match(Globals.diff):
		0:
			$Stickhusk.speed_scale = 0.5
		1:
			$Stickhusk.speed_scale = 1
		2:
			$Stickhusk.speed_scale = 1.2
	
	pass

func _process(delta):
	if hp <= 0:
		if dielol == 0:
			frameFreeze(0.05, 0.75)
			Globals.camera.shake(100,0.5,900 * 2)
			$CollisionShape2D.queue_free()
			dielol = 1
		
		
		
		
	hpbar.value = hp
	hpbar.max_value = 1.8
	hpbar.min_value = 0
	
	if position.x < Globals.camera.limit_left || position.x > Globals.camera.limit_right || position.y < Globals.camera.limit_top || position.y > Globals.camera.limit_bottom:
		queue_free()
	#$hptween.interpolate_property(hpbar,"hp",hpbar.value, hp,0.4,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		
	if !Globals.ded:
		if $Stickhusk.animation == "shoot":
			if $Stickhusk.frame == 1:
				if Globals.playerpos.x > position.x:
					$Stickhusk.flip_h = true
				else:
					$Stickhusk.flip_h = false
				if projallowed == 1:
					var BulletA = preload("res://Subrooms/Basic Proj.tscn").instance()
					var BulletB = preload("res://Subrooms/Basic Proj.tscn").instance()
					var BulletC = preload("res://Subrooms/Basic Proj.tscn").instance()
					
					
					
					
					$Stickhusk/Sounds.stream = Shootsound
					$Stickhusk/Sounds.play()
					BulletA.mode = 1
					BulletB.mode = 2
					BulletC.mode = 3
					
					get_parent().add_child(BulletA)
					
					get_parent().add_child(BulletB)
					
					get_parent().add_child(BulletC)
					if $Stickhusk.flip_h == false:
						BulletA.position.x = position.x - 48
						BulletA.position.y = position.y
						BulletB.position.x = position.x - 48
						BulletB.position.y = position.y
						BulletC.position.x = position.x - 48
						BulletC.position.y = position.y
						
						BulletA.scale.x = -0.5
						BulletB.scale.x = -0.5
						BulletC.scale.x = -0.5


					if $Stickhusk.flip_h == true:
						BulletA.position.x = position.x + 48
						BulletA.position.y = position.y
						BulletB.position.x = position.x + 48
						BulletB.position.y = position.y
						BulletC.position.x = position.x + 48
						BulletC.position.y = position.y
						BulletA.scale.x = 0.5
						BulletB.scale.x = 0.5
						BulletC.scale.x = 0.5
						
					
					
						
						
					projallowed = 0
				
		if $Stickhusk.animation == "melee":
			if $Stickhusk.frame == 1:
				var telegraph = preload("res://Audio/SE/Detected.wav")
				$Stickhusk/Sounds.stream = telegraph
				$Stickhusk/Sounds.play()
				if Globals.playerpos.x > position.x:
					$Stickhusk.flip_h = true
				else:
					$Stickhusk.flip_h = false
			if $Stickhusk.frame > 4 && $Stickhusk.frame < 8:
				$Melee/Horz.disabled = false
				$Melee/Horz.disabled = false
			else:
				$Melee/Horz.disabled = true
				$Melee/Horz.disabled = true
	
	
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
		$Stickhusk/Sounds.stream = diesound
		$Stickhusk/Sounds.play()
		$Stickhusk.play("die")
	
	
	
	

func _on_Area2D_area_entered(area):
	if hp > 0:
		
		if area.is_in_group("hurtbox") && active:
			if $Stickhusk.animation != "melee" && Globals.diff > 0:
				$Stickhusk.play("melee")
		
		if area.is_in_group("hit1"):
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			hp -= 0.8 + Globals.atkmult
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.8 + Globals.atkmult)
			get_parent().add_child(damobj)
			
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
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.5 + Globals.atkmult)
			get_parent().add_child(damobj)
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
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
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
			
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.4 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
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
				
		if area.is_in_group("enemproject"):
			hp -= 2 
			Globals.combotimer = 60 * 10
			Globals.combo += 4
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(2 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
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
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
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
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(7 + Globals.atkmult)
			get_parent().add_child(damobj)
			
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
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(hp - 0.3 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			if hp > 0:
				frameFreeze(0.05, 0.3)




func _on_HorizDetect_area_entered(area):
	if area.is_in_group("hurtbox"):
		if !active && hp > 0:
			$Stickhusk/Sounds.stream = activate
			$Stickhusk/Sounds.play()
			if $Stickhusk.animation != "melee":
				$Stickhusk.animation = "shoot"
			active = true
	
	pass # Replace with function body.



func _on_Stickhusk_animation_finished():
	if $Stickhusk.animation == "melee":
		if Globals.playerpos.x > position.x - 48 && Globals.playerpos.x < position.x + 48:
			var telegraph = preload("res://Audio/SE/Detected.wav")
			$Stickhusk/Sounds.stream = telegraph
			$Stickhusk/Sounds.play()
			$Stickhusk.play("melee")
		else:
			$Stickhusk.play("shoot")
	if $Stickhusk.animation == "shoot": 
		if Globals.playerpos.x > position.x - 48 && Globals.playerpos.x < position.x + 48 && Globals.diff > 0:
			$Stickhusk.play("melee")
		else:
			$Stickhusk.play("shoot")
		projallowed = 1
		if active == false:
			$Stickhusk.play("default")
		
	if $Stickhusk.animation == "die":
		
		queue_free()
