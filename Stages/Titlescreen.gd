extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#==================================================================
# LOGO TEXTURE VARIABLES
#==================================================================
var ENG = preload("res://Sprites/Misc/Dreamshock Logo Final.png")

var JP = preload("res://Sprites/Misc/Dreamshock Logo JP.png")
var nomore = 0
var secretact = 0

export var opt = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D,SceneTree.STRETCH_ASPECT_KEEP,Vector2(384,224),1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#==================================================================
	# START BUTTON VARIBLE
	#==================================================================
	
	var secret = Input.is_action_pressed("dash")
	
	
	
	
	if Globals.windowmode == 1:
		$DreamshockLogoGameVersion.position.x = 192
		$copyrightstuff.margin_right = 384
		$labels.position.x = -79
	if Globals.windowmode == 0:
		$DreamshockLogoGameVersion.position.x = 192 - 32
		$copyrightstuff.margin_right = 384 - 64
		$labels.position.x = -79 - 32
	
	#==================================================================
	# CHANGE LOGO TEXTURE BASED ON LANGUAGE SELECTION
	#==================================================================
	
	if Globals.lang == 0 || Globals.lang == 2 || Globals.lang == 3 || Globals.lang == 4:
		$DreamshockLogoGameVersion.texture = ENG
	
	if Globals.lang == 1:
		$DreamshockLogoGameVersion.texture = JP
	if secret:
		
		secretact = 1
		
		
	else:
		secretact = 0
	
	#==================================================================
	# START BUTTON STUFF (I need to make it so that I can't do it again once it's activated.)
	#==================================================================
	if $labels.visible == true:
		if nomore == 0:
			
			
			
			
			
			#==================================================================
			#   TO DO:
			
			#- Options, Extras, Challenges, X Story (in reverse order lol)
			#- Level Select Code (DONE)
			#- Splash Screen (DONE)
			#- Opening (This one can wait til later)
			#- Scene Transition (DONE)
			#- Map Select Menu
			#
			#
			#
			#==================================================================
			
			
			
			
			
			match(opt):
				
				0:
					$labels/startgame/alpha.play("alph")
					$labels/Training.modulate = Color(1, 1, 1, 0.8)
					$labels/options.modulate = Color(1, 1, 1, 0.8)
					$labels/extras.modulate = Color(1, 1, 1, 0.2)
					$labels/xstory.modulate = Color(1, 1, 1, 0.2)
					if Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("jump"):
						$Accept.play()
						$BGM.stop()
						$ColorRect/transition.play("changescreen")
						nomore = 1
				
				1:
					$labels/Training/alpha.play("alph")
					$labels/startgame.modulate = Color(1, 1, 1, 0.8)
					$labels/options.modulate = Color(1, 1, 1, 0.8)
					$labels/extras.modulate = Color(1, 1, 1, 0.2)
					$labels/xstory.modulate = Color(1, 1, 1, 0.2)
					if Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("jump"):
						$Accept.play()
						$BGM.stop()
						$ColorRect/transition.play("changescreen")
						nomore = 1
				
				2:
					$labels/xstory/alpha.play("alph")
					$labels/Training.modulate = Color(1, 1, 1, 0.8)
					$labels/options.modulate = Color(1, 1, 1, 0.8)
					$labels/extras.modulate = Color(1, 1, 1, 0.2)
					$labels/startgame.modulate = Color(1, 1, 1, 0.8)
				
				3:
					$labels/extras/alpha.play("alph")
					$labels/Training.modulate = Color(1, 1, 1, 0.8)
					$labels/startgame.modulate = Color(1, 1, 1, 0.8)
					$labels/options.modulate = Color(1, 1, 1, 0.8)
					$labels/xstory.modulate = Color(1, 1, 1, 0.2)
					
				4:
					$labels/options/alpha.play("alph")
					$labels/Training.modulate = Color(1, 1, 1, 0.8)
					$labels/startgame.modulate = Color(1, 1, 1, 0.8)
					$labels/extras.modulate = Color(1, 1, 1, 0.2)
					$labels/xstory.modulate = Color(1, 1, 1, 0.2)
					if Input.is_action_just_pressed("pause") || Input.is_action_just_pressed("jump"):
						$Accept.play()
						$BGM.stop()
						$ColorRect/transition.play("changescreen")
						nomore = 1
			
			
			
			#$BGM.stop()
				
			#	$ColorRect/transition.play("changescreen")
			#nomore = 1
		if Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("stickup"):
			opt -= 1
			if opt < 0:
				opt = 4
	
	
		if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("stickdown"):
			opt += 1
			if opt > 4:
				opt = 0
	
	
	
	
	Switches.YaibaDefeated = 0
	Switches.foresightdefeated = 0
#
#	pass


func _on_Accept_finished():
	#==================================================================
	# CHANGE SCENE AFTER START SOUND IS DONE
	#==================================================================
	pass


func _on_transition_animation_finished(anim_name):
	match(opt):
		0:
			if secretact:
				Sys.load_scene(self,"res://Subrooms/StgSelect.tscn")
			else:
				
				Sys.load_scene(self,"res://Subrooms/CharacterSelect.tscn")
				
		1:
			Sys.load_scene(self,"res://Stages/tut.tscn")
		4:
			Sys.load_scene(self,"res://Stages/Options.tscn")
	
	pass
