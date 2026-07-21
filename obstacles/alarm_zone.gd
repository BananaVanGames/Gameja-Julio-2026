extends Area2D

@export var caught_margin: float = -1

var player: MainCharacter = null

@onready var alarm_timer: Timer = $AlarmTimer
@onready var col_shape: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect = $ColorRect


func _ready() -> void:
	alarm_timer.wait_time = caught_margin
	color_rect.size = col_shape.shape.size
	color_rect.position.x = col_shape.position.x - color_rect.size.x / 2
	color_rect.position.y = col_shape.position.y - color_rect.size.y / 2


func _process(_delta: float) -> void:
	if not player:
		return

	Events.update_alarm(alarm_timer.time_left)


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	print("ENTERED")
	alarm_timer.start()
	player = body


func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	alarm_timer.stop()
	player = null
	Events.stop_alarm()


func _on_alarm_timer_timeout() -> void:
	player.caught_alarm()
