extends Control

@onready var dog_cat_button : CheckButton = get_node("OptionsPanel/DogCatToggle/CheckButton")

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if Global.is_cat_or_dog == "Cat":
		$OptionsPanel/DogCatToggle/CheckButton.set_pressed_no_signal(true)
	elif Global.is_cat_or_dog == "Dog":
		$OptionsPanel/DogCatToggle/CheckButton.set_pressed_no_signal(false)

func _on_check_button_toggled(toggled_on):
	if Global.is_cat_or_dog == "Dog":
		Global.is_cat_or_dog = "Cat"
	elif Global.is_cat_or_dog == "Cat":
		Global.is_cat_or_dog == "Dog"
