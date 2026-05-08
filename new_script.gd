extends CharacterBody2D
var line: Line2D
var ray: RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ray=RayCast2D.new()
	add_child(ray)#Creates the RayCast line via code instead of using the editor
	ray.enabled=true#Activates the RayCast(needed beacause its crated via the code instead)
	ray.exclude_parent=true#Disables collision with the parentnode
	
	line=Line2D.new()
	add_child(line)#Creates the Line via code instead of using the editor
	line.width=2.0
	line.default_color=Color.RED
	line.z_index=10
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction=(get_global_mouse_position()-global_position).normalized()
	var lenght=500.0
	ray.target_position=direction*lenght
	ray.force_raycast_update()
	
	var endpoint: Vector2
	if ray.is_colliding():
		endpoint=ray.get_collision_point()
	else:
		endpoint=global_position+direction*lenght
		
	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(to_local(endpoint))
	
	print("collision: ", ray.is_colliding())
	print("end point: ", endpoint)
	print("line: ", line.get_point_count())
