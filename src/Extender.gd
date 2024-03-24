extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("hurtbox") && $Sprite.frame == 0:
		Globals.player.dashmeter += 60
		Globals.player.dashes += 1
		$Sprite.frame = 1 
		$Timer.start()
	pass # Replace with function body.


func _on_Timer_timeout():
	$Sprite.frame = 0
	pass # Replace with function body.
