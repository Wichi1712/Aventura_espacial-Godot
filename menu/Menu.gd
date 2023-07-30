extends Control

func _ready():
	OS.center_window()

func _on_startButton_pressed():
	get_tree().change_scene("res://main/Main.tscn")
