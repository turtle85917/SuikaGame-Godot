extends Control

@onready var restartButton:TextureButton = $"Restart Button";
@onready var backButton:TextureButton = $"Back Button";
@onready var quitButton:TextureButton = $"Quit Button";

func _ready():
	restartButton.connect("pressed", _on_restart_button_pressed);
	backButton.connect("pressed", _on_back_button_pressed);
	quitButton.connect("pressed", _on_quit_button_pressed);

func _on_restart_button_pressed():
	get_tree().reload_current_scene();

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn");

func _on_quit_button_pressed():
	get_tree().quit();
