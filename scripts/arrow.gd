extends Node3D

@export var length : float
@export var identity : Vector3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func rotate_arrow(theta:float,axi:Vector3):
	var arrow_tween : Tween = create_tween()
	var arrow_axis = axi.normalized()
		
	var start_basis : Basis = global_transform.basis
	
	arrow_tween.tween_method(
		func(angle:float):
			var rotation_step : Basis = Basis(arrow_axis,angle)
			global_transform.basis = rotation_step*start_basis,
		0.0,
		theta,
		1.5
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
