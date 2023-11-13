extends Control

@export var CharacterOptions : OptionButton

var bus_name : String

var bus_index : int

func _ready() -> void:
	$OptionsPanel/SoundOptions/MusicSlider.value = Global.music_option
	$OptionsPanel/SoundOptions/SoundSlider.value = Global.sound_option

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
