extends MeshInstance3D
@onready var base = $"../.."
@onready var p = base.position
var dirgain = Vector3.ZERO


func _process(delta):
	if p != base.position:
		var input_dir = Input.get_vector("d", "a", "s", "w")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			dirgain.x = direction.x *0.15
			dirgain.z = direction.z *0.15
		p = base.position
	else:
		dirgain.x = 0
		dirgain.z = 0
	if rotation != dirgain:
		rotation.x += (dirgain.x - rotation.x) * 0.1
		rotation.z += (dirgain.z - rotation.z) * 0.1
	$"../leye".rotation = rotation * 2
	$"../reye".rotation = rotation * 2
