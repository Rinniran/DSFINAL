extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done = 0

var bossdefeated = 0

# Called when the node enters the scene tree for the first time.





func _ready():
#	Globals.incutscene = 1
#	$Rian/cameracutscene.play("intropan")
#
#	Globals.ded = 0
#	Globals.hpcount = 5
#	Globals.lives = 3
#	Globals.pieces = 0
	Globals.checkpX = $Rian.position.x
	Globals.checkpY = $Rian.position.y
	
	
	
	

func _physics_process(delta):
	#print_debug(Globals.atkmult)
#	if bossdefeated == 1:
#			$Rian/StageMusic.play()
#			$bossmus/bossmusic.stop()
			
			
			
	if Globals.ded == 1:
		
		
		if Globals.didakill == 1:
			bossdefeated = 1
		
		
		
			
		
		if done == 0:
			if Globals.lives == 0:
				$Rian/StageMusic/musichandler.play("fadeout")
			$Rian/Camera2D/CanvasLayer3/screenspr/Blackscreen.play("Fadeout")
			
			done = 1
			
		
	else:
		if done == 1:
			if Globals.ded == 0:
				done = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Blackscreen_animation_finished(anim_name):
	done = 1


func _on_cameracutscene_animation_finished(anim_name):
	Globals.incutscene = 0
	
	if anim_name == "intropan":
		pass
		
	if anim_name == "Trainjump":
		get_tree().change_scene("res://Stages/SC_C.tscn")
