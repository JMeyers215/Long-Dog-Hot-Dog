extends Control

@onready var dog_cat_button : CheckButton = get_node("DogCatToggle/CheckButton")
func _ready() -> void:
	Global.dog_or_cat = true

func _on_check_button_toggled(toggled_on: bool) -> void:
	if dog_cat_button.button_pressed:
		Global.dog_or_cat = false
	else:
		Global.dog_or_cat = true

