extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hp = 50

enum wawa{
	IDLE,
	DETECT,
	RUN,
	JUMP,
	FALL,
	SHOOT,
	MELEE,
	HURT,
	DIE
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if hp <= 0 && $AnimationPlayer.current_animation != "Die":
		$AnimationPlayer.play("Die")
		Globals.music.stream = null
#	pass


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
		if !Globals.stuntList.empty():
			if Globals.player.is_on_floor():
				Globals.stuntList.append("GroundedKill")
			else:
				Globals.stuntList.append("AerialKill")

func _on_Hurtbox_area_entered(area):
	if hp > 0:
		
		if area.is_in_group("hit1"):
			$Head/Conditionplayer.play("damage")
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
			$Head/Conditionplayer.play("damage")
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
			$Head/Conditionplayer.play("damage")
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
			$Head/Conditionplayer.play("damage")
			hp -= 0.4 + Globals.atkmult
			
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(0.4 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			#$multihurt.start()
			#$multihurtrepeat.start()
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)
				
		if area.is_in_group("enemproject"):
			$Head/Conditionplayer.play("damage")
			Globals.groovePoints += Globals.grooveWorth * 2
			Globals.grooveTimer = Globals.grooveTimerMax
			Globals.grooveList.append("FriendlyFire")
			Globals.grooveList.pop_front()
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
			$Head/Conditionplayer.play("damage")
			hp -= 1 + Globals.atkmult
			Globals.combotimer = 60 * 10
			Globals.combo += 1
			
			var damage = preload("res://Subrooms/DAMAGE ENEMY.tscn")
			var damobj = damage.instance()
			damobj.position = global_position
			damobj.value = str(1 + Globals.atkmult)
			get_parent().add_child(damobj)
			
			
			Input.start_joy_vibration(0, 1, 1, 0.3) 
			#$multihurt.start()
			#$multihurtrepeat.start()
			$hurt.play()
			var hs = preload("res://Subrooms/hitspark.tscn")
			var ma = hs.instance()
			ma.position = global_position
			get_parent().add_child(ma)
			if hp > 0:
				frameFreeze(0.05, 0.1)


		if area.is_in_group("BIGDAMAGE"):
			$Head/Conditionplayer.play("damage")
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

func gonow():
	Switches.foresightdefeated = 1

func _on_Conditionplayer_animation_finished(anim_name):
	if anim_name == "damage":
		$Head/Conditionplayer.play("normal")
	pass # Replace with function body.
