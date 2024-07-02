extends CharacterBody2D



func _on_area_2d_body_entered(body):
	if body.has_method('kill'):
		global.spike_touch = true

func _on_area_2d_body_exited(body):
	if body.has_method('kill'):
		global.spike_touch = false
