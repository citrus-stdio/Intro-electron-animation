extends Camera3D
class_name camera_script

@export var target: Node3D
@export var distance: float = 15
@export var orbit_speed: float = 1.5
@export var vertical_speed: float = 1.5
@export var height : float = 30
@export var elevation_speed : float = 15
@export var orbit_distance_velocity = 15

var angle: float = 0
var vertical_angle : float = 0

func _ready():
	self.position = Vector3(0,height,0)
func _process(delta):
	if target:
		angle += orbit_speed * delta
		# Convert spherical coordinates to Cartesian coordinates
		var x = target.global_position.x + distance * cos(vertical_angle) * cos(angle)
		var y = target.global_position.y + distance * sin(vertical_angle)
		var z = target.global_position.z + distance * cos(vertical_angle) * sin(angle)
		
		global_position = Vector3(x, y, z)
		look_at(target.global_position, Vector3.UP)
			
			
