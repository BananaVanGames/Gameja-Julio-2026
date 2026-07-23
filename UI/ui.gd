extends CanvasLayer

var tween: Tween

@onready var alarm_pop_up: RichTextLabel = $AlarmPopUp
@onready var black_fade: ColorRect = $BlackFade
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	black_fade.visible = true
	black_fade.modulate.a = 0
	alarm_pop_up.modulate.a = 0
	Events.connect("updating_alarm", _updating_alarm)
	Events.connect("stopping_alarm", _stopping_alarm)
	Events.connect("fading_out", _fading_out)
	Events.connect("fading_in", _fading_in)


func _fading_out() -> void:
	anim_player.play("fade_out")


func _fading_in() -> void:
	anim_player.play("fade_in")


func _updating_alarm(value: float) -> void:
	if tween != null and tween.is_running():
		tween.stop()
	alarm_pop_up.modulate.a = 1
	alarm_pop_up.text = "Alarm triggers in " + str(snapped(value, 0.1)) + " seconds."


func _stopping_alarm() -> void:
	alarm_pop_up.text = "The alarm went down."
	tween = create_tween()
	tween.tween_property(alarm_pop_up, "modulate:a", 0.0, 1.0)
	await tween.finished
