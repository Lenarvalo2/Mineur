extends KinematicBody2D
signal hit
signal fin

export (PackedScene) var Mob
export var speed = 400  # How fast the player will move (pixels/sec).
var original=speed
var screen_size  # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	$MobTimer.start()
	
func _physics_process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if (Input.is_action_pressed("ui_select")&&speed==original):
		speed=speed*3
	else:
		speed=original
	
	if velocity.length() > 0:
		
		velocity=velocity.normalized()*speed
		$AnimationTree.get("parameters/playback").travel("Walk")
		
		$AnimationTree.set("parameters/Idle/blend_position",velocity)
		$AnimationTree.set("parameters/Walk/blend_position",velocity)
		#print($AnimationTree.get("parameters/Idle/blend_position"))
		#move_and_slide(velocity)
		move_and_slide(velocity, Vector2.ZERO,
					false, 4, PI/4, false)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		#print("Collided with: ", collision.collider.name)
		if(collision.collider.name!="TileMap"&&collision.collider.name!="Door"):
			print("paf")
			emit_signal("hit")
			hide()
		elif(collision.collider.name=="Door"):
			print("fin")
			emit_signal("fin")
	#	#velocity = velocity.normalized() * speed
	#	$AnimatedSprite.play()
	#else:
	#	$AnimatedSprite.stop()
	#position += velocity * delta
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)
	#if velocity.x != 0:
	#	$AnimatedSprite.animation = "walk"
	#	$AnimatedSprite.flip_v = false
	# See the note below about boolean assignment
	#	$AnimatedSprite.flip_h = velocity.x < 0
	#elif velocity.y != 0:
	#	$AnimatedSprite.animation = "up"
	#	$AnimatedSprite.flip_v = velocity.y > 0
	
	





	
	
	



