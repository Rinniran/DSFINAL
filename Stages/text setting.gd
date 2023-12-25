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
	
	if $timer.visible == true && Globals.ded == 0 && Globals.incutscene == 0:
		Globals.mili += 2
		if Globals.mili > 99:
			Globals.mili = 00
			Globals.sec += 1
		
		if Globals.sec > 59:
			Globals.sec = 0
			Globals.minute += 1
		if Globals.minute > 99:
			Globals.minute = 99
	$timer.text = "%02d:%02d.%02d" % [Globals.minute, Globals.sec, Globals.mili]
	#$fpscnt.text = "POWER: " + "%.2f" % [Globals.atkmult]
	$Piececnt.text = "%02d" % [Globals.pieces]
	$scorecnt.text = "%010d" % [Globals.score]
	$livescnt.text = "%02d" % [Globals.lives]
	$boltcnt.text = str(Globals.cards) + "/" + str(req)
	if $textbox.visible:
		$timer.visible = false
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
