extends Node
var dict = {
	greet =[
		{actor = "bro", txt = "yo"},
		{actor = "dude", txt = "ayy"},
		{actor = "bro", txt = "ok"},
		{checkvar = ["a", 1], then = ["print", "lmao a is 1"], call = ["start_dialog", "another"]}],
	another = [
		{actor = "mate", txt = "sup"},
		{actor = "pal", txt = "ok"},
		{actor = "mate", txt = "no u"},
		{choice = {
			repeat = {call = ["start_dialog", "another"]}, 
			end = null}}]
}