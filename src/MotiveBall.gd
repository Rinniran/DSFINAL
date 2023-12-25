extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const mainbul = preload("res://Subrooms/Basic Proj.tscn")

var cooldown = 20

var coollimit = 20

var noshoot = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func dotherotate(var speed):
	$Ball/Gun.rotation += speed 
	$Ball/Gun2.rotation += speed 
	$Ball/Gun3.rotation += speed 
	$Ball/Gun4.rotation += speed 
	


func schuut():
#	var new_bullet = mainbul.instance()
	var new_bullet2 = mainbul.instance()
#	var new_bullet3 = mainbul.instance()
	var new_bullet4 = mainbul.instance()
	
#	new_bullet.position = $Ball/Gun/Position2D.global_position
#	new_bullet.rotation = $Ball/Gun.global_rotation - 14.15
		
	new_bullet2.position = $Ball/Gun2/Position2D.global_position
	new_bullet2.rotation = $Ball/Gun2.global_rotation - 14.15
		
#	new_bullet3.position = $Ball/Gun3/Position2D.global_position
#	new_bullet3.rotation = $Ball/Gun3.global_rotation - 14.15
		
	new_bullet4.position = $Ball/Gun4/Position2D.global_position
	new_bullet4.rotation = $Ball/Gun4.global_rotation - 14.15
		
	#get_parent().add_child(new_bullet)
	get_parent().add_child(new_bullet2)
	#get_parent().add_child(new_bullet3)
	get_parent().add_child(new_bullet4)
	$attacksnd.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if noshoot == 0:
		cooldown -= 1
		if $Ball.hp <= 0:
			dotherotate(0)
			noshoot = 1
	

	if cooldown <= 0:
		schuut()
		cooldown = coollimit
	
	
		
	if noshoot == 0:
		if $Ball.hp >= 50:
			dotherotate(0.01)
			coollimit = 50
		
		elif $Ball.hp >= 40:
			dotherotate(0.03)
			coollimit = 30
		
		elif $Ball.hp >= 30:
			dotherotate(0.05)
			coollimit = 10
			
		elif $Ball.hp <= 20 || $Ball.hp < 40:
			dotherotate(0.1)
			coollimit = 8
			
		elif $Ball.hp <= 10:
			dotherotate(0.15)
			coollimit = 5
			
		
