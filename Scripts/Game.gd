extends Node2D

@export var score:int = 0;
@export var isGameOver:bool = false;
@export var isGameOverProcessed:bool = false;

@onready var scoreText:Label = $CanvasLayer/Control/Score;
@onready var GameOver = preload("res://Scenes/GameOver.tscn");

func _process(_delta):
	scoreText.text = "​%s" % score;
	if(isGameOver && !isGameOverProcessed):
		isGameOverProcessed = true;
		# Take a screenshot of game.
		await RenderingServer.frame_post_draw;
		var viewport = get_viewport();
		var img = viewport.get_texture().get_image();
		var screenshotTexture = ImageTexture.create_from_image(img);
		screenshotTexture.set_size_override(Vector2(img.get_width() / 3.0, img.get_height() / 3.0))
		# Update "GameOver" Scene ui.
		var gameOverNode = GameOver.instantiate();
		var textureRect:TextureRect = gameOverNode.get_node("Control/Screenshot");
		var faderRect:ColorRect = gameOverNode.get_node("Control/Fader");
		textureRect.texture = screenshotTexture;
		faderRect.modulate = Color(0, 0, 0, 0);
		gameOverNode.get_node("Control/Score Bubble/Score").text = "​%s" % score;
		# Add "GameOver" Scene to tree.
		add_child(gameOverNode, true);
		gameOverNode.name = "GameOver";
		faderRect.get_node("AnimationPlayer").play("Fade In");
