extends RigidBody2D

@export var fruitType:FruitManager.FruitType;
@export var isMerged = false;

func _on_body_entered(body:Node):
	if(fruitType == FruitManager.FruitType.Watermelon): return;
	if(body.get_groups().has("Fruit") && body.fruitType == fruitType && !isMerged):
		isMerged = true;
		body.isMerged = true;
		FruitManager.createFruitType(get_parent().get_owner(), fruitType + 1, body.transform.origin);
		queue_free();
		body.queue_free();
