extends Node

@onready var music: AudioStreamPlayer3D = $Music
@onready var crash: AudioStreamPlayer3D = $Crash
@onready var engine_start: AudioStreamPlayer3D = $EngineStart
@onready var engine: AudioStreamPlayer3D = $Engine
@onready var fail: AudioStreamPlayer3D = $Fail
@onready var swoosh: AudioStreamPlayer3D = $swoosh
@onready var cymbal: AudioStreamPlayer3D = $cymbal
@onready var fanfare: AudioStreamPlayer3D = $fanfare

func playSound(sound:String)->void:
	match sound:
		"crash":
			crash.play()
		"engine":
			engine_start.play()
		"fail":
			fail.play()
		"swoosh":
			swoosh.play()
		"cymbal":
			cymbal.play()
		"fanfare":
			fanfare.play()

func startEngine()->void:
	engine.play()

func stopEngine()->void:
	engine.stop()
