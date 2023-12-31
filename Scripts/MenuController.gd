extends Control

func _on_start_button_pressed() -> void:
	$"../ButtonNoise".play()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_option_button_pressed() -> void:
	$"../ButtonNoise".play()
	$Options.visible = true
	$Buttons.visible = false
	$Title.visible = false

func _on_back_button_pressed():
	$"../ButtonNoise".play()
	$Store.visible = false
	$Options.visible = false
	$Buttons.visible = true
	$Title.visible = true
	$Credits.visible = false

func _on_store_button_pressed() -> void:
	$"../ButtonNoise".play()
	$Store.visible = true
	$Buttons.visible = false
	$Title.visible = false

func _on_quit_button_pressed() -> void:
	$"../ButtonNoise".play()
	Global.save_game()
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	$"../ButtonNoise".play()
	$Credits.visible = true
	$Buttons.visible = false
	$Title.visible = false
