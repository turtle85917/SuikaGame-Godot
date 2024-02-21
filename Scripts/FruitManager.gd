extends Resource;
class_name FruitManager;

enum FruitType {Cherry, Strawberry, Grahpe, Dekopon, Orange, Apple, Pear, Peach, Pineapple, Melon, Watermelon};

static var instance = FruitManager.new();
var Fruit = preload("res://Prefabs/Fruit.tscn");
@export var fruits:Array[Dictionary] = [
	{"type":FruitType.Cherry, "size": 1.5, "color": Color(0.79, 0.23, 0.23)},
	{"type":FruitType.Strawberry, "size": 2, "color": Color(0.89, 0.21, 0.21)},
	{"type":FruitType.Grahpe, "size": 2.5, "color": Color(0.58, 0.21, 0.72)},
	{"type":FruitType.Dekopon, "size": 3, "color": Color(0.79, 0.4, 0.12), "offset": 2},
	{"type":FruitType.Orange, "size": 3.5, "color": Color(0.9, 0.4, 0.11), "offset": 1.5},
	{"type":FruitType.Apple, "size": 4, "color": Color(0.74, 0.17, 0.17)},
	{"type":FruitType.Pear, "size": 4.5, "color": Color(0.75, 0.7, 0.23)},
	{"type":FruitType.Peach, "size": 5, "color": Color(0.93, 0.46, 0.46)},
	{"type":FruitType.Pineapple, "size": 6.5, "color": Color(0.83, 0.82, 0.31)},
	{"type":FruitType.Melon, "size": 7.5, "color": Color(0.6, 0.66, 0.2), "offset": 1},
	{"type":FruitType.Watermelon, "size": 8, "color": Color(0.13, 0.53, 0.05), "offset": 3}
];

static func createFruitType(owner:Node, type:FruitType, initalPosition:Vector2 = Vector2(0, -200), freezing:bool = false) -> Node:
	if(type + 1 > len(instance.fruits)): return;
	var fruit = instance.fruits[type];
	var fruitNode = instance.Fruit.instantiate();
	# Add fruit to game
	owner.get_node("Fruits").call_deferred_thread_group("add_child", fruitNode, true);
	fruitNode.mass = fruit.size * 0.2;
	fruitNode.name = "Fruit";
	fruitNode.fruitType = fruit.type;
	# Update fruit shape
	var fruitSprite = fruitNode.get_node("Sprite");
	var fruitCollision = fruitNode.get_node("Collision");
	fruitSprite.frame = fruit.type;
	fruitSprite.scale = Vector2.ONE * fruit.size;
	fruitCollision.scale = Vector2.ONE * fruit.size;
	if(freezing):
		fruitNode.freeze = true;
		fruitCollision.disabled = true;
	# Process when tree entered
	fruitNode.connect("tree_entered", func():
		fruitNode.set_owner(owner)
		if(!freezing):
			fruitSprite.scale = Vector2.ZERO;
			fruitNode.playShowAnimation(fruit);
	);
	# Return fruit
	if(fruit.has("offset")): fruitCollision.transform.origin.y += fruit.offset;
	fruitNode.transform.origin = initalPosition;
	return fruitNode;
