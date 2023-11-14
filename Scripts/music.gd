extends AudioStreamPlayer

@onready var music_control = get_node("/root/MusicPlayer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()
	music_control.stream.loop = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
