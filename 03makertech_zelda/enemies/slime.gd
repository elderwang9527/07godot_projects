extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

#@onready var animations = $AnimatedSprite2D
@onready var animations = $AnimationPlayer

var startPosition 
var endPosition
var isDead: bool = false

func _ready():
	startPosition = position
#	endPosition = startPosition + Vector2(0, 3*16)
	endPosition = endPoint.global_position
	
func changeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		changeDirection()
		
	velocity = moveDirection.normalized()*speed
	
func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		animations.play("walk" + direction)

func _physics_process(delta):
	if isDead: return
	updateVelocity()
	move_and_slide()
	updateAnimation()
	
func _on_hurt_box_area_entered(area):
	print("111")
	print(area.name)
	if area == $hitBox: return
	print('222')
	$hitBox.set_deferred("monitorable", false)
	print('333')
	isDead = true  
	print('444')
	animations.play("death")
	print('555')
	await animations.animation_finished
	print('666')
	queue_free()
	print('777')
	
	
