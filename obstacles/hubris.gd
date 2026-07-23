extends StaticBody2D

@export var polygon: CollisionPolygon2D

@onready var polygon_2d: Polygon2D = $Polygon2D
@onready var col_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D


func _ready() -> void:
	polygon_2d.polygon = col_polygon_2d.polygon
