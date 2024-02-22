extends CanvasLayer

@export var screenshotImage:Image = null;

@onready var restartButton:TextureButton = $"Control/Restart Button";
@onready var backButton:TextureButton = $"Control/Back Button";
@onready var saveSsButton:TextureButton = $"Control/Save Screenshot Button";
@onready var quitButton:TextureButton = $"Control/Quit Button";

func _ready():
	restartButton.connect("pressed", _on_restart_button_pressed);
	backButton.connect("pressed", _on_back_button_pressed);
	saveSsButton.connect("pressed", _on_save_screenshot_button_pressed);
	quitButton.connect("pressed", _on_quit_button_pressed);

func _on_restart_button_pressed():
	get_tree().reload_current_scene();
	SoundManager.playSFX("Click");

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn");
	SoundManager.playSFX("Click");

func _on_save_screenshot_button_pressed():
	const pathname = "Screenshots";
	var path = OS.get_executable_path().get_base_dir();
	var dir = DirAccess.open(path);
	var err = dir.make_dir(pathname) if(!dir.dir_exists(pathname)) else dir.open(pathname);
	if(err != null):
		var time = Time.get_datetime_dict_from_system();
		var filename = "%s_%02d_%02d_%02d_%02d_%02d" % [time.year, time.month, time.day, time.hour, time.minute, time.second]
		screenshotImage.save_png("%s/Screenshots/%s.png" % [path, filename]);
		saveSsButton.disabled = true;
		saveSsButton.get_node("Label").text = "Saved";
	SoundManager.playSFX("Click");

func _on_quit_button_pressed():
	get_tree().quit();
