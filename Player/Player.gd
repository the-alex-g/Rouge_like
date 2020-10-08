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
onready var _floordetector := $RayCast2D

func _ready():
	_base_grav = grav_strength

func _physics_process(_delta):
	var _velocity := Vector2.ZERO
	if Input.is_action_pressed("Right"):
		_velocity.x += 1
	if Input.is_action_pressed("Left"):
		_velocity.x -= 1
	if Input.is_action_just_pressed("Jump") and not _jump and _floordetector.is_colliding():
		_jump = true
		_jumptimer.start(jumptime)
	var dir:Vector2 = _calculate_velocity(_velocity)
	var _error = move_and_slide(dir, Vector2.UP)
	var _next_anim:String = _get_next_anim(dir)
	_sprite.play(_next_anim)

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

func _get_next_anim(dir:Vector2):
	var next_anim := ""
	if dir.x == 0:
		next_anim = "Idle"
	elif dir.x != 0:
		next_anim = "Run"
		if dir.x > 0:
			_sprite.scale.x = 1
		elif dir.x < 0:
			_sprite.scale.x = -1
	if not _floordetector.is_colliding():
		next_anim = "Airborne"
	return next_anim

func _on_JumpTimer_timeout():
	_jump = false
