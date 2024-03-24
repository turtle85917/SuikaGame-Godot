extends RigidBody2D

@onready var game = get_owner();
@export var fruitType:FruitManager.FruitType;
@export var isMerged = false;

var tween:Tween = null;

func _physics_process(_delta):
	if(!freeze):
		if(transform.origin.y < -185 && linear_velocity.y < 0.5):
			game.isGameOver = true;
		if(transform.origin.y > 300):
			game.isGameOver = true;

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
