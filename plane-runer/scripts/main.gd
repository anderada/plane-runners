extends Node3D

var playerHP = 3
@export var maxHP = 3
var timer: int = 0
@export var globalSpeed = 5.0

@export var wall_prefabs : Array
var wall_preloaded : Array

@export var heart_paths : Array
var hearts : Array

@export var wall_spawn_distance = 100

@export var frames_per_wall : int = 500

@export var gameState = "menu"

@export var points : int = 0

@export var scores : Array

var extantWalls : Array

func _ready() -> void:
	for heart in heart_paths:
		hearts.append(get_node(heart))

func _physics_process(_delta: float) -> void:
	if(gameState == "menu"):
		if num_inputs() == 4:
			gameState = "game"
			points = 0
			timer = 0
	else:
		timer += 1
		globalSpeed = 5.0 + (timer / 400.0)
		if(timer % 10 == 0):
			points += 1
		if(timer % frames_per_wall < 5):
			spawn_wall()
			remove_old_walls()
			timer += 5
		@warning_ignore("narrowing_conversion")
		frames_per_wall = max(500 - (timer / 30.0),100)
	
	if playerHP <= 0:
		gameState = "menu"
		scores.append(points)
		scores.sort()
		scores.reverse()
		playerHP = 3
		%Plane.reset_position()
		for wall in extantWalls:
			wall.queue_free()
		extantWalls.clear()
		updateHearts()

func ring()->void:
	points += 100
	
func ring_high()->void:
	points += 500

func remove_old_walls()->void:
	for wall in extantWalls:
		if wall.position.z >= 10:
			extantWalls.erase(wall)
			wall.queue_free()

func spawn_wall()->void:
	var randomIndex = randi_range(0,wall_prefabs.size() - 1)
	var newWall = load(wall_prefabs[randomIndex]).instantiate()
	add_child(newWall)
	extantWalls.append(newWall)
	@warning_ignore("narrowing_conversion")
	var randx = randi_range(-1,1)
	newWall.position = Vector3(randx,0,-wall_spawn_distance)

func take_damage()->void:
	playerHP -= 1
	updateHearts()

func updateHearts()->void:
	for heart in hearts:
		heart.visible = false
	for i in range(playerHP):
		hearts[i].visible = true
		

func num_inputs()->int:
	var inputs = 0
	
	if(Input.is_action_pressed("Left1")):
		inputs+=1
	if(Input.is_action_pressed("Left2")):
		inputs+=1
	if(Input.is_action_pressed("Right1")):
		inputs+=1
	if(Input.is_action_pressed("Right2")):
		inputs+=1
		
	return inputs
