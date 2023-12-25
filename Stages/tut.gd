extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done = 0

export var next = "Scene Path"

# Called when the node enters the scene tree for the first time.


export (AudioStream) var musplay


func _ready():
#	Globals.incutscene = 1
#	$Rian/cameracutscene.play("intropan")
#
	Globals.ded = 0
	Globals.hpcount = 5
	Globals.lives = 3
	Globals.score = 0
	Globals.pieces = 0
	Globals.moveenabled = 1
	Globals.incutscene = 0
	Globals.minute = 0
	Globals.sec = 0
	Globals.mili = 0
	
	Globals.combo = 0
	Globals.combotimer = 0
	Globals.link = 0
	Globals.linktimer = 0
	
	Globals.cur_scene = self
	
	if musplay != null:
		Globals.music.set_stream(musplay)
		Globals.music.play()

func _physics_process(delta):
	#print_debug(Globals.atkmult)
	if Globals.ded == 1:
		
		if done == 0:
			if Globals.lives == 0:
				$Rian/StageMusic/musichandler.play("fadeout")
			$Rian/Camera2D/CanvasLayer3/screenspr/Blackscreen.play("Fadeout")
			
			done = 1
			
		
	else:
		if done == 1:
			if Globals.ded == 0:
				done = 0
				
	if Input.is_action_just_pressed("next room"):
		Globals.music.stop()
		Sys.load_scene(self,next)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Blackscreen_animation_finished(anim_name):
	done = 1


func _on_cameracutscene_animation_finished(anim_name):
	Globals.incutscene = 0
	
	if anim_name == "intropan":
		pass
		
	if anim_name == "Yaibaintro":
		get_tree().change_scene("res://Stages/SC_B.tscn")
