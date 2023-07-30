extends Area2D

# signal
signal picked

var velocity = Vector2.ZERO
var speed = 350

func _ready():
	OS.center_window()#centrar ventana
	#position = Vector2(200,300)

func _process(delta):
	get_input()
	position += velocity * delta
	
	position.x = clamp(position.x,0,480)
	position.y = clamp(position.y,0,720)
	
	#Este codigo se sustituye por clamp
	#if position.x > 480:
	#	position.x = 480
	#if position.x < 0:
	#	position.x = 0
	#if position.y > 720:
	#	position.y = 720
	#if position.y < 0:
	#	position.y = 0
	
	process_animation()
	
func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		print("izquierda")
		#position.x += -20 * delta
		velocity.x = -1
	if Input.is_action_pressed("ui_right"):
		print("derecha")
		#position.x += 20 * delta
		velocity.x = 1
	if Input.is_action_pressed("ui_up"):
		print("arriba")
		#position.y += -20 * delta
		velocity.y = -1
	if Input.is_action_pressed("ui_down"):
		print("abajo")
		#position.y += 20 * delta
		velocity.y = 1
	#else:
		#print("No se esta pulsando teclas")
		#pass
		
	if velocity.length() > 0:
		#print(velocity.length())
		velocity = velocity.normalized() * speed


func process_animation():
	#animacion del personaje
	
	#Se anima en cualquier direccion
#	if velocity.length()!= 0:
#		#get_node("AnimatedSprite").play("run")
#		$AnimatedSprite.play("naveLateral")#a cambio de get_node
#		if velocity.x < 0:
#			$AnimatedSprite.flip_h = true
#		else:
#			$AnimatedSprite.flip_h = false
#	else:
#		$AnimatedSprite.play("nave")

	#Esta seria la forma de animar solo en el eje x de forma larga
#	if velocity.length()!= 0:
#		#get_node("AnimatedSprite").play("run")
#		#$AnimatedSprite.play("naveLateral")#a cambio de get_node
#		if velocity.x < 0:
#			get_node("AnimatedSprite").play("run")
#			$AnimatedSprite.play("naveLateral")#a cambio de get_node
#			$AnimatedSprite.flip_h = true
#		elif velocity.x > 0:
#			get_node("AnimatedSprite").play("run")
#			$AnimatedSprite.play("naveLateral")#a cambio de get_node
#			$AnimatedSprite.flip_h = false
#	else:
#		$AnimatedSprite.play("nave")
	
	
	#Esta seria la forma de animar solo en el eje x de forma corta
	if velocity.x != 0:
		#get_node("AnimatedSprite").play("naveLateral")
		$AnimatedSprite.play("naveLateral")#a cambio de get_node
		if velocity.x < 0:
			$AnimatedSprite.flip_h = true
		elif velocity.x > 0:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("nave")


func _on_Player_area_entered(area):
	if area.is_in_group("enemigo"):
		print("colision")
		if area.has_method("destruye"):
			area.destruye()
			emit_signal("picked")


func game_over():
	set_process(false)
	$AnimatedSprite.animation = "naveExplosion"
