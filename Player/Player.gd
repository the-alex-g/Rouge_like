extends KinematicBody2D

enum State {IDLE, WALKING}
onready var sprite:Sprite = $Sprite
export var speed:int = 200
var state = State.IDLE
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
	if _velocity.x != 0:
		sprite.flip_v = false
		sprite.flip_h = _velocity.x < 0
		state = State.WALKING
	elif _velocity.y != 0:
		sprite.flip_v = _velocity.y > 0
		state = State.WALKING
	elif _velocity == Vector2.ZERO:
		state = State.IDLE
	_velocity = _velocity.normalized()*speed*delta
	var _error = move_and_collide(_velocity)
