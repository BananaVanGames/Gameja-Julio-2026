extends Marker2D

@onready var player: MainCharacter = $Player
@onready var global_cam: Camera2D = $"../Camera2D"
@onready var player_cam: Camera2D = $Player/Camera2D
@onready var teleporter: ColorRect = $Teleporter


func _ready() -> void:
	global_cam.enabled = true
	player_cam.enabled = false

	await get_tree().create_timer(1.0).timeout

	start_camera_transition()


func _process(delta: float) -> void:
	teleporter.rotation += delta * 10


func start_camera_transition() -> void:
	var destino: Vector2 = player.global_position
	var zoom_final: Vector2 = player_cam.zoom

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(
		global_cam,
		"global_position",
		destino,
		2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tween.tween_property(
		global_cam,
		"zoom",
		zoom_final,
		2.0
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	# Cuando termina la animación
	tween.chain().tween_callback(finish_transition)


func finish_transition() -> void:
	player.exec_spawn_player()
	global_cam.enabled = false
	player_cam.enabled = true
