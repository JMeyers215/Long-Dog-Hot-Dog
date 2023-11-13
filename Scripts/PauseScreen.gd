extends Control


func _on_title_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start.tscn")

func _on_quit_button_pressed() -> void:
	Global.save_game()
	get_tree().quit()
