extends Resource;
class_name FruitManager;

enum FruitType {Cherry, Strawberry, Grahpe, Dekopon, Orange, Apple, Pear, Peach, Pineapple, Melon, Watermelon};

static var instance = FruitManager.new();
var Fruit = preload("res://Prefabs/Fruit.tscn");
@export var fruits:Array[Dictionary] = [
	{"type":FruitType.Cherry, "size": 1.5},
	{"type":FruitType.Strawberry, "size": 2},
	{"type":FruitType.Grahpe, "size": 2.5},
	{"type":FruitType.Dekopon, "size": 3, "offset": 2},
	{"type":FruitType.Orange, "size": 3.5, "offset": 1.5},
	{"type":FruitType.Apple, "size": 4},
	{"type":FruitType.Pear, "size": 4.5},
	{"type":FruitType.Peach, "size": 5},
	{"type":FruitType.Pineapple, "size": 6.5},
	{"type":FruitType.Melon, "size": 7.5, "offset": 1},
	{"type":FruitType.Watermelon, "size": 8, "offset": 3}
];

static func createFruitType(owner:Node, type:FruitType, initalPosition:Vector2 = Vector2(0, -200), freezing:bool = false) -> Node:
	if(type + 1 > len(instance.fruits)): return;
	var fruit = instance.fruits[type];
	var fruitNode = instance.Fruit.instantiate();
	owner.get_node("Fruits").call_deferred_thread_group("add_child", fruitNode);
	fruitNode.name = "Fruit";
	fruitNode.mass = pow(fruit.size, fruit.size) * 0.1;
	fruitNode.fruitType = fruit.type;
	var fruitSprite = fruitNode.get_node("Sprite");
	var fruitCollision = fruitNode.get_node("Collision");
	fruitSprite.frame = fruit.type;
	fruitSprite.scale = Vector2.ONE * fruit.size;
	fruitCollision.scale = Vector2.ONE * fruit.size;
	if(freezing):
		fruitNode.freeze = true;
		fruitCollision.disabled = true;
	if(fruit.has("offset")): fruitCollision.transform.origin.y += fruit.offset;
	fruitNode.transform.origin = initalPosition;
	return fruitNode;
