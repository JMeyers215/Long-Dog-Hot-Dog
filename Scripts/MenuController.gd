extends Control

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_option_button_pressed() -> void:
	$Options.visible = true
	$Buttons.visible = false
	$Title.visible = false

func _on_back_button_pressed():
	$Store.visible = false
	$Options.visible = false
	$Buttons.visible = true
	$Title.visible = true

func _on_store_button_pressed() -> void:
	$Store.visible = true
	$Buttons.visible = false
	$Title.visible = false
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	Global.save_game()
	get_tree().quit()

