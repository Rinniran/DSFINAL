extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var select = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		$MASTER.text = str("MASTER: ") + str(Settings.MASTERVOL)
		
		$BGM.text = str("BGM: ") + str(Settings.BGMVOL)
		
		$SFX.text = str("SFX: ") + str(Settings.SFXVOL)
		
		$VOICE.text = str("VOICE: ") + str(Settings.VOICEVOL)
		
		if Input.is_action_just_pressed("ui_down"):
			select += 1
			if select > 4:
				select = 0
		
		if Input.is_action_just_pressed("ui_up"):
			select -= 1
			if select < 0:
				select = 4
		
		
		
		match(select):
			0:
				$Cursor.position.x = 186.125
				$Cursor.position.y = 39
				if Input.is_action_just_pressed("ui_left") && Settings.MASTERVOL > 0:
					Settings.MASTERVOL -= 1
				if Input.is_action_just_pressed("ui_right") && Settings.MASTERVOL < 5:
					Settings.MASTERVOL += 1
			1:
				$Cursor.position.x = 186.125
				$Cursor.position.y = 92
				if Input.is_action_just_pressed("ui_left") && Settings.BGMVOL > 0:
					Settings.BGMVOL -= 1
				if Input.is_action_just_pressed("ui_right") && Settings.BGMVOL < 8:
					Settings.BGMVOL += 1
			2:
				$Cursor.position.x = 186.125
				$Cursor.position.y = 148
				if Input.is_action_just_pressed("ui_left") && Settings.SFXVOL > 0:
					Settings.SFXVOL -= 1
				if Input.is_action_just_pressed("ui_right") && Settings.SFXVOL < 8:
					Settings.SFXVOL += 1
			
			3:
				$Cursor.position.x = 186.125
				$Cursor.position.y = 205
				if Input.is_action_just_pressed("ui_left") && Settings.VOICEVOL > 0:
					Settings.VOICEVOL -= 1
				if Input.is_action_just_pressed("ui_right") && Settings.VOICEVOL < 8:
					Settings.VOICEVOL += 1
			
			4:
				$Cursor.position.x = 186.125
				$Cursor.position.y = 406
				if Input.is_action_just_pressed("ui_left"):
					Settings.Fscreen = false
				if Input.is_action_just_pressed("ui_right"):
					Settings.Fscreen = true
		
		
		match(Settings.Fscreen):
			false:
				$resolution.text = str("VIDEO MODE: WINDOWED")
			true:
				$resolution.text = str("VIDEO MODE: FULLSCREEN")
	
	#	pass
