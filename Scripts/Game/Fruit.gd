extends RigidBody2D

@export var fruitType:FruitManager.FruitType;
@export var isMerged = false;

@onready var game = get_owner();
@onready var limitLine = game.get_node("Case/LimitLine");
@onready var timer:Timer = $Timer;

var tween:Tween = null;
var isEnteredLine:bool = false;

func _ready():
	limitLine.connect("body_entered", _on_limit_line_entered);
	limitLine.connect("body_exited", _on_limit_line_exited);
	timer.connect("timeout", _timeout);

func _physics_process(_delta):
	if(!freeze):
		if(transform.origin.y > 300):
			game.isGameOver = true;

func _timeout():
	if(isEnteredLine):
		game.isGameOver = true;

func _on_limit_line_entered(_body):
	isEnteredLine = true;
	timer.start();

func _on_limit_line_exited(_body):
	isEnteredLine = false;
	timer.stop();

func _on_body_entered(body:Node):
	if(fruitType == FruitManager.FruitType.Watermelon): return;
	if(body.get_groups().has("Fruit") && body.fruitType == fruitType && !isMerged):
		isMerged = true;
		body.isMerged = true;
		stopAnimation();
		body.stopAnimation();
		queue_free();
		body.queue_free();
		get_owner().score += pow(fruitType + 1, 2);
		FruitManager.createFruitType(get_owner(), fruitType + 1, body.transform.origin);
		SoundManager.playSFX("Pop");

func playShowAnimation(fruit:Dictionary):
	var fruitParticles:GPUParticles2D = get_node("Particles");
	var fruitParticleMaterial = fruitParticles.process_material.duplicate();
	fruitParticleMaterial.color = fruit.color;
	fruitParticles.process_material = fruitParticleMaterial;
	fruitParticles.emitting = true;
	tween = owner.create_tween();
	tween.tween_property(get_node("Sprite"), "scale", Vector2.ONE * fruit.size, 0.2).set_trans(Tween.TRANS_EXPO);
	tween.play();

func stopAnimation():
	if(tween != null):
		tween.stop();
