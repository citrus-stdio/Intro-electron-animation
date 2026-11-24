extends Control

@onready var grad1 = $"1/gradient"
@onready var arrow1 = $"1/arrow"
@onready var grad2 = $"2/gradient"
@onready var arrow2 = $"2/arrow"

@export var main : Node

var arrow1_speed : float = 315
var arrow2_speed : float = 150
var arrow1_dir : float = 1
var arrow2_dir : float = 1

var global_length : float = 512

func _ready() -> void:
	main.pos_change.connect(update_display)
	grad2.centered = true
	grad2.region_enabled = true
	set_length(512)
	
func update_display():
	global_length = randf_range(10.0, 512.0)
	print(global_length)
	set_length(global_length)

func set_length(length: float) -> void:
	var w = grad2.texture.get_width()
	var h = grad2.texture.get_height()
	length = clampf(length, 0.0, h)

	grad2.region_rect = Rect2(0, h - length, w, length)
	grad2.offset = Vector2(0, (h - length) / 2.0)

func _process(delta: float) -> void:
	arrow1.position.y += arrow1_speed * delta * arrow1_dir
	arrow2.position.y += arrow2_speed * delta * arrow2_dir
	
	# switch up
	if arrow1.position.y > 535:
		arrow1.position.y = 535
		arrow1_dir = -1
		
	if arrow2.position.y > 535:
		arrow2.position.y = 535
		arrow2_dir = -1
		
	# switch down
	if arrow1.position.y < 23:
		arrow1.position.y = 23
		arrow1_dir = 1
		
	if arrow2.position.y < 535 - global_length:
		arrow2.position.y = 535 - global_length
		arrow2_dir = 1
	
