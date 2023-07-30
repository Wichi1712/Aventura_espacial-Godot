extends Area2D

func destruye():
	call_deferred("queue_free")
	#queue_free()
