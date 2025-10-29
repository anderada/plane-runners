extends Node2D

@export var padIndicators : Array

func _physics_process(delta: float) -> void:
	showIndicators()

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
	if(Input.is_action_pressed("Up1")):
		get_node(padIndicators[4]).visible = true
	if(Input.is_action_pressed("Up2")):
		get_node(padIndicators[5]).visible = true
	if(Input.is_action_pressed("Down1")):
		get_node(padIndicators[6]).visible = true
	if(Input.is_action_pressed("Down2")):
		get_node(padIndicators[7]).visible = true
