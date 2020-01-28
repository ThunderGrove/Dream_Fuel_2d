extends Control

var rng=RandomNumberGenerator.new()#use to create random numbers.
var waitingforturn=5#lower than 0 triggers next turn calculation. This value starts higher than the list index of the last teammate to avoid the turn handler tigger turns until team and enemies are loaded (test shows that it can take up to 0,25 sec to load).
var actionId=-1
var posibelEnemyList=[
	{
		ename="slime",
		hp=100,
		atk_min=1,
		atk_max=2,
		speed=2,
		speedcounter=0
	},
	{
		ename="beetle",
		hp=50,
		atk_min=1,
		atk_max=3,
		speed=10,
		speedcounter=0
	},
	{
		ename="ogre",
		hp=150,
		atk_min=1,
		atk_max=3,
		speed=8,
		speedcounter=0
	},
	{
		ename="shade",
		hp=1000,
		atk_min=1,
		atk_max=10,
		speed=9,
		speedcounter=0
	},
	{
		ename="giant",
		hp=1250,
		atk_min=10,
		atk_max=25,
		speed=3,
		speedcounter=0
	}
]
var tm_speedcounter=[0,0,0,0,0]
var enemyList=[]
onready var enemyGUIlist=get_node("Background/EnemyList")
onready var logGUIlist=get_node("Background/CombatLog")
onready var team=get_node("../../..").team

func _ready():
	return

func _on_Combat_visibility_changed():
	if get_node(".").visible:
		var amountOfEnemies=rng.randi_range(1,10)
		print(amountOfEnemies)
		for i in range(amountOfEnemies):
			var generateEnemy=rng.randi_range(0,10)
			print(generateEnemy)
			if generateEnemy<3:
				enemyList.append(posibelEnemyList[0])
			elif generateEnemy<6:
				enemyList.append(posibelEnemyList[1])
			elif generateEnemy<7:
				enemyList.append(posibelEnemyList[2])
			elif generateEnemy<9:
				enemyList.append(posibelEnemyList[3])
			elif generateEnemy<11:
				enemyList.append(posibelEnemyList[4])
		for i in range(enemyList.size()):
			enemyGUIlist.add_item(str(i)+" "+enemyList[i]["ename"],null,true)
		waitingforturn=-1
		get_node("../../../BGaudio").stop()
		$CombatMusic.play(0)

func _process(delta):
	if $".".visible:
		if waitingforturn<0:
			for i in range(tm_speedcounter.size()):
				if waitingforturn<0:
					if tm_speedcounter[i]>99:
						tm_speedcounter[i]-=100
						waitingforturn=i
						$Background/ActionContainer.visible=true
						$Background/ActionContainer/AtkBtn.disabled=false
						if i==0:
							$Background/TurnIndicator1.visible=true
						elif i==1:
							$Background/TurnIndicator2.visible=true
						elif i==2:
							$Background/TurnIndicator3.visible=true
						elif i==3:
							$Background/TurnIndicator4.visible=true
						elif i==4:
							$Background/TurnIndicator5.visible=true
			if waitingforturn<0:
				for i in range(enemyList.size()):
					if enemyList[i]["speedcounter"]>99:
						if enemyList[i]["hp"]>0:
							enemyAtk(i)
						enemyList[i]["speedcounter"]=enemyList[i]["speedcounter"]-100
				for i in range(tm_speedcounter.size()):
					if team[i]["hp"]>0:
						tm_speedcounter[i]+=team[i]["speed_total"]
				for i in range(enemyList.size()):
					enemyList[i]["speedcounter"]+=enemyList[i]["speed"]
		elif waitingforturn==0:
			if actionId==0:
				basicAtk(0)
		elif waitingforturn==1:
			if actionId==0:
				basicAtk(1)
		elif waitingforturn==2:
			if actionId==0:
				basicAtk(2)
		elif waitingforturn==3:
			if actionId==0:
				basicAtk(3)
		elif waitingforturn==4:
			if actionId==0:
				basicAtk(4)

func enemyAtk(eid):
	var target=rng.randi_range(0,4)
	print(team[target]["hp"])
	while team[target]["hp"]<=0:
		target=rng.randi_range(0,4)
	var damage=rng.randi_range(enemyList[eid]["atk_min"],enemyList[eid]["atk_max"])
	team[target]["hp"]=team[target]["hp"]-damage
	logGUIlist.add_item(str(eid)+" "+enemyList[eid]["ename"]+" hits "+team[target]["cname"]+" for "+str(damage)+" damage.",null,false)
	$Background/tm1hp.text="HP: "+str(team[0]["hp"])
	$Background/tm2hp.text="HP: "+str(team[1]["hp"])
	$Background/tm3hp.text="HP: "+str(team[2]["hp"])
	$Background/tm4hp.text="HP: "+str(team[3]["hp"])
	$Background/tm5hp.text="HP: "+str(team[4]["hp"])
	var deadcounter=0
	for i in range(team.size):
		if team[i]["hp"]<=0:
			deadcounter+=1
	if deadcounter==5:
		get_node("../GameOver").visible=true
		get_node("../GameOver/GameOverAudio").play(0)
		$CombatMusic.stop()
		$".".visible=false

func basicAtk(tmId):
	var damage=rng.randi_range(10+(team[tmId]["strength_total"]/10),50+(team[tmId]["strength_total"]/6))
	var selectedEnemy=enemyGUIlist.get_selected_items()
	enemyList[selectedEnemy[0]]["hp"]-=damage
	logGUIlist.add_item(str(tmId)+" "+team[tmId]["cname"]+" hits "+enemyList[selectedEnemy[0]]["ename"]+" for "+str(damage)+" damage.",null,false)
	if enemyList[selectedEnemy[0]]["hp"]<1:
		enemyGUIlist.set_item_disabled(selectedEnemy[0],true)
		enemyGUIlist.unselect_all()
		logGUIlist.add_item(enemyList[selectedEnemy[0]]["ename"]+" has been killed",null,false)
	waitingforturn=-1
	$Background/ActionContainer.visible=false
	$Background/ActionContainer/AtkBtn.disabled=true
	actionId=-1
	if tmId==0:
		$Background/TurnIndicator1.visible=false
	if tmId==1:
		$Background/TurnIndicator2.visible=false
	if tmId==2:
		$Background/TurnIndicator3.visible=false
	if tmId==3:
		$Background/TurnIndicator4.visible=false
	if tmId==4:
		$Background/TurnIndicator5.visible=false
	var deadcounter=0
	for i in range(enemyList.size()):
		if enemyList[i]["hp"]<0:
			deadcounter+=1
	if deadcounter==enemyList.size():
		var expGain=0
		for i in range(enemyList.size()):
			expGain+=enemyList[i]["atk_max"]*10
		get_node("../../..").xp+=expGain
		enemyGUIlist.clear()
		enemyList.clear()
		logGUIlist.clear()
		waitingforturn=5
		get_node(".").visible=false
		get_node("..").in_combat=false
		get_node("..").moveLock=false
		get_node("../../../BGaudio").play(0)
		$CombatMusic.stop()