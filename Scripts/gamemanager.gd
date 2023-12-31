extends Node2D

var tilemap : TileMap
var longdog_body = [Vector2(8,7),Vector2(7,7),Vector2(6,7)]
var old_head_pos
var new_head
var longdog_direction = Vector2(1,0)
var add_hotdog : bool = false

var win_game_check : bool = false

var timer : Timer
#change to 0, and 2 for Dog// 3, and 5 for Cat
var longdog : int = 0
var hotdog : int = 2

#hat layer and hat variable
var hat : int = 4
var hat_id : int = -1

var hotdog_pos : Vector2

@export var score : Label
var score_count : int = 0

@export var coll_amt : Label
var collection_amt : int = 0

@export var high_score : Label
@export var total_dogs : Label

func _ready():
	if Global.equipped != hat_id:
		hat_id = Global.equipped
	
	$UIController/PauseScreen.visible = false
	
	if Global.dog_or_cat == "Dog":
		longdog = 0
		hotdog = 2
		$UIController/ScoreContainer/FishCount2.visible = false
		$UIController/ScoreContainer/FishCount.visible = false
		$UIController/ScoreContainer/DogCount2.visible = true
		$UIController/ScoreContainer/DogCount.visible = true
	elif Global.dog_or_cat == "Cat":
		longdog = 3
		hotdog = 5 
		$UIController/ScoreContainer/FishCount2.visible = true
		$UIController/ScoreContainer/FishCount.visible = true
		$UIController/ScoreContainer/DogCount2.visible = false
		$UIController/ScoreContainer/DogCount.visible = false
	
	old_head_pos = longdog_body[0]
	
	tilemap = $MainMap
	timer = get_node("MovementTick")
	hotdog_pos = place_hotdog()

func _physics_process(delta: float) -> void:
	check_game_over()
	body_check()
	high_score.text = str("High Score: ", int(Global.high_score))
	total_dogs.text = str(int(Global.total_count))
	
	if longdog_body.size() == 280:
		win_game()

func place_hotdog():
	randomize()
	var x = randi_range(3,22)
	var y = randi_range(1,14)
	return Vector2(x,y)

func draw_hotdog():
	$MainMap.set_cell(hotdog,Vector2(hotdog_pos.x,hotdog_pos.y), hotdog, Vector2(0,0))

func draw_longdog():
	for block_index in longdog_body.size():
		var block = longdog_body[block_index]
		if block_index == 0:
			var head_dir = relation2(longdog_body[0],longdog_body[1])
			if head_dir == "right":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(4,1))
			if head_dir == "left":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(3,0))
			if head_dir == "up":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(4,0))
			if head_dir == "down":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(3,1))
		elif block_index == longdog_body.size()-1:
			var tail_dir = relation2(longdog_body[-1], longdog_body[-2])
			if tail_dir == "right":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(6,1))
			if tail_dir == "left":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(7,1))
			if tail_dir == "up":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(5,1))
			if tail_dir == "down":
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(5,0))
		else:
			var prev_block = longdog_body[block_index + 1] - block
			var next_block = longdog_body[block_index - 1] - block
			if prev_block.x == next_block.x:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(2,1))
			if prev_block.y == next_block.y:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(2,0))
				
			if prev_block.x == -1 && next_block.y == -1 or next_block.x == -1 && prev_block.y == -1:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(1,1))
			if prev_block.x == -1 && next_block.y == 1 or next_block.x == -1 && prev_block.y == 1:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(1,0))
			if prev_block.x == 1 && next_block.y == -1 or next_block.x == 1 && prev_block.y == -1:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(0,1))
			if prev_block.x == 1 && next_block.y == 1 or next_block.x == 1 && prev_block.y == 1:
				$MainMap.set_cell(longdog,Vector2(block.x,block.y),longdog,Vector2(0,0))

func relation2(first_block:Vector2,second_block:Vector2):
	var block_relation = second_block - first_block
	if block_relation == Vector2(-1,0): return "left"
	if block_relation == Vector2(1,0): return "right"
	if block_relation == Vector2(0,1): return "down"
	if block_relation == Vector2(-0,-1): return "up"

func move_longdog():
	if add_hotdog:
		var body_copy = longdog_body.slice(0,longdog_body.size(), 1, false)
		new_head = body_copy[0] + longdog_direction
		old_head_pos = body_copy[0]
		body_copy.insert(0, new_head)
		delete_tiles(longdog)
		delete_tiles(hat)
		longdog_body = body_copy
		draw_hat()
		add_hotdog = false
	else:
		var body_copy = longdog_body.slice(0,longdog_body.size()-1, 1, false)
		new_head = body_copy[0] + longdog_direction
		old_head_pos = body_copy[0]
		body_copy.insert(0, new_head)
		delete_tiles(longdog)
		delete_tiles(hat)
		longdog_body = body_copy
		draw_hat()
	

func _on_movement_tick_timeout() -> void:
	draw_hotdog()
	move_longdog()
	draw_longdog()
	check_hotdog()
	add_score()

func body_check():
		var hotdog_x = hotdog_pos.x
		var hotdog_y = hotdog_pos.y
		for cell_index in longdog_body.size():
			var cell = longdog_body[cell_index]
			if hotdog_x == cell.x and hotdog_y == cell.y:
				delete_tiles(hotdog)
				hotdog_pos = place_hotdog()
				draw_hotdog()

func delete_tiles(id: int):
	var cells = $MainMap.get_used_cells_by_id(id)
	for cell in cells:
		$MainMap.set_cell(id,Vector2(cell.x,cell.y),id,Vector2(-1,-1))

func _input(event):
	if Input.is_action_just_pressed("move_f"):
		if not longdog_direction == Vector2(0,1) and not relation2(old_head_pos,new_head) == "down":
			longdog_direction = Vector2(0,-1)
	if Input.is_action_just_pressed("move_b"):
		if not longdog_direction == Vector2(0,-1) and not relation2(old_head_pos,new_head) == "up":
			longdog_direction = Vector2(0,1)
	if Input.is_action_just_pressed("move_r"):
		if not longdog_direction == Vector2(-1,0) and not relation2(old_head_pos,new_head) == "left":
			longdog_direction = Vector2(1,0)
	if Input.is_action_just_pressed("move_l"):
		if not longdog_direction == Vector2(1,0) and not relation2(old_head_pos,new_head) == "right":
			longdog_direction = Vector2(-1,0)
		
	if Input.is_action_just_pressed("pause") && timer.is_paused() == false && win_game_check == false:
		timer.set_paused(true)
		$UIController/PauseScreen.visible = true
	elif Input.is_action_just_pressed("pause") && timer.is_paused() == true && win_game_check == false:
		timer.set_paused(false)
		$UIController/PauseScreen.visible = false

func check_hotdog():
	if hotdog_pos == longdog_body[0]:
		$HotDogNoise.play()
		hotdog_pos = place_hotdog()
		delete_tiles(hotdog)
		add_count()
		add_hotdog = true

func check_game_over():
	var head = longdog_body[0]
	#longdog leaves screen
	if head.x > 22 || head.x < 3 || head.y < 1 || head.y > 14:
		game_over()
	#longdog hits tail
	for block in longdog_body.slice(1,longdog_body.size()):
		if block == head:
			game_over()

func game_over():
	#temp reset functionality based from tutorial
	longdog_body = [Vector2(8,7),Vector2(7,7),Vector2(6,7)]
	longdog_direction = Vector2(1,0)
	if score_count > Global.high_score :
		Global.high_score = score_count
	Global.total_count += collection_amt
	
	score_count = 0
	collection_amt = 0
	coll_amt.text = str("x ", "0")

func add_score():
	score_count += 1 * collection_amt
	score.text = str("Score: ", int(score_count))

func add_count():
	collection_amt += 1
	coll_amt.text = str("x ", int(collection_amt))

func win_game():
	timer.set_paused(true)
	$UIController/WinScreen.visible = true
	win_game_check = true
	score_count *= 2
	if score_count > Global.high_score :
		Global.high_score = score_count
	collection_amt += 100

func _on_restart_button_pressed() -> void:
	win_game_check = false
	longdog_body = [Vector2(8,7),Vector2(7,7),Vector2(6,7)]
	longdog_direction = Vector2(1,0)
	$UIController/WinScreen.visible = false
	timer.set_paused(false)
	
	score_count = 0
	collection_amt = 0
	coll_amt.text = str("x ", "0")

func draw_hat():
	var head_dir = relation2(longdog_body[0],longdog_body[1])
	if head_dir == "right":
		$MainMap.set_cell(hat,longdog_body[0],10,Vector2(hat_id,0),6)
	if head_dir == "left":
		$MainMap.set_cell(hat,longdog_body[0],10,Vector2(hat_id,0),5)
	if head_dir == "up":
		$MainMap.set_cell(hat,longdog_body[0],10,Vector2(hat_id,0))
	if head_dir == "down":
		$MainMap.set_cell(hat,longdog_body[0],10,Vector2(hat_id,0),4)
