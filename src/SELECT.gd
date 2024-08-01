extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (AudioStream) var musplay


var opt = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_KEEP,Vector2(384,224),1)
	Globals.music.set_stream(musplay)
	Globals.music.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if $CHARSELECT.visible:
		
		
		match(opt):
			0:
				if Input.is_action_just_pressed("jump"):
					$AnimationPlayer.play("RianSelect")
	elif $TYPESELECT.visible:
		
		if Input.is_action_just_pressed("dash"):
			$AnimationPlayer.play("RianBack")
		elif Input.is_action_just_pressed("jump"):
			Sys.load_scene(self,"res://Stages/DEMO/How To Play.tscn")
			
		if Input.is_action_just_pressed("ui_up"):
			opt = 0
		if Input.is_action_just_pressed("ui_down"):
			opt = 1
		
		
		
		match(opt):
			0:
				$TYPESELECT/Cursor.position.y = 70
				Globals.type = "Simple"
			1:
				$TYPESELECT/Cursor.position.y = 160
				Globals.type = "Advanced"
#	pass
