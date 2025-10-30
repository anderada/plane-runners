extends Node3D

var playerHP = 3
@export var maxHP = 3
var timer: int = 0
@export var globalSpeed = 5.0

var wall_preloaded : Array

@export var heart_paths : Array
var hearts : Array

@export var wall_spawn_distance = 100

@export var frames_per_wall : int = 700
var walltime = 0

@export var gameState = "menu"

@export var points : int = 0

@export var scores : Array

var extantWalls : Array

var oneGuy : int = 0

var ringCollected = false
var streak = 0
signal streakActive
signal streakInactive

func loadWalls() -> void:
	wall_preloaded.append(preload("res://walls/0.tscn"))
	wall_preloaded.append(preload("res://walls/1.tscn"))
	wall_preloaded.append(preload("res://walls/2.tscn"))
	wall_preloaded.append(preload("res://walls/3.tscn"))
	wall_preloaded.append(preload("res://walls/4.tscn"))
	wall_preloaded.append(preload("res://walls/5.tscn"))
	wall_preloaded.append(preload("res://walls/6.tscn"))
	wall_preloaded.append(preload("res://walls/7.tscn"))

func _ready() -> void:
	for heart in heart_paths:
		hearts.append(get_node(heart))
	loadWalls()

func _physics_process(_delta: float) -> void:
	if(gameState == "menu"):
		if num_inputs() == 2:
			gameState = "game"
			points = 0
			timer = 0
			%AudioManager.playSound("engine")
	else:
		timer += 1
		walltime -= 1
		globalSpeed = 5.0 + (timer / 400.0)
		if(walltime <= 0):
			spawn_wall()
			remove_old_walls()
			timer += 5
			walltime = frames_per_wall
		@warning_ignore("narrowing_conversion")
		frames_per_wall = max(700 - (timer / 10.0),200)
		
		if(oneGuy >= 2000):
			oneGuy = 0
			playerHP = min(playerHP + 1, 3)
			%AudioManager.playSound("fanfare")
			%UI.playHeart()
			
	
	if playerHP <= 0:
		%AudioManager.playSound("fail")
		%AudioManager.stopEngine()
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
	oneGuy += 100
	ringCollected = true
	%AudioManager.playSound("cymbal")
	%UI.playBounce()
	
func ring_high()->void:
	points += 500
	oneGuy += 500
	ringCollected = true
	%AudioManager.playSound("cymbal")
	%UI.playBounce()

func remove_old_walls()->void:
	for wall in extantWalls:
		if wall.position.z >= 1:
			extantWalls.erase(wall)
			wall.queue_free()
			checkStreak()

func checkStreak()->void:
	if(ringCollected):
		streak += 1
		ringCollected = false
	else:
		streak = 0
		streakInactive.emit()
	if(streak > 4):
		streakActive.emit()
		%AudioManager.playSound("streak")
	

func spawn_wall()->void:
	var newWall
	var randomIndex = randi_range(0,wall_preloaded.size() - 1)
	newWall = wall_preloaded[randomIndex].instantiate()
	add_child(newWall)
	extantWalls.append(newWall)
	@warning_ignore("narrowing_conversion")
	var randx = randi_range(-1,1)
	newWall.position = Vector3(randx,0,-wall_spawn_distance)

func take_damage()->void:
	playerHP -= 1
	updateHearts()
	%AudioManager.playSound("crash")

func updateHearts()->void:
	for heart in hearts:
		heart.visible = false
	if hearts.size() > 0:
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
