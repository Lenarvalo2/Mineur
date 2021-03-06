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
	$Message.hide()
	$Background.show()
	$StartButton.show()
	$Musique.show()
	$Credits.show()
	$Quitter.show()
	
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
	$Message.hide()
	$Background.show()
	$Musique.show()
	$Credits.show()
	$Quitter.show()


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$Background.hide()
	$StartButton.hide()
	$Musique.hide()
	$Credits.hide()
	$Quitter.hide()
	$Message.show()
	emit_signal("start_game")

func _on_Quitter_pressed():
	get_tree().quit()

func win_game():
	pass # Replace with function body.
