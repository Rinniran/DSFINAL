extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hp1 = preload("res://Sprites/gui/Healthicon1.png")
var hp2 = preload("res://Sprites/gui/Healthicon2.png")
var hp3 = preload("res://Sprites/gui/Healthicon3.png")
var hp4 = preload("res://Sprites/gui/Healthicon4.png")
var hp5 = preload("res://Sprites/gui/Healthicon5.png")
var hp6 = preload("res://Sprites/gui/Healthicon6.png")
#very stumped.....
#var rianHealth = get_node("Rian").get("hp")

#improtant note for later: node ref not working >:|

#i'm just gonna come back to this later to save myself the headache

onready var thisnode = NodePath("Rian/Camera/GUI/hpico")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.



func _physics_process(delta):
	
	
	if Globals.hpcount >= 5:
		self.set_texture(hp1)

	if Globals.hpcount == 4:
		self.set_texture(hp2)

	if Globals.hpcount == 3:
		self.set_texture(hp3)

	if Globals.hpcount == 2:
		self.set_texture(hp4)

	if Globals.hpcount == 1:
		self.set_texture(hp5)

	if Globals.hpcount <= 0:
		self.set_texture(hp6)
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
