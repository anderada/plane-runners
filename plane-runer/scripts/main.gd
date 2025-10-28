extends Node3D

var playerHP = 3
@export var maxHP = 3
var timer: int = 0
@export var globalSpeed = 5.0

@export var wall_prefabs : Array
var wall_preloaded : Array

@export var heart_paths : Array
var hearts : Array

@export var frames_per_wall : int = 500

func _ready() -> void:
	for heart in heart_paths:
		hearts.append(get_node(heart))

func _physics_process(_delta: float) -> void:
	timer += 1
	if(timer % frames_per_wall == 1):
		spawn_wall()

func spawn_wall()->void:
	var newWall = load(wall_prefabs[0]).instantiate()
	add_child(newWall)
	newWall.position = Vector3(0,0,-20)

func take_damage()->void:
	playerHP -= 1
	for heart in hearts:
		heart.visible = false
	for i in range(playerHP):
		hearts[i].visible = true
