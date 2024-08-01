extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var camdist = 20

export var camyoffset = 730

export var zoomoffset = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	texture = $Viewport.get_texture()
	
	$Viewport/Spatial/Camera.translation.x = Globals.camera.position.x / (camdist - (Globals.camera.zoom.y - 1 * 99))
	$Viewport/Spatial/Camera.translation.y = (Globals.camera.position.y - camyoffset) / (camdist - (Globals.camera.zoom.y - 1 * 99))
	#print_debug($Viewport/Spatial/Camera.translation.z)
	$Viewport/Spatial/Camera.translation.z = (Globals.camera.zoom.y - 1)
	$Viewport/Spatial/Camera.translation.z *= zoomoffset
#	pass
