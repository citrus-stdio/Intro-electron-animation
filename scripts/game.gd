extends Node3D

var electron = preload("res://scenes/electron.tscn")

@onready var arrow_arr = $arrow_arr
@onready var display = $"display mode mwahahah"
@onready var track1 = $"display mode mwahahah"/"1"/arrow
@onready var track2 = $"display mode mwahahah"/"2"/arrow
@onready var parent = self

var arrow = preload("res://scenes/arrow.tscn")
var new_arrow : Node3D
var current_pos : Vector3 = Vector3(2.5,2.3,-1.3)

# signals to talk to display code
signal pos_change()


func _ready() -> void:
	display.visible = false
	await get_tree().create_timer(3.0).timeout 
	display.visible = true
	
	while true:
		gen_arrow(Vector3.ZERO, current_pos, Color(0.991, 0.745, 0.73, 1.0))
		await get_tree().create_timer(3.0).timeout
		await electron_instantiate(current_pos) 

		
func electron_instantiate(pos:Vector3):
	display.process_mode = Node.PROCESS_MODE_DISABLED
	

	if track1.position.y > track2.position.y :
		var new_electron = electron.instantiate()
		parent.add_child(new_electron)
		new_electron.position = pos
		
		
		
	else:
		print("unspectactular")
	await get_tree().create_timer(3.0).timeout 
	current_pos = Vector3(
		randf_range(-3.0, 3.0),
		randf_range(-3.0, 3.0),
		randf_range(-3.0, 3.0)
		)
		
	pos_change.emit()
	for child in arrow_arr.get_children():
		child.queue_free()
	
	
	display.process_mode = Node.PROCESS_MODE_INHERIT


func gen_arrow(a:Vector3,b:Vector3,c:Color):
	var arrow_length = (a-b).length()
	new_arrow = arrow.instantiate()
	arrow_arr.add_child(new_arrow)
	new_arrow.position = a
	new_arrow.look_at(b, Vector3.UP)
	
	new_arrow.get_child(0).position = Vector3(0,0,-arrow_length)
	new_arrow.get_child(1).position = Vector3(0,0,-arrow_length*0.5)
	
	new_arrow.get_child(0).scale = Vector3(0.1,0.1,0.1)
	new_arrow.get_child(1).scale = Vector3(0.1,arrow_length/2,0.1)
	
	var mat_h = new_arrow.get_child(0).get_surface_override_material(0)
	var u_mat_h = mat_h.duplicate()
	new_arrow.get_child(0).set_surface_override_material(0,u_mat_h)
	
	var mat_s = new_arrow.get_child(1).get_surface_override_material(0)
	var u_mat_s = mat_s.duplicate()
	new_arrow.get_child(1).set_surface_override_material(0,u_mat_s)
	
	u_mat_h.albedo_color = c
	u_mat_s.albedo_color = c
	
	u_mat_h.distance_fade_min_distance = 0.0
	u_mat_h.depth_draw_mode = StandardMaterial3D.DEPTH_DRAW_ALWAYS
