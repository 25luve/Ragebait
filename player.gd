extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var line: Line2D
var ray: RayCast2D
var line2: Line2D
var slow_line: Vector2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	ray=RayCast2D.new()
	add_child(ray)#Creates the RayCast line via code instead of using the editor
	ray.enabled=true#Activates the RayCast(needed beacause its crated via the code instead)
	ray.exclude_parent=true#Disables collision with the parentnode
	
	line=Line2D.new()
	add_child(line)#Creates the Line via code instead of using the editor
	line.width=3.5
	line.default_color=Color(0,1,0,1)
	
	line2=Line2D.new()
	add_child(line2)
	line2.width=2.0
	line2.default_color=Color(1,0,0,0.3)
	
func _process(delta): 
	var direction=(get_global_mouse_position()-global_position).normalized()
	var lenght=1000.0
	ray.target_position=direction*lenght
	ray.force_raycast_update()
	
	var endpoint: Vector2
	if ray.is_colliding():
		endpoint=ray.get_collision_point()
	else:
		endpoint=global_position+direction*lenght
	
	line.clear_points()
	line.add_point(Vector2.ZERO)#Vector2.ZERO, same as to_local(global_position)
	line.add_point(to_local(endpoint))
	
	slow_line=slow_line.lerp(to_local(endpoint),5.0*delta)
	
	line2.clear_points()
	line2.add_point(Vector2.ZERO)
	line2.add_point(slow_line)
	
	if Input.is_action_just_pressed("Debug"):
		line.visible = !line.visible
		
	print("collision: ", ray.is_colliding())
	print("end point: ", endpoint)
	print("start_point: ", global_position)
	print("line_points: ", line.get_point_count())
	print(slow_line)
