extends CharacterBody2D
var facing = -1
var dash_speed = 2200
var dashing = false
const SPEED = 300.0
const JUMP_VELOCITY = -550.0
@export var moveable = true

func _ready():
	pass
	
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if moveable:
		if not is_on_floor():
			velocity.y += gravity * delta

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		if Input.is_action_just_pressed("jump") and Global.double_jumps > 0 and is_on_floor() == false:
			velocity.y = JUMP_VELOCITY
			$double_jump.play()
			Global.double_jumps -= 1
		
		var direction = Input.get_axis("left", "right")
		if direction:
			if Input.is_action_just_pressed("click") and Global.dashes > 0:
				dashing = true	
				$dash.play()
				Global.dashes -= 1
				$dash_timer.start()
			if dashing:
				velocity.x = direction * dash_speed
			else:
				velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
			
		if is_on_floor():
			if velocity.x > 0:
				$AnimatedSprite2D.flip_h = true
				$AnimatedSprite2D.play("movement")
			elif velocity.x < 0:
				$AnimatedSprite2D.flip_h = false
				$AnimatedSprite2D.play("movement")
			else:
				$AnimatedSprite2D.play("idle")
		else:
				$AnimatedSprite2D.play("idle")
		move_and_slide()


func _on_dash_timer_timeout():
	dashing = false
