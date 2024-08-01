extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mili = 00
var sec = 00
var minute = 00

var req



# Called when the node enters the scene tree for the first time.
# _ready():

func _physics_process(delta):
	#=============WIDESCREEN===========
	if Globals.windowmode == 1:
		$GUI/Piececnt2.position = Vector2(-11.38, 13.983)
		$GUI/hpico.position = Vector2(328.12, 28.483)
		$GUI/HudCircle.position = Vector2(326.12, 28.483)
		$GUI/AnimatedSprite.position = Vector2(-6.38, 208.98)
		$GUI/ChainCnt.position = Vector2(334.62, 119.982)
		$GUI/LinkCnt.position = Vector2(427.62, 212.98)
		$livescnt.rect_position = Vector2(27, 208)
		$scorecnt.rect_position = Vector2(24, 208)
		$Piececnt.rect_position = Vector2(19, 11)
		$boltcnt.rect_position = Vector2(87, 208)
	
	#=============STANDARD===========
	
	elif Globals.windowmode == 0:
		$GUI/Piececnt2.position = Vector2(-11.38, 13.983)
		$GUI/hpico.position = Vector2(261.12, 28.483)
		$GUI/HudCircle.position = Vector2(261.12, 28.483)
		$GUI/AnimatedSprite.position = Vector2(-6.38, 208.98)
		$GUI/ChainCnt.position = Vector2(278.62, 119.982)
		$GUI/LinkCnt.position = Vector2(427.62, 212.98)
		$livescnt.rect_position = Vector2(26.844, 208)
		$scorecnt.rect_position = Vector2(26.899, 208)
		$Piececnt.rect_position = Vector2(19.827, 11)
		$boltcnt.rect_position = Vector2(87, 208)
		$timer.rect_position = Vector2(1, 1.2)
	
	var deb1 = Input.is_action_just_pressed("hpdown")
	
	match(Settings.SHADER):
		"HIGH":
			$ColorRect2.visible = true
			$ColorRect3.visible = true
		"MED":
			$ColorRect2.visible = false
			$ColorRect3.visible = true
		"LOW":
			$ColorRect2.visible = false
			$ColorRect3.visible = false
	
	
	if Globals.dodged == true && Settings.FLASHYVIS == "ON":
		$ColorRect.visible = true
	else:
		$ColorRect.visible = false
	
	if Globals.gatereq == 0:
		req = "?"
	else:
		req = str(Globals.gatereq)
	
	
	if deb1:
		$textbox.visible = !$textbox.visible
	
	if $textbox.visible == true:
		Globals.moveenabled = 0
		$timer.visible = false
	else:
		Globals.moveenabled = 1
		$timer.visible = true
		
	
	$GUI/HudCircle.rotation_degrees += 0.2
	
	#if $timer.visible == true && Globals.ded == 0 && Globals.incutscene == 0:
		#Globals.mili += 2
#		if Globals.mili > 99:
#			Globals.mili = 00
#			Globals.sec += 1
#
#		if Globals.sec > 59:
#			Globals.sec = 0
#			Globals.minute += 1
#		if Globals.minute > 99:
#			Globals.minute = 99
	$timer.text = str(Globals.sec)
	#$fpscnt.text = "POWER: " + "%.2f" % [Globals.atkmult]
	$Piececnt.text = "%02d" % [Globals.pieces]
	$scorecnt.text = "%010d" % [Globals.score]
	$livescnt.text = "%02d" % [Globals.lives]
	$boltcnt.text = str(Globals.cards) + "/" + str(req)
	if $textbox.visible:
		$GUI/ViewportContainer/Viewport/timer.visible = false
		$textbox/tex.text = Globals.txt
		
		if $textbox/tex.text == null:
			Globals.text = 1
			
	#else:
		#$timer.visible = true
	
	if Globals.incutscene == 1:
		$timer.visible = false
	#else:
		#$timer.visible = true
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
