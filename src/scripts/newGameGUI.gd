extends Control

onready var list1=get_node('char1classList')
onready var list2=get_node('char2classList')
onready var list3=get_node('char3classList')
onready var list4=get_node('char4classList')
onready var list5=get_node('char5classList')
onready var list6=get_node('gender1')
onready var list7=get_node('gender2')
onready var list8=get_node('gender3')
onready var list9=get_node('gender4')
onready var list10=get_node('gender5')

onready var theButton=get_node("Button")

func _ready():
	var classList=get_node('..').classList
	for i in range(classList.size()):
		list1.add_item(classList[i],null,true)
		list2.add_item(classList[i],null,true)
		list3.add_item(classList[i],null,true)
		list4.add_item(classList[i],null,true)
		list5.add_item(classList[i],null,true)
	
	list6.add_item("Male",null,true)
	list6.add_item("Female",null,true)
	list7.add_item("Male",null,true)
	list7.add_item("Female",null,true)
	list8.add_item("Male",null,true)
	list8.add_item("Female",null,true)
	list9.add_item("Male",null,true)
	list9.add_item("Female",null,true)
	list10.add_item("Male",null,true)
	list10.add_item("Female",null,true)
