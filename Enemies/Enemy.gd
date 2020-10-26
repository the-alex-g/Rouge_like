extends KinematicBody2D

onready var left := $Left
onready var right := $Right
onready var animation := $AnimationPlayer
onready var sprite := $Sprite
var go_left := false
var speed := 50.0

func _ready():
	var start_dir = randi()%2
	if start_dir == 0:
		go_left = false
	else:
		go_left = true
	animation.play("Walk")

func _physics_process(_delta):
	var velocity := Vector2.ZERO
	if is_on_wall():
		go_left = not go_left
	if not left.is_colliding():
		go_left = false
	if not right.is_colliding():
		go_left = true
	if go_left:
		velocity.x -= 1
		sprite.scale.x = -1
	elif not go_left:
		velocity.x += 1
		sprite.scale.x = 1
	var _error = move_and_slide(velocity*speed)

