extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var texture = $Viewport.get_texture()
	$screen.texture = texture


func _on_kcard_area_entered(area):
	if area.is_in_group("hurtbox") && $collectspr.animation != "get":
		Globals.hpcount += 3
		$screen.visible = false
		$collect.play()
		$collectspr.play("get")
		





func _on_collect_finished():
	pass


func _on_collectspr_animation_finished():
	if $collectspr.animation == "get":
		$collectspr.visible = false
		queue_free()
