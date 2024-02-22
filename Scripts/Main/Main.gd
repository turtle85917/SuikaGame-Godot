extends Node2D

@onready var startButton = $"CanvasLayer/Control/Start Button";
@onready var quitButton = $"CanvasLayer/Control/Quit Button";

func _ready():
	startButton.connect("pressed", _on_start_button_pressed);
	quitButton.connect("pressed", _on_quit_button_pressed);

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");
	SoundManager.playSFX("Click");

func _on_quit_button_pressed():
	get_tree().quit();
