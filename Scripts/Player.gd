extends Node2D

enum FruitType {Cherry, Strawberry, Grahpe, Dekopon, Orange, Apple, Pear, Peach, Pineapple, Melon, Watermelon};

@onready var Fruit = preload("res://Prefabs/Fruit.tscn");
@onready var fruits = [
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

var fruitNode:RigidBody2D;
var isMoving:bool = false;

const MAX_POS_X:int = 156;

func _ready():
	createFruit();

func _physics_process(delta):
	var strength = Input.get_action_strength("right") - Input.get_action_strength("left");
	move_local_x(strength * 8);
	if(abs(transform.origin.x) > MAX_POS_X):
		transform.origin.x = min(max(transform.origin.x, -MAX_POS_X), MAX_POS_X);
		return;
	if(fruitNode != null && isMoving):
		fruitNode.transform.origin.x = transform.origin.x;
	if(Input.is_action_just_pressed("jump") && isMoving):
		fruitNode.freeze = false;
		isMoving = false;
		await get_tree().create_timer(1.2).connect("timeout", func():createFruit());

func createFruit():
	var fruit = fruits[randi_range(0, 10)];
	fruitNode = Fruit.instantiate();
	get_owner().get_node("Fruits").add_child(fruitNode);
	fruitNode.freeze = true;
	var fruitSprite = fruitNode.get_node("Sprite");
	var fruitCollision = fruitNode.get_node("Collision");
	fruitSprite.frame = fruit.type;
	fruitSprite.scale = Vector2.ONE * fruit.size;
	fruitCollision.scale = Vector2.ONE * fruit.size;
	if(fruit.has("offset")): fruitCollision.transform.origin.y += fruit.offset;
	fruitNode.transform.origin.y = -200;
	fruitNode.transform.origin.x = transform.origin.x;
	isMoving = true;
