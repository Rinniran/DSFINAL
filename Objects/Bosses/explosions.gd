extends Node2D


var space = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seq(delta)
#	pass

func die(var whichone):
	match whichone:
		1:
			$exp.play("go")
		2:
			$exp2.play("go")
		3:
			$exp3.play("go")
		4:
			$exp4.play("go")
		5:
			$exp5.play("go")
		6:
			$exp6.play("go")
		7:
			$exp7.play("go")
		8:
			$exp8.play("go")
	


func spacetime(var time = 0, var do = 0):
	if time > 0:
		time -= 1
	if time <= 0:
		die(do)

func seq(delta):
	spacetime(50, 1)
	spacetime(50, 2)
	spacetime(50, 3)
	spacetime(50, 4)
	spacetime(50, 5)
	spacetime(50, 6)
	spacetime(50, 7)
	spacetime(50, 8)
	
