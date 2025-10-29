extends Node2D

@export var padIndicators : Array
@export var menuUI : Control
@export var gameUI : Control
@export var pointsLabel : Label
@export var score : Label
@export var hiscore : Label

var state = "menu"

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
		
	if(Input.is_action_pressed("Left1")):
		get_node(padIndicators[1]).visible = true
	if(Input.is_action_pressed("Left2")):
		get_node(padIndicators[0]).visible = true
	if(Input.is_action_pressed("Right1")):
		get_node(padIndicators[2]).visible = true
	if(Input.is_action_pressed("Right2")):
		get_node(padIndicators[3]).visible = true
