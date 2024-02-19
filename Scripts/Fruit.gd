extends RigidBody2D

@export var fruitType:FruitManager.FruitType;
@export var isMerged = false;

var tween:Tween = null;

func _on_body_entered(body:Node):
	if(fruitType == FruitManager.FruitType.Watermelon): return;
	if(body.get_groups().has("Fruit") && body.fruitType == fruitType && !isMerged):
		isMerged = true;
		body.isMerged = true;
		stopAnimation();
		body.stopAnimation();
		queue_free();
		body.queue_free();
		FruitManager.createFruitType(get_owner(), fruitType + 1, body.transform.origin);

func playShowAnimation(fruit:Dictionary):
	var fruitParticles:GPUParticles2D = get_node("Particles");
	var fruitParticleMaterial = fruitParticles.process_material.duplicate();
	fruitParticleMaterial.color = fruit.color;
	fruitParticles.process_material = fruitParticleMaterial;
	fruitParticles.emitting = true;
	tween = owner.create_tween();
	tween.tween_property(get_node("Sprite"), "scale", Vector2.ONE * fruit.size, 0.2).set_trans(Tween.TRANS_EXPO);

func stopAnimation():
	if(tween != null):
		tween.stop();
