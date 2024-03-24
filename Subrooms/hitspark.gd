extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var anim = rng.randi_range(1,4)

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	anim = rng.randi_range(1,4)
	frame = 0
	play(str(anim))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_hs_animation_finished():
	queue_free()
