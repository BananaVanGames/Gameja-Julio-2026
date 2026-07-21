class_name MainCharacter
extends CharacterBody2D

@export var SPEED := 175.0
@export var SPRINT_SPEED := 350.0

@export var DASH_SPEED := 700.0
@export var DASH_DURATION := 0.15

var is_dashing := false
var dash_direction := Vector2.ZERO

@onready var dash_timer: Timer = $DashTimer
@onready var dash_wait_time: Timer = $DashWaitTime
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	if is_dashing:
		velocity = dash_direction * DASH_SPEED
		move_and_slide()
		return

	var speed := SPRINT_SPEED if Input.is_action_pressed("Sprint") else SPEED

	var direction := Input.get_vector(
		"Left",
		"Right",
		"Up",
		"Down"
	)

	if direction != Vector2.ZERO:
		velocity = direction * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed / 7.5)

	if Input.is_action_just_pressed("Dash") and dash_wait_time.is_stopped():
		dash_wait_time.start()
		start_dash()

	move_and_slide()


func start_dash() -> void:
	var direction := Input.get_vector(
		"Left",
		"Right",
		"Up",
		"Down"
	)

	# Si tampoco existe una dirección previa, no hace dash
	if direction == Vector2.ZERO:
		return

	dash_direction = direction.normalized()
	is_dashing = true

	dash_timer.start()


func fall_down() -> void:
	game_over("fall_down")
	print("FELL")


func caught_alarm() -> void:
	game_over("caught_alarm")
	print("CAUGHT")


func game_over(animation: String) -> void:
	set_physics_process(false)
	anim_player.play(animation)
	await anim_player.animation_finished
	print("DEAD")
	queue_free()


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	velocity = Vector2.ZERO
