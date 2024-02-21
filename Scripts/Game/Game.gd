extends Node2D

@export var score:int = 0;
@export var isGameOver:bool = false;
@export var isGameOverProcessed:bool = false;

@onready var scoreText:Label = $CanvasLayer/Control/Score;
@onready var bestScoreTitle:Label = $"CanvasLayer/Control/Best Score Title";
@onready var bestScoreText:Label = $"CanvasLayer/Control/Best Score";
@onready var Fruits:Node2D = $Fruits;
@onready var GameOver = preload("res://Scenes/GameOver.tscn");

var bestScore:int = 0;
var syncableBestScore:bool = false;

func _ready():
	bestScore = SaveManager.loadScore();
	bestScoreText.text = "​%s" % bestScore;

func _process(_delta):
	scoreText.text = "​%s" % score;
	if(bestScore < score):
		bestScoreText.text = "​%s" % score;
		# Display "new best score" effect
		if(!syncableBestScore):
			syncableBestScore = true;
			const duration = 0.2;
			const finalColor = Color(200, 0, 0);
			create_tween().tween_property(bestScoreTitle, "theme_override_colors/font_outline_color", finalColor, duration);
			create_tween().tween_property(bestScoreText, "theme_override_colors/font_outline_color", finalColor, duration);

	if(isGameOver && !isGameOverProcessed):
		# Update game process
		isGameOverProcessed = true;
		if(bestScore < score): SaveManager.saveData(score);
		Fruits.process_mode = Node.PROCESS_MODE_DISABLED;
		# Take a screenshot of game
		await RenderingServer.frame_post_draw;
		var viewport = get_viewport();
		var img = viewport.get_texture().get_image();
		var screenshotTexture = ImageTexture.create_from_image(img);
		screenshotTexture.set_size_override(Vector2(img.get_width() / 3.0, img.get_height() / 3.0))
		# Update "GameOver" Scene ui
		var gameOverNode = GameOver.instantiate();
		var textureRect:TextureRect = gameOverNode.get_node("Control/Screenshot");
		var faderRect:ColorRect = gameOverNode.get_node("Control/Fader");
		textureRect.texture = screenshotTexture;
		faderRect.modulate = Color(0, 0, 0, 0);
		gameOverNode.get_node("Control/Score Bubble/Score").text = "​%s" % score;
		gameOverNode.get_node("Control/BestScore Bubble/Score").text = "​%s" % (score if(bestScore < score) else bestScore);
		# Add "GameOver" Scene to tree
		add_child(gameOverNode, true);
		gameOverNode.name = "GameOver";
		faderRect.get_node("AnimationPlayer").play("Fade In");
