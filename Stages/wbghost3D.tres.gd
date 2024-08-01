extends Sprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var mode = 0
var col
# Called when the node enters the scene tree for the first time.
func _ready():
	if mode == 0:
		$alpha_tween.interpolate_property(self, "modulate", Color(0.9,0,0,1), Color(0.9,0,0,0), .3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	if mode == 1:
		$alpha_tween.interpolate_property(self, "modulate", Color(0.9,0,0,1), Color(0,0,1,0), .3, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
	$alpha_tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if mode == 0:
		col = Color(0,0.8,1,1)
	if mode == 1:
		col = Color(0.9,0,0,1)
#	pass


func _on_alpha_tween_tween_completed(object, key):
	queue_free()
