extends Node

signal updating_alarm(value: float)
signal stopping_alarm

func update_alarm(value: float) -> void:
	updating_alarm.emit(value)


func stop_alarm() -> void:
	stopping_alarm.emit()
