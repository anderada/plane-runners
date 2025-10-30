extends CharacterBody3D

@export var horizontalSpeeds = [0.7, 3.5]
@export var verticalSpeeds = [0.5,2.5]
var horizontalRotations = [15,30]
var verticalRotations = [15,30]

@onready var left_2: MeshInstance3D = $left2
@onready var left_1: MeshInstance3D = $left1
@onready var right_1: MeshInstance3D = $right1
@onready var right_2: MeshInstance3D = $right2

var acceleration : Vector3
var drift : Vector3

signal player_hit

@export var iFrames = 60
var hurtTimer = 0

var speed : float
var state = "menu"

func _ready() -> void:
	velocity = Vector3(0,0,0)

func _physics_process(_delta: float) -> void:
	get_speed()
	get_state()
	get_input()
	if(state == "menu"):
		velocity = Vector3(0,0,0)
	else:
		velocity += acceleration * _delta * (speed / 5.0)
		#velocity = acceleration * (speed / 3.0)
		velocity -= velocity / 100.0
		hurtTimer -= 1
		move_and_slide()
	
func get_speed() -> void:
	speed = get_tree().get_root().get_node("main").globalSpeed
	
func get_state() -> void:
	state = get_tree().get_root().get_node("main").gameState

func reset_position() -> void:
	position = Vector3(-1.5,-1.5,0)
	
func get_input() -> void:
	acceleration.x = 0
	acceleration.y = 0
	rotation_degrees.z = 0
	rotation_degrees.x = 0
	left_1.visible = false
	left_2.visible = false
	right_1.visible = false
	right_2.visible = false
	
	if(Input.is_action_pressed("Left1")):
		acceleration.x -= horizontalSpeeds[0]
		rotation_degrees.z += horizontalRotations[0]
		left_1.visible = true
	if(Input.is_action_pressed("Left2")):
		acceleration.x -= horizontalSpeeds[1]
		rotation_degrees.z += horizontalRotations[1]
		left_2.visible = true
	if(Input.is_action_pressed("Right1")):
		acceleration.x += horizontalSpeeds[0]
		rotation_degrees.z -= horizontalRotations[0]
		right_1.visible = true
	if(Input.is_action_pressed("Right2")):
		acceleration.x += horizontalSpeeds[1]
		rotation_degrees.z -= horizontalRotations[1]
		right_2.visible = true
	if(Input.is_action_pressed("Up1")):
		acceleration.y += verticalSpeeds[0]
		rotation_degrees.x += verticalRotations[0]
	if(Input.is_action_pressed("Up2")):
		acceleration.y += verticalSpeeds[1]
		rotation_degrees.x += verticalRotations[1]
	if(Input.is_action_pressed("Down1")):
		acceleration.y -= verticalSpeeds[0]
		rotation_degrees.x -= verticalRotations[0]
	if(Input.is_action_pressed("Down2")):
		acceleration.y -= verticalSpeeds[1]
		rotation_degrees.x -= verticalRotations[1]

func hit_wall(body: Node3D)->void:
	if(body.name == "Plane" && hurtTimer <= 0):
		player_hit.emit()
		hurtTimer = iFrames

func ring(body: Node3D)->void:
	if(body.name == "Plane"):
		get_tree().get_root().get_node("main").ring()
		
func ring_high(body: Node3D)->void:
	if(body.name == "Plane"):
		get_tree().get_root().get_node("main").ring_high()

func connect_wall(wall : Area3D)->void:
	wall.connect("body_entered", hit_wall)
	
func connect_ring_high(wall : Area3D)->void:
	wall.connect("body_entered", ring_high)
	
func connect_ring_low(wall : Area3D)->void:
	wall.connect("body_entered", ring)
