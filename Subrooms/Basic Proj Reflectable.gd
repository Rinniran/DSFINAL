extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sp = 650
var speed
var grazecnt = 0
var mode = 1

func _ready():
	speed = sp * scale.x

func _process(delta):
	
	
	
	if mode == 1:
		position += transform.x * speed * delta
	if mode == 1.5:
		position += transform.x * speed * delta
		position += transform.y * -25 * delta
		
	if mode == 2:
		position += transform.x * speed * delta
		position += transform.y * 50 * delta
		
	if mode == 3:
		position += transform.x * speed * delta
		position += transform.y * -50 * delta
		
	if mode == 4:
		position += transform.x * speed * delta
		
	if mode == 5:
		position += transform.x * speed * delta

func _on_BulletReg_body_entered(body):
	if body.is_in_group("hurtbox"):
		grazecnt += 1
		#Give the player an Achievement at around 10 - 20!
		body.queue_free()
	queue_free()
func _on_kill_timeout():
	
	queue_free()




func _on_BulletNoDodge_area_entered(area):
	if area.is_in_group("hit1") || area.is_in_group("hit2") || area.is_in_group("hit3") || area.is_in_group("slash") || area.is_in_group("airhit") || area.is_in_group("BIGDAMAGE"):
		speed = -speed
	pass # Replace with function body.
