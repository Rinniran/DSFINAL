extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var doit1 = 0

var doit2 = 0
var doit3 = 0
var doit4 = 0
var doit5 = 0
var doit6 = 0
var doit7 = 0
var doit8 = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid($Dialogue2):
		if $Dialogue2/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
	
	if is_instance_valid($Dialogue3):
		if $Dialogue3/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue3/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		
	if is_instance_valid($Dialogue4):
		if $Dialogue4/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue4/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue4/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
			
	if is_instance_valid($Dialogue5):
		if $Dialogue5/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue5/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue5/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
		if $Dialogue5/PlayDialogue.is_playing() && is_instance_valid($Dialogue4):
			$Dialogue4.queue_free()
		
	if is_instance_valid($Dialogue6):
		if $Dialogue6/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue6/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue6/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
		if $Dialogue6/PlayDialogue.is_playing() && is_instance_valid($Dialogue4):
			$Dialogue4.queue_free()
		if $Dialogue6/PlayDialogue.is_playing() && is_instance_valid($Dialogue5):
			$Dialogue5.queue_free()
		
	if is_instance_valid($Dialogue7):
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue4):
			$Dialogue4.queue_free()
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue5):
			$Dialogue5.queue_free()
		if $Dialogue7/PlayDialogue.is_playing() && is_instance_valid($Dialogue6):
			$Dialogue6.queue_free()
	
	if is_instance_valid($Dialogue8):
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue4):
			$Dialogue4.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue5):
			$Dialogue5.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue6):
			$Dialogue6.queue_free()
		if $Dialogue8/PlayDialogue.is_playing() && is_instance_valid($Dialogue7):
			$Dialogue7.queue_free()
		
	if is_instance_valid($Dialogue9):
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue1):
			$Dialogue1.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue2):
			$Dialogue2.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue3):
			$Dialogue3.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue4):
			$Dialogue4.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue5):
			$Dialogue5.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue6):
			$Dialogue6.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue7):
			$Dialogue7.queue_free()
		if $Dialogue9/PlayDialogue.is_playing() && is_instance_valid($Dialogue8):
			$Dialogue8.queue_free()

#	pass
