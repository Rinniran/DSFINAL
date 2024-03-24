extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var hpcount = 5
var hpmax = 5
var pieces = 0
var lives = 3
var cards = 0
var bolts = 0
var moveenabled = 0
var ded = 0
var visibox
var cantalk = false
var text = 0
var txt 
var incutscene = 0
var demoscene = 1
var checkpX
var checkpY
var continused = 0
var continues = 3
var hasdied = 0
var hascompleted = 0
var combo = 0
var maxcombo = 999
var atkmult
var atkmultmax
var atkmultdoubler
var ishyper = 0
var canthurt = 0
var camblock = 0
var didakill = 0
var score = 0
var stagescore = 0
var gatereq = 0
var stylebonus = 0
var mili = 00
var sec = 00
var minute = 00

var hinttext = 0

var playerpos

var flash = 1

var combotimer = 0
var linktimer = 0

var link = 0

var camera = null

var paused = 0

var dietime = 120
var sound_to_play
var soundtype #0 = sound 1 = voice 2 = music 3 = BGS

var lang = 0
 #0 = english 1 = japanese 2 = spanish 3 = portugese 4 = french

var superdashget = 0

var spawn_active = 0

var dodged = false

var player

var playerspriteflip = false


var diff = 2

var cur_scene = null

var stage_start = null

var inputmode = "kb"

#Boss Triggers================================================
var yokaiball = 0
var balldestroy = 0
export (AudioStream) var mus
var music = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			inputmode = "kb"
			#print_debug(inputmode)
	elif event is InputEventJoypadButton:
		if event.pressed:
			inputmode = "joy"
			#print_debug(inputmode)

func _init():
	atkmult = 0.00
	music.set_stream(mus)
	music.volume_db = 1
	music.pitch_scale = 1
	music.play()
	add_child(music)
	
	combotimer = 0
	OS.window_size = Vector2(768, 432)
	pass # Replace with function body.

func _physics_process(delta):
	print(combotimer)
	
	
	if Engine.time_scale < 1.0:
		#AudioServer.set_bus_effect_enabled(3,1,true)
		if dodged == true && Settings.MUSPAUSE == "ON":
			music.stream_paused = 1
			AudioServer.set_bus_effect_enabled(0,1,true)
	else:
		#AudioServer.set_bus_effect_enabled(3,1,false)
		dodged = false
		AudioServer.set_bus_effect_enabled(0,1,false)
		music.stream_paused = 0
	
	
	var alt = Input.is_action_just_pressed("but_alt")
	var pause = Input.is_action_just_pressed("but_pause")
	
	if alt:
		Settings.Fscreen = !Settings.Fscreen
		
	
	
	
	#========= HIDE MOUSE ==========
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	#===============================
	
	
	
	
	
	
	if ded && lives == 0:
		music.stop()
		if dietime > 0:
			dietime -= 1
		if dietime <= 0:
			get_tree().change_scene("res://Stages/Titlescreen.tscn")
			hpcount = 5
			pieces = 0
			lives = 3
			ded = 0
			mili = 00
			sec = 00
			minute = 00
			score = 0
			dietime = 120
	
	
	if ishyper:
		atkmultmax = 10
	else:
		atkmultmax = 5
	
	
	if hpcount > hpmax:
		hpcount = hpmax
	
	
	if atkmult > atkmultmax:
		atkmult = atkmultmax
	
	if combotimer > 0:
		combotimer -= 1
	else:
		if combo < 9 && combo != 0:
			score += 100
			combo = 0
		if combo < 29 && combo != 0:
			score += 1000
			combo = 0
		if combo < 49 && combo != 0:
			score += 11800
			combo = 0
		if combo < 79 && combo != 0:
			score += 95000
			combo = 0
		if combo < 99 && combo != 0:
			score += 150000
			combo = 0
		if combo < 149 && combo != 0:
			score += 1600000
			combo = 0
		if combo >= 150 && combo != 0:
			score += 1000000
			combo = 0
		
	
	if linktimer > 0:
		linktimer -= 1
	else:
		if link < 9 && link != 0:
			score += 50
			link = 0
		if link < 29 && link != 0:
			score += 500
			link = 0
		if link < 49 && link != 0:
			score += 10000
			link = 0
		if link < 79 && link != 0:
			score += 50000
			link = 0
		if link < 99 && link != 0:
			score += 100000
			link = 0
		if link < 149 && link != 0:
			score += 300000
			link = 0
		if link >= 150 && link != 0:
			score += 800000
			link = 0
	
	
	if text == 0:
		txt = "?"
	if text == 1:
		if lang == 0:
			txt = "What's happening?! \neverything was normal just moments ago..."
		if lang == 1:
			txt = "何が起こっていますか？ \nしばらく前まではすべて順調でした！"
		if lang == 2:
			txt = "¡¿Que esta pasando?! \ntodo era normal hace unos momentos..."
		if lang == 3:
			txt = "E aí?! \nTudo estava normal momentos atrás..."
		if lang == 4:
			txt = "Ce qui se passe?! \ntout était normal il y a quelques instants..."
		
	if text == 2:
		if lang == 0:
			txt = "Don't blow my cover! \nI'm just gonna hide here 'til they go away!"
			
		if lang == 1:
			txt = "ねえ、彼らがあなたを得る前に、 \nあなたは隠れ場所を見つけるべきです！"
			
		if lang == 2:
			txt = "¡No arruines mi tapadera! \n¡Me esconderé aquí hasta que se vayan!"
			
		if lang == 3:
			txt = "Não estrague meu disfarce! \nVou me esconder aqui até eles irem embora!"
			
		if lang == 4:
			txt = "Ne fais pas exploser ma couverture ! \nJe me cacherai ici jusqu'à ce qu'ils soient partis !"
		
	if text == 3:
		if lang == 0:
			txt = "zzz..."
			
		if lang == 1:
			txt = "グーグー..."
			
		if lang == 2:
			txt = " Ron pchi...."
			
		if lang == 3:
			txt = "zzz..."
			
		if lang == 4:
			txt = "Ron pchi..."
		
		
	if text == 4:
		if lang == 0:
			txt = "Rian! You're going after them alone?! \nBut you've never been to the outside before!"
		if lang == 1:
			txt = "雄大！ あなたは彼らを一人で追いかけているのですか？！ \nしかし、 あなたはこれまで外に行ったことがありません！"
		if lang == 2:
			txt = "¡Rian! ¡¿Vas tras ellos solo?! \n¡Pero nunca antes has estado afuera!"
		if lang == 3:
			txt = "Rian! Você está perseguindo-os sozinho? \nVocê nunca esteve fora da cidade!"
		if lang == 4:
			txt = "Rian ! Tu les poursuis seul ?! \nMais tu n'es jamais sorti auparavant !"
	if text == 5:
		txt = "You'll never take me alive! AAAAAAAAA"
		
	if text == 6:
		txt = "I'm too amazing to be scared!"
		
	if text == 7:
		txt = "What's happening?! everything was normal just moments ago!"
		
	if text == 8:
		txt = "What's happening?! everything was normal just moments ago!"
		
		
	if combo > maxcombo:
		combo = maxcombo
	
	var htxt
	
	if hinttext == 0:
		htxt = "You can do a dash! It can be used on the ground or in the air to dodge attacks!"
	
	if hinttext == 1:
		htxt = "Chasers are very formidable indeed! Don't let them touch you and maneuver around them"
	
	if hinttext == 2:
		htxt = "hear a high pitched noise? Be alert! Someone's spotted you!"
		
	
	
	
	pass

func register_player(in_player):
	player = in_player

func play_audio(soundtype, sound_to_play):
	
	var audioplayer = AudioStreamPlayer.new()
	
	if soundtype == 0:
		audioplayer.set_bus("SFX")
	if soundtype == 1:
		audioplayer.set_bus("Voices")
	if soundtype == 2:
		audioplayer.set_bus("BGM")
	if soundtype == 3:
		audioplayer.set_bus("BGS")
	
	var stream = load(sound_to_play)
	audioplayer.set_stream(stream)
	audioplayer.volume_db = 1
	audioplayer.pitch_scale = 1
	audioplayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
