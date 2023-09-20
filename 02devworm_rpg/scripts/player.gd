extends CharacterBody2D

const speed = 100
var current_dir = "none"


func _ready():
	# 如不写这个，出场时player就是单图而不是动图。
	$AnimatedSprite2D.play("front_idle")

# 在Godot游戏引擎中，delta通常表示上一帧和当前帧之间的时间间隔，以秒为单位。
func _physics_process(delta):
	player_movement(delta)
	
# 控制上下左右走动，但如果不加play_anim就无法实现动图效果。
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	# 这应该是个固定的写法，视频也没讲它的具体意义
	# add，用于处理角色或物体移动的函数。它用于处理碰撞检测、移动和滑动等物理方面的工作。如碰到墙壁就停止或者滑走slide。
	move_and_slide()
	
	
# 实现动图效果。
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		# 镜像翻转的意思，这样一张图片就能实现左右行走。
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement ==0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true  
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if dir == "down":
		# 因为上下行走本来就是不同图片，所以其实可以不设置这个，只是视频里这样设置了所以就保留下来。
		anim.flip_h = true
		if movement == 1:
			anim.play('front_walk')
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		# 因为上下行走本来就是不同图片，所以其实可以不设置这个，只是视频里这样设置了所以就保留下来。
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
			
			
