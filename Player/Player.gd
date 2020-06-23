extends KinematicBody2D

onready var sprite:Sprite = $Sprite
export var speed:int = 200
var screensize:Vector2 = Vector2.ZERO

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	var _velocity:Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		_velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		_velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		_velocity.x -= 1
	_velocity = _velocity.normalized()*speed*delta
	move_and_collide(_velocity)
