extends Camera

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var distance = 5.0
var sensitivity = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.player != null:
		# Orbit around the Globals.player based on input
		var input_rotation = -Input.get_action_strength("look_horizontal")
		rotate_y(deg2rad(input_rotation * sensitivity))
		
		# Update the camera position based on the Globals.player's position and rotation
		var player_transform = Globals.player.global_transform.origin
		var player_rotation = Globals.player.global_transform.basis.get_euler()
		
		var new_rotation = rotation_degrees
		new_rotation.x = clamp(new_rotation.x, -80, 80)  # Limit vertical rotation
		
		var orbit_transform = Transform(Basis(new_rotation), player_transform)
		var offset = orbit_transform.xform(Vector3(0, 0, distance))
		
		global_transform.origin = player_transform + offset
