extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var destroyed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_debrisbreakable_area_entered(area):
	if area.is_in_group("BIGDAMAGE"):
		if destroyed == 0:
			$Sprite.visible = false
			$Sprite/Sprite2.visible = false
			$explosion.play("explode")
			$sound.play()
			$KinematicBody2D.queue_free()
			destroyed = 1
		


func _on_explosion_animation_finished():
	if $explosion.animation == "explode":
		queue_free()
