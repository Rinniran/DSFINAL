extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var speed1

export (float) var speed2

export (float) var speed3

export (float) var speed4

export (float) var speed5

export (float) var speed6

func _physics_process(delta):
	
	$ParallaxLayer.motion_offset.x += speed1
	
	$ParallaxLayer2.motion_offset.x += speed2
	
	$ParallaxLayer3.motion_offset.x += speed3
	
	$ParallaxLayer4.motion_offset.x += speed4
	
	$ParallaxLayer5.motion_offset.x += speed5
	
	$ParallaxLayer6.motion_offset.x += speed6
	
	$ParallaxLayer8.motion_offset.x += speed5
	
	$ParallaxLayer9.motion_offset.x += speed4
	
	$ParallaxLayer10.motion_offset.x += speed3
