extends CharacterBody2D
var line: Line2D

# Called when the node enters the scene tree for the first time.
func _ready():
	line = Line2D.new()
	add_child(line)
	line.width = 5.0
	line.default_color = Color.RED
	line.add_point(Vector2(0, 0))
	line.add_point(Vector2(100, 0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
