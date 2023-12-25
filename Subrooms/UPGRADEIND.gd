extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var norm = preload("res://Sprites/gui/SPEEDUP.png")
var alt = preload("res://Sprites/gui/MAXPOW.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Globals.atkmult == 5:
		texture = alt
	else:
		texture = norm


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
		
		
	position.y -= 1.5


func _on_lifespan_timeout():
	queue_free()
