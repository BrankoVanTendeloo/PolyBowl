extends Control

@onready var BowlingButton = $Sports/BowlingButton
@onready var QuitButton = $Sports/QuitButton

func _ready() -> void:
	BowlingButton.grab_focus()


### Button presses

func _on_bowling_button_pressed() -> void:
	print("LOADING BOWLING SCENE")
	get_tree().change_scene_to_file("res://Scenes/3D/bowling.tscn")

func _on_quit_button_pressed() -> void:
	print("QUITTING PROGRAM...")
	get_tree().quit()


### Button focus grabbers

func _on_bowling_button_mouse_entered() -> void:
	BowlingButton.grab_focus()

func _on_quit_button_mouse_entered() -> void:
	QuitButton.grab_focus()
