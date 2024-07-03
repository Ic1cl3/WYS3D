extends CharacterBody3D
@export var gravity = 2
@export var sens = 500
@export var jh = 30
@export var spe = 15


func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x/sens
		$SpringArm3D.rotation.x -= event.relative.y/sens
		
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x,-1.75,1)


func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity
	if is_on_floor():
		velocity.y = Input.get_action_strength("space")*jh
	var input_dir = Input.get_vector("s", "w", "a", "d")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * spe
		velocity.z = direction.z * spe
	else:
		velocity.x = move_toward(velocity.x, 0, spe)
		velocity.z = move_toward(velocity.z, 0, spe)
	move_and_slide()
