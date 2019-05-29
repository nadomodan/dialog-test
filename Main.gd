extends Node2D

var a = 1

var txt: Dictionary
var index := -1
var convo: String
var selected := 0

func _ready():
	txt = load("res://dialog.gd").new().dict
	$Textbox/Actor.set("custom_colors/font_color", Color(1,0,0))
	start_dialog("greet")

func _process(delta):
	var select = int(Input.is_action_just_pressed("ui_down")) - int(Input.is_action_just_pressed("ui_up"))
	if select:
		var amount = $Choices/VBoxContainer.get_child_count()
		selected += select
		selected = clamp(selected, 0, amount-1)
		for i in range(amount):
			if i == selected:
				$Choices/VBoxContainer.get_child(i).set("custom_colors/font_color", Color(1,0,0))
			else: $Choices/VBoxContainer.get_child(i).set("custom_colors/font_color", Color(1,1,1))

	if Input.is_action_just_pressed("ui_accept"):
		if !$Choices.visible:
			update_dialog()
		else:
			$Choices.hide()
			if typeof(txt[convo][index]["choice"][$Choices/VBoxContainer.get_child(selected).text]) == TYPE_DICTIONARY:
				var getcall = txt[convo][index]["choice"][$Choices/VBoxContainer.get_child(selected).text].get("call")
				call(getcall[0], getcall[1])

func start_dialog(c: String):
	convo = c
	index = -1
	$Textbox.show()
	update_dialog()

func update_dialog():
	index += 1
	if !index < txt[convo].size():
		$Textbox.hide()
		return
	var getactor = txt[convo][index].get("actor")
	var gettxt = txt[convo][index].get("txt")
	var getsetvar = txt[convo][index].get("setvar")
	var getcheckvar = txt[convo][index].get("checkvar")
	var getcall = txt[convo][index].get("call")
	var getchoice = txt[convo][index].get("choice")
	if getactor: $Textbox/Actor.text = getactor
	if gettxt: $Textbox/Text.text = gettxt
	if getsetvar: set(getsetvar[0], getsetvar[1])
	if getcheckvar:
		if get(getcheckvar[0]) == getcheckvar[1]:
			call(txt[convo][index]["then"][0], txt[convo][index]["then"][1])
		elif txt[convo][index].get("else"): call(txt[convo][index]["else"][0], txt[convo][index]["else"][1])
	if getcall: call(getcall[0], getcall[1])
	if getchoice:
		for i in $Choices/VBoxContainer.get_children():
			$Choices/VBoxContainer.remove_child(i)
			i.queue_free()
		$Choices.show()
		selected = 0
		for i in getchoice.keys():
			var c = Label.new()
			c.text = i
			$Choices/VBoxContainer.add_child(c)
		$Choices/VBoxContainer.get_child(0).set("custom_colors/font_color", Color(1,0,0))

func print(o):
	print(o)