extends Node2D

#signal
const BASIC_LEVEL = 5
export (PackedScene) var Enemigo

var level = 0
var screensize = Vector2.ZERO
var time_left = 0
var score = 0
onready var GameOverTimer = Timer.new()


func _ready():
	randomize()
	OS.center_window()
	timer_settings()
	$HUD/GameOverLabel.visible = false
	time_left = 10
	$HUD.update_timer(time_left)
	screensize = get_viewport().get_visible_rect().size
	print(str(screensize.x) + "x" + str(screensize.y))
	spawn_enemigo()#llama a la funcion spawn_enemigo

func timer_settings():
	GameOverTimer.wait_time = 2
	GameOverTimer.connect("timeout", self, "_onGameTimer_timeout")
	add_child(GameOverTimer)


func _onGameTimer_timeout():
	get_tree().change_scene("res://menu/Menu.tscn")

func _process(delta):
	#Si numero de enemigos es igual a cero el nivel aumenta en 1
	# y vuelve a llamar a la funcion spawn_enemigo
	if $ContenEnenigo.get_child_count() == 0:
		level+=1
		time_left += 5
		spawn_enemigo()#llama a la funcion spawn_enemigo

#Crea enemigos en posicion aleatoria
func spawn_enemigo():
	for index in range(BASIC_LEVEL + level):
		var Enemy = Enemigo.instance()
		Enemy.position = Vector2(rand_range(0,screensize.x), rand_range(0,screensize.y))
		$ContenEnenigo.add_child(Enemy)


func _on_GameTimer_timeout():
	time_left -=1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		game_over()
		print("Game Over")


func _on_Player_picked():
	score += 1
	$HUD.update_score(score)


func game_over():
	$GameTimer.stop()
	$HUD/GameOverLabel.visible = true
	#$Player.get_node("AnimatedSprite").play("nave")
	$Player.game_over()
	GameOverTimer.start()
