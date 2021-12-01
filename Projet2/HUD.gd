extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Nouvelle partie ?"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)	

func show_win(score):
	show_message("VOUS AVEZ SURVECU")
	$ScoreFinal.show()
	
	#yield($MessageTimer, "timeout")

	$Message.text = "VOUS AVEZ SURVECU\nNouvelle partie ?"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()
	


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
