extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var end = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	stop()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Globals.yokaiball == 1:
		if current_animation != "start":
			current_animation = "start"
	if Globals.balldestroy == 1:
		if current_animation != "victory":
			current_animation = "victory"
		
		
		
		
#	pass


