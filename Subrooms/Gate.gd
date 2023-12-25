extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var requirement = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$neededText.needed = requirement
	$amountneeded.text = str(Globals.cards) + "/" + str(requirement)
	




func _on_gate_area_entered(area):
	if area.is_in_group("hurtbox"):
		Globals.gatereq = requirement
		if Globals.cards >= requirement:
			Globals.cards -= requirement
			$gate/AnimationPlayer.play("godown")
			Globals.gatereq = 0
			$amountneeded.visible = false
		else: 
			$gate/nono.play()
		
