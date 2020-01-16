extends Button

onready var gui=get_node("..")

func _ready():
	pass # Replace with function body.

func _gui_input(event):#Most tutorials tells to use _input(event) but is trigger on any input event on every
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
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
		print("Yes")