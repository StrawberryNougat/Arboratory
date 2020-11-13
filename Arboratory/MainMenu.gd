extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().find_node("Main Menu Theme",true,false).play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	if PauseMenu.gameContinue == true:
		PauseMenu.gameContinue = false
	get_tree().get_root().find_node("Main Menu Theme",true,false).stop()
	get_tree().change_scene("res://Planting.tscn") # Replace with function body.


func _on_VolumeButton_pressed():
	get_tree().change_scene("res://VolumeControl.tscn") # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://Credits.tscn") # Replace with function body.
