extends Control

@export var CharacterOptions : OptionButton
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Global.dog_or_cat == "Dog":
		CharacterOptions.select(0)
	elif Global.dog_or_cat == "Cat":
		CharacterOptions.select(1)

func _on_option_button_item_selected(index: int) -> void:
	if index == 0 or index == -1:
		Global.dog_or_cat = "Dog"
	elif index == 1:
		Global.dog_or_cat = "Cat"
	else :
		Global.dog_or_cat = "Dog"
