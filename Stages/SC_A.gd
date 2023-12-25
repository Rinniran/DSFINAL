extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var done = 0

# Called when the node enters the scene tree for the first time.





func _ready():
	Globals.incutscene = 0
	#$Rian/cameracutscene.play("intropan")
	
	Globals.ded = 0
	Globals.hpcount = 5
	Globals.lives = 3
	Globals.pieces = 0
	Globals.atkmult = 0
	Globals.minute = 0
	Globals.sec = 0
	Globals.mili = 0
	Globals.moveenabled = 1

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
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Blackscreen_animation_finished(anim_name):
	done = 1


func _on_cameracutscene_animation_finished(anim_name):
	Globals.incutscene = 0
	
	if anim_name == "intropan":
		Globals.checkpX = $Rian.position.x
		Globals.checkpY = $Rian.position.y
		$Rian/Camera2D/CanvasLayer3/BannerBlue.queue_free()
		$Rian/Camera2D/CanvasLayer3/BannerPink.queue_free()
		$Rian/Camera2D/CanvasLayer3/Sprite.queue_free()
		$Rian/Camera2D/CanvasLayer3/Stagetitle.queue_free()
		$Rian/Camera2D/CanvasLayer3/StageCard.queue_free()
	if anim_name == "Yaibaintro":
		get_tree().change_scene("res://Stages/SC_B.tscn")


