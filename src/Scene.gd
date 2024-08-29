extends Node

export var next = "Scene Path"

export (AudioStream) var musplay

export var initialTime = 0

export var canmove = 1

export  var demo = 0

export var vidmode = 0

export var zoomallowed = true

export var current_stage = 1

export var skippable = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done = 0

var bossdefeated = 0

# Called when the node enters the scene tree for the first time.

export var reset_location = "res://Stages/StickCity/Section 1.tscn"




func _ready():
#	Globals.incutscene = 1
#	$Rian/cameracutscene.play("intropan")
	#$AnimationPlayer.play("AutoplayTest")
	
	
	Globals.curstage = current_stage
	
	Globals.grooveList = [null, null, null, null, null]
	Globals.stuntList =[]
	Globals.grooveTimer = 0
	Globals.ded = 0
	Globals.hpcount = 5
	Globals.lives = 3
	Globals.score = 0
	Globals.pieces = 0
	Globals.moveenabled = canmove
	Globals.demoscene = demo
	Globals.incutscene = 0
	Globals.minute = 0
	Globals.sec = initialTime
	Globals.mili = 60
	if vidmode == 0:
		if Globals.windowmode == 1:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,Vector2(384,224),1)
		elif Globals.windowmode == 0:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,Vector2(320,224),1)
	elif vidmode == 1:
		if Globals.windowmode == 1:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,Vector2(384,224),1)
		elif Globals.windowmode == 0:
			get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,Vector2(320,224),1)
	Globals.combo = 0
	Globals.combotimer = 0
	Globals.link = 0
	Globals.linktimer = 0
	Globals.failedrank = false
	
	Globals.cur_scene = self
	print_debug("self set current scene!")
	
	Globals.stage_start = reset_location
	print_debug("self set stage start!")
	
	playmusic()
	
	match(current_stage):
		1:
			Switches.stg1complete = false
			Switches.YaibaDefeated = 0
			Switches.foresightdefeated = 0
	
	
	

func _physics_process(delta):
	#print_debug(Globals.atkmult)
#	if bossdefeated == 1:
#			$Rian/StageMusic.play()
#			$bossmus/bossmusic.stop()
	
	if skippable:
		if Input.is_action_just_pressed("pause"):
			loadnext()
	
	Globals.zoomallowed = zoomallowed
	
	print_debug(Globals.moveenabled)
	
	if Globals.ded == 1:
		
		
		if Globals.didakill == 1:
			bossdefeated = 1
		
		
			
		
		if done == 0:
			#if Globals.lives == 0:
			#	$Rian/StageMusic/musichandler.play("fadeout")
			#$Rian/Camera2D/CanvasLayer3/screenspr/Blackscreen.play("Fadeout")
			
			done = 1
			
		
	else:
		if done == 1:
			if Globals.ded == 0:
				done = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_NextArea_area_entered(area):
	if area.is_in_group("hurtbox"):
		Engine.time_scale = 1.0
		$Terrain.queue_free()
		$ParallaxBackground.queue_free()
		$Objects.queue_free()
		Sys.load_scene(self,next)
	pass # Replace with function body.


func loadnext():
	Engine.time_scale = 1.0
	Sys.load_scene(self,next)

func _on_Area2D_area_entered(area):
	pass # Replace with function body.


func playmusic():
		Globals.music.set_stream(musplay)
		Globals.music.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	
	pass # Replace with function body.
