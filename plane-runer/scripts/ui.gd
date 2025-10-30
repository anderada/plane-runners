extends Node2D

@export var padIndicators : Array
@export var menuUI : Control
@export var gameUI : Control
@export var pointsLabel : Label
@export var score : Label
@export var hiscore : Label

var state = "menu"
@onready var score_animator: AnimationPlayer = %scoreAnimator
@onready var heart_animator: AnimationPlayer = %heartAnimator
@onready var heart_indicator: Sprite2D = $"Game UI/HeartIndicator"
@onready var streak_fire: Sprite2D = $"Game UI/Points/Sprite2D/streakFire"
@onready var footprint_3: Sprite2D = $Menu/Control/Footprint3
@onready var footprint_4: Sprite2D = $Menu/Control/Footprint4
@onready var crash: Control = $"Game UI/crash"
@onready var crash_animator: AnimationPlayer = $"Game UI/crash/crashAnimator"
@onready var add_animator: AnimationPlayer = $"Game UI/scoreAdd/addAnimator"
@onready var score_add: Label = $"Game UI/scoreAdd"

signal heartDone

func hideAdd(_animation: StringName):
	score_add.visible = false

func showAdd(value: int):
	score_add.text = "+" + str(value)
	score_add.visible = true
	add_animator.play("add")

func hideCrash(_animation: StringName):
	crash.visible = false
	
func showCrash():
	crash.visible = true
	crash_animator.play("crash")

func showStreak():
	streak_fire.visible = true

func hideStreak():
	streak_fire.visible = false

func  _ready() -> void:
	hideHeart("")
	hideStreak()
	hideCrash("")
	hideAdd("")

func playHeart():
	heart_indicator.visible = true
	heart_animator.play("heart")

func hideHeart(_animation: StringName):
	heart_indicator.visible = false
	heartDone.emit()

func playBounce():
	score_animator.play("bounce")

func _physics_process(_delta: float) -> void:
	get_state()
	if(state == "menu"):
		showIndicators()
		getScores()
	else:
		updatePoints()

func getScores()->void:
	var points = get_tree().get_root().get_node("main").points
	score.text = "Your Score:\n" + str(points)
	var hiscores = get_tree().get_root().get_node("main").scores
	hiscore.text = "High Scores:\n"
	var i = 0
	for ranking in hiscores:
		if(i == 5):
			break
		hiscore.text = hiscore.text + str(ranking) + "\n"
		i += 1

func updatePoints()->void:
	var points = get_tree().get_root().get_node("main").points
	pointsLabel.text = str(points)

func get_state() -> void:
	state = get_tree().get_root().get_node("main").gameState
	if(state == "menu"):
		menuUI.visible = true
		gameUI.visible = false
	else:
		menuUI.visible = false
		gameUI.visible = true

func showIndicators() -> void:
	for indicator in padIndicators:
		get_node(indicator).visible = false
	footprint_3.visible = false
	footprint_4.visible = false
		
	if(Input.is_action_pressed("Left1")):
		get_node(padIndicators[1]).visible = true
		footprint_3.visible = true
	if(Input.is_action_pressed("Left2")):
		get_node(padIndicators[0]).visible = true
		footprint_3.visible = true
	if(Input.is_action_pressed("Right1")):
		get_node(padIndicators[2]).visible = true
		footprint_4.visible = true
	if(Input.is_action_pressed("Right2")):
		get_node(padIndicators[3]).visible = true
		footprint_4.visible = true
		
	if(Input.is_action_just_pressed("Left1")):
		%AudioManager.playSound("cymbal")
	if(Input.is_action_just_pressed("Left2")):
		%AudioManager.playSound("cymbal")
	if(Input.is_action_just_pressed("Right1")):
		%AudioManager.playSound("cymbal")
	if(Input.is_action_just_pressed("Right2")):
		%AudioManager.playSound("cymbal")
