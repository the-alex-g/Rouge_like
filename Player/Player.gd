class_name Player
extends KinematicBody2D

export var speed := 200
export var grav_strength := 200
export var grav_increment := 5
export var jump_strength := 200
export var jumptime := 0.5
var _jump = false
var _base_grav := 0
onready var _sprite := $AnimatedSprite
onready var _jumptimer := $JumpTimer

func _ready():
	_base_grav = grav_strength

func _physics_process(_delta):
	var _velocity := Vector2.ZERO
	if Input.is_action_pressed("Right"):
		_velocity.x += 1
	if Input.is_action_pressed("Left"):
		_velocity.x -= 1
	if Input.is_action_just_pressed("Jump") and not _jump:# and is_on_floor():
		_jump = true
		_jumptimer.start(jumptime)
	var _error = move_and_slide(_calculate_velocity(_velocity))

func _calculate_velocity(velocity:Vector2):
	var dir := velocity
	if not is_on_floor() and not _jump:
		dir.y += 1
	else:
		grav_strength = _base_grav
	if _jump:
		dir.y -= 1
	dir = dir.normalized()
	if dir.y > 0:
		dir.y *= grav_strength
		grav_strength += grav_increment
	elif dir.y < 0:
		dir.y *= jump_strength
	dir.x *= speed
	return dir

func _on_JumpTimer_timeout():
	_jump = false
