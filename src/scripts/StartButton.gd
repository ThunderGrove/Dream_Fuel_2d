extends Button

onready var gui=get_node("..")#gets script attached to parrent node
onready var game=get_node("../..")#gets script attached to parrent node of the parrent node

func _ready():
	pass # Replace with function body.

func _gui_input(event):#Most tutorials tells to use _input(event) but _input(event) gets trigger on any input event on every GUI element
	if event is InputEventMouseButton and event.button_index==BUTTON_LEFT and event.is_pressed():
		onclick()

func onclick():
	if !gui.get_node("char1classList").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("char2classList").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("char3classList").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("char4classList").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("char5classList").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("gender1").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("gender2").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("gender3").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("gender4").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	elif !gui.get_node("gender5").is_anything_selected():
		gui.get_node("BadUIaudio").play(0)
	else:
		game.team[0]["cname"]=gui.get_node("LineEdit1").text
		game.team[1]["cname"]=gui.get_node("LineEdit2").text
		game.team[2]["cname"]=gui.get_node("LineEdit3").text
		game.team[3]["cname"]=gui.get_node("LineEdit4").text
		game.team[4]["cname"]=gui.get_node("LineEdit5").text
		
		var temp=gui.get_node("char1classList").get_selected_items()
		game.team[0]["cclass"]=temp[0]
		temp=gui.get_node("char2classList").get_selected_items()
		game.team[1]["cclass"]=temp[0]
		temp=gui.get_node("char3classList").get_selected_items()
		game.team[2]["cclass"]=temp[0]
		temp=gui.get_node("char4classList").get_selected_items()
		game.team[3]["cclass"]=temp[0]
		temp=gui.get_node("char5classList").get_selected_items()
		game.team[4]["cclass"]=temp[0]
		
		temp=gui.get_node("gender1").get_selected_items()
		game.team[0]["gender"]=temp[0]
		temp=gui.get_node("gender2").get_selected_items()
		game.team[1]["gender"]=temp[0]
		temp=gui.get_node("gender3").get_selected_items()
		game.team[2]["gender"]=temp[0]
		temp=gui.get_node("gender4").get_selected_items()
		game.team[3]["gender"]=temp[0]
		temp=gui.get_node("gender5").get_selected_items()
		game.team[4]["gender"]=temp[0]
		
		game.calculate_stats(0)
		game.calculate_stats(1)
		game.calculate_stats(2)
		game.calculate_stats(3)
		game.calculate_stats(4)
		
		game.team[0]["hp"]=game.team[0]["hp_max"]
		game.team[1]["hp"]=game.team[1]["hp_max"]
		game.team[2]["hp"]=game.team[2]["hp_max"]
		game.team[3]["hp"]=game.team[3]["hp_max"]
		game.team[4]["hp"]=game.team[4]["hp_max"]
		
		gui.visible=false
		get_node("../../playField/player/Camera2D").current=true
		get_node("../../playField/player").moveLock=false
		#print(temp[0])
