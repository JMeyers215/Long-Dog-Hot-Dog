extends Node

@onready var global_vars = get_node("/root/Global")

#score variables
var total_count : int = 0
var high_score : int = 0

#options variables
var dog_or_cat : String = "Dog"
var music_option : int = 1
var sound_option : int = 1

#defines the save path
const SAVE_PATH = "user://LDHD.json"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var json = JSON.new()
	if FileAccess.file_exists(SAVE_PATH):
		load_game()
	else:
		save_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func save_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	
	var global = get_node("/root/Global")
	
	var save_dict = {
		global = {
			total_count = int(total_count),
			high_score = int(high_score),
			dog_or_cat = str(dog_or_cat),
			music_option = int(music_option),
			sound_option = int(sound_option)
		}
	}
	
	file.store_line(JSON.stringify(save_dict))
	

func load_game():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var json := JSON.new()
	
	json.parse(file.get_line())
	
	var save_dict : Dictionary = json.get_data()
	
	var global := get_node("/root/Global") as Global

	global.total_count = int(save_dict.global.total_count)
	global.high_score = int(save_dict.global.high_score)
	global.dog_or_cat = str(save_dict.global.dog_or_cat)
	global.music_option = int(save_dict.global.music_option)
	global.sound_option = int(save_dict.global.sound_option)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()
		get_tree().quit()
