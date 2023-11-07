extends Control

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int) -> void:
	if index == 0 or index == -1:
		Global.dog_or_cat = "Dog"
	elif index == 1:
		Global.dog_or_cat = "Cat"
	else :
		Global.dog_or_cat = "Dog"
