extends Control

@export var gamemanager : Node

func _on_title_button_pressed() -> void:
	if gamemanager.score_count > Global.high_score :
		Global.high_score = gamemanager.score_count
	Global.total_count += gamemanager.collection_amt
	
	Global.save_game()
	get_tree().change_scene_to_file("res://Scenes/start.tscn")

func _on_quit_button_pressed() -> void:
	if gamemanager.score_count > Global.high_score :
		Global.high_score = gamemanager.score_count
	Global.total_count += gamemanager.collection_amt
	
	Global.save_game()
	get_tree().quit()
