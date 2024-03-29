extends Node2D

var fruitNode:RigidBody2D;
var isMoving:bool = false;

const MAX_POS_X:int = 156;

func _ready():
	createFruit();

func _physics_process(_delta):
	if(get_owner().isGameOver): return;
	var strength = Input.get_action_strength("right") - Input.get_action_strength("left");
	move_local_x(strength * 8);
	if(abs(transform.origin.x) > MAX_POS_X):
		transform.origin.x = min(max(transform.origin.x, -MAX_POS_X), MAX_POS_X);
		return;
	if(fruitNode != null && isMoving):
		fruitNode.transform.origin.x = transform.origin.x;
	if(Input.is_action_just_pressed("jump") && isMoving):
		isMoving = false;
		fruitNode.freeze = false;
		fruitNode.get_node("Collision").disabled = false;
		SoundManager.playSFX("Pop")
		get_tree().create_timer(0.5).connect("timeout", func():createFruit());

func createFruit():
	isMoving = true;
	fruitNode = FruitManager.createFruitType(get_owner(), randi_range(0, 1), Vector2(transform.origin.x, -200), true);
