extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_pressed("ui_accept"):#Godot have grouped some keypresses together. ui_accept is on gamepads the start button and on keyboards space and enter.
		get_tree().change_scene("res://Game.tscn")
