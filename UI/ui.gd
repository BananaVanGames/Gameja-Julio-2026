extends CanvasLayer

var tween: Tween

@onready var alarm_pop_up: RichTextLabel = $AlarmPopUp


func _ready() -> void:
	alarm_pop_up.modulate.a = 0
	Events.connect("updating_alarm", _updating_alarm)
	Events.connect("stopping_alarm", _stopping_alarm)


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
