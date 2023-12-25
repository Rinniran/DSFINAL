extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).


var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
#	if Globals.camblock == 1:
#		$noleavetilldone/CollisionShape2D.disabled = false
#		$noleavetilldone/CollisionShape2D2.disabled = false
#		$noleavetilldone/CollisionShape2D3.disabled = false
#	else:
#		$noleavetilldone/CollisionShape2D.disabled = true
#		$noleavetilldone/CollisionShape2D2.disabled = true
#		$noleavetilldone/CollisionShape2D3.disabled = true
	
	$CG.position = position
#	pass
