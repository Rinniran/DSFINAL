extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Fscreen = false

var Wsize

var MASTERVOL = 2

var BGMVOL = 8

var SFXVOL = 6

var VOICEVOL = 8

var FLASHYVIS = "ON"

var MUSPAUSE = "ON"

var SHADER = "HIGH"

var CRT = "ON"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.

func _process(delta):
	if Fscreen == true:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
		
	if Wsize == 1:
		Globals.set("display/width",768)
		Globals.set("display/height",432)
		OS.window_fullscreen = false
	if Wsize == 2:
		Globals.set("display/width",768 * 2)
		Globals.set("display/height",432 * 2)
		OS.window_fullscreen = false
	if Wsize == 3:
		Globals.set("display/width",768 * 3)
		Globals.set("display/height",432 * 3)
		OS.window_fullscreen = false
	if Wsize == 4:
		Globals.set("display/width",768)
		Globals.set("display/height",432)
		OS.window_fullscreen = true
		
	if MASTERVOL == 8:
		AudioServer.set_bus_volume_db(0,-2)
	if MASTERVOL == 7:
		AudioServer.set_bus_volume_db(0,-4)
	if MASTERVOL == 6:
		AudioServer.set_bus_volume_db(0,-6)
	if MASTERVOL == 5:
		AudioServer.set_bus_volume_db(0,-8)
	if MASTERVOL == 4:
		AudioServer.set_bus_volume_db(0,-10)
	if MASTERVOL == 3:
		AudioServer.set_bus_volume_db(0,-12)
	if MASTERVOL == 2:
		AudioServer.set_bus_volume_db(0,-16)
	if MASTERVOL == 1:
		AudioServer.set_bus_volume_db(0,-24)
	if MASTERVOL == 0:
		AudioServer.set_bus_mute(0, true)
	else:
		 AudioServer.set_bus_mute(0,false)
		
	if BGMVOL == 8:
		AudioServer.set_bus_volume_db(1,-2)
	if BGMVOL == 7:
		AudioServer.set_bus_volume_db(1,-4)
	if BGMVOL == 6:
		AudioServer.set_bus_volume_db(1,-6)
	if BGMVOL == 5:
		AudioServer.set_bus_volume_db(1,-8)
	if BGMVOL == 4:
		AudioServer.set_bus_volume_db(1,-10)
	if BGMVOL == 3:
		AudioServer.set_bus_volume_db(1,-12)
	if BGMVOL == 2:
		AudioServer.set_bus_volume_db(1,-16)
	if BGMVOL == 1:
		AudioServer.set_bus_volume_db(1,-24)
	if BGMVOL == 0:
		AudioServer.set_bus_mute(1, true)
	else:
		 AudioServer.set_bus_mute(1,false)
		
	if SFXVOL == 8:
		AudioServer.set_bus_volume_db(2,-2)
	if SFXVOL == 7:
		AudioServer.set_bus_volume_db(2,-4)
	if SFXVOL == 6:
		AudioServer.set_bus_volume_db(2,-6)
	if SFXVOL == 5:
		AudioServer.set_bus_volume_db(2,-8)
	if SFXVOL == 4:
		AudioServer.set_bus_volume_db(2,-10)
	if SFXVOL == 3:
		AudioServer.set_bus_volume_db(2,-12)
	if SFXVOL == 2:
		AudioServer.set_bus_volume_db(2,-16)
	if SFXVOL == 1:
		AudioServer.set_bus_volume_db(2,-24)
	if SFXVOL == 0:
		AudioServer.set_bus_mute(2, true)
	else:
		 AudioServer.set_bus_mute(2,false)
		
	if VOICEVOL == 8:
		AudioServer.set_bus_volume_db(3,-2)
	if VOICEVOL == 7:
		AudioServer.set_bus_volume_db(3,-4)
	if VOICEVOL == 6:
		AudioServer.set_bus_volume_db(3,-6)
	if VOICEVOL == 5:
		AudioServer.set_bus_volume_db(3,-8)
	if VOICEVOL == 4:
		AudioServer.set_bus_volume_db(3,-10)
	if VOICEVOL == 3:
		AudioServer.set_bus_volume_db(3,-12)
	if VOICEVOL == 2:
		AudioServer.set_bus_volume_db(3,-16)
	if VOICEVOL == 1:
		AudioServer.set_bus_volume_db(3,-24)
	if VOICEVOL == 0:
		AudioServer.set_bus_mute(3, true)
	else:
		 AudioServer.set_bus_mute(3,false)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
