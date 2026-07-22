extends Area2D

var player: MainCharacter = null

@onready var death_margin: Timer = $DeathMargin


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	player = body
	if not body.is_dashing:
		death_margin.start()


func _on_body_exited(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return

	death_margin.stop()
	player = null


func _on_death_margin_timeout() -> void:
	if player != null:
		player.take_player_control("fall_down")
