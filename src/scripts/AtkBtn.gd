extends Button

onready var combat=get_node("../../..")

func _onready():
	get_node(".").connect("pressed",self,"onclick")

func _gui_input(event):#Most tutorials tells to use _input(event) but _input(event) gets trigger on any input event on every GUI element
	if combat.waitingforturn>-1 and combat.actionId<0:
		if event is InputEventMouseButton and event.button_index==BUTTON_LEFT and event.is_pressed():
			onclick()

func onclick():
	if combat.get_node("Background/EnemyList").is_anything_selected():
		combat.actionId=0