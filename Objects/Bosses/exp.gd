extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sound = AudioStreamPlayer.new()
var snd = preload("res://Audio/SE/ForesightExp1.ogg")

# Called when the node enters the scene tree for the first time.
func _ready():
	sound.stream = snd
	add_child(sound)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animation == "go" && !sound.is_playing() && is_instance_valid(sound):
		sound.stop()
		sound.play()
#	pass
