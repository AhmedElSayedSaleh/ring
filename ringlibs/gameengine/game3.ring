# The Ring Standard Library
# Game Engine for 2D Games
# 2016, Mahmoud Fayed <msfclipper@yahoo.com>
Load "gameengine.ring"

$down = 3
$gameresult = false
$Score = 0
$startplay=false
$lastcol = 0
$playerwin = false
$DoorKey = false


func main

	oGame = New Game 

	while true

	$down = 3
	$gameresult = false
	$Score = 0
	$startplay=false
	$lastcol = 0
	$playerwin = false
	$DoorKey = false

	oGame {	
		title = "Super Man 2016"
		sprite
		{
			file = "images/superman.jpg"
			x = 0 y=0 width=800 height = 600 scaled = true animate = false
			keypress = func ogame,oself,nKey {
				if nkey = key_esc 
					ogame.shutdown()
				but nKey = key_space 
					$startplay=true 
					ogame.shutdown=true 
				ok
			}
		}
		text {
			animate = false
			size = 35
			file = "fonts/pirulen.ttf"
			text = "Super Man 2016"
			x = 20	y=30
		}
		text {
			animate = false
			size = 25
			file = "fonts/pirulen.ttf"
			text = "Version 1.0"
			x = 20	y=80
		}
		text {
			animate = false
			size = 16
			file = "fonts/pirulen.ttf"
			text = "(C) 2016, Mahmoud Fayed"
			x = 20	y=120
		}

		text {
			animate = false
			size = 25
			file = "fonts/pirulen.ttf"
			text = "Press Space to start"
			x = 190	y=470
		}
		text {
			animate = false
			size = 20
			file = "fonts/pirulen.ttf"
			text = "Press Esc to Exit"
			x = 260	y=510
		}

		animate {
			file = "images/superman.png"
			x = 200
			y = 200
			framewidth = 68
			scaled = true
			height = 86
			width = 60
			nStep = 10
			transparent = true
			animate = true
			direction = ge_direction_random
			state = func oGame,oSelf {
				oSelf { 
					nStep--
					if nStep = 0
						nStep = 10
						if frame < 1
							frame++
						else
							frame=1
						ok
					ok	
					if x <= 0 x=0 ok
					if y <= 0 y=0 ok
					if x >= 750 x= 750 ok
					if y > 550 y=550 ok								
				}
			}
		}

		Sound {
			file = "sound/music2.wav"
			playSound()
		}
	}
	if $startplay 
		oGame.refresh()
		playstart(oGame) 		
		oGame.refresh()
	ok

	end


func playstart oGame

	oGame {

		Title = "Super Man 2016"
		Sprite {
			file = "images/supermancity.jpg"
			x = 0 y=0 width=800 height = 600 scaled = true animate = false
			keypress = func ogame,oself,nKey {
				if nkey = key_esc 
					ogame.shutdown()
				ok
			}
		}

		Map {
			blockwidth = 80
			blockheight = 80
			aMap = [
				 	[0,0,0,0,0,0,0,0,0,1,0,0,0,3,0,0,5,1,0,0,0,0,4,0,0,1,0,0,0],
					[0,0,4,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,4,0,0,0,0,1,0,0,0],
					[0,0,0,0,0,4,0,0,0,3,0,0,0,4,0,0,0,1,0,0,0,0,0,0,0,3,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
					[0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0],
					[0,0,2,0,0,2,0,0,2,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0],
					[0,0,1,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0]
				]
			aImages = ["images/smwall.png","images/smwallup.png",
					"images/smwalldown.png","images/smstar.png",
					"images/smkey.png","images/smstar2.png"]
			state = func oGame,oSelf {			
				if $gameresult = false
					px = oGame.aObjects[3].x
					py = oGame.aObjects[3].y
					
				ok			
			}
		}

		sprite {
			type = ge_type_enemy
			animate = false
			file  = "images/smhome.png"
			x = 2500
			y = 400
			width = 290
			height = 200
			transparent = true
			
			state = func oGame,oSelf {				
				vValue = 2500 +  oGame.aObjects[2].x 
				oself { x = vvalue }
			}
			
		}

		animate {
			file = "images/superman.png"
			x = 0
			y = 0
			framewidth = 60
			scaled = true
			height = 86
			width = 60
			nStep = 3
			transparent = true
			state = func oGame,oSelf {

				nValue = oGame.aObjects[2].getvalue(oSelf.x,oSelf.y) 
				nRow = oGame.aObjects[2].getrow(oSelf.x,oSelf.y) 
				nCol = oGame.aObjects[2].getcol(oSelf.x,oSelf.y) 

				switch nValue
				on 4 
					oGame.aObjects[2].aMap[nRow][nCol] = 6
					$Score += 100
					oGame { Sound {
						once = true
						file = "sound/sfx_point.wav"
						playSound()
					} }
				on 5
					oGame.aObjects[2].aMap[nRow][nCol] = 0
					$DoorKey = true
				off

				if not $playerwin
						oself { 
							if checkwall(oGame,oSelf,0,5)
								y += 5
							ok
							if y > 500 y=500 ok
						}				
				ok

			}
			keypress = func ogame,oself,nKey {
				if $gameresult = false
					
					oself { 
						if nkey = key_up and checkwall(oGame,oSelf,0,-40)
							y -= 40
							$down = 10
							if y<=0 y=0 ok
						but nKey = key_right and checkwall(oGame,oSelf,10,0)
							x += 10
							if x >= 440
								if oGame.aObjects[2].x > -2000
									oGame.aObjects[2].x -= 50
								else
									if x <= 750
										x += 10
									else
										x -= 10
									ok
									return
								ok
								x=400
							ok
						but nKey = key_left and checkwall(oGame,oSelf,-10,0)
							x -= 10
							if x <= 0
								x=0
								if oGame.aObjects[2].x != 0
									oGame.aObjects[2].x += 50
								ok
							ok
						ok
					}
				ok
			}
		}

		text {
			animate = false
			point = 400
			size = 30
			file = "fonts/pirulen.ttf"
			text = "Score : " + $score
			x = 500	y=10
			state = func oGame,oSelf { 			 
				oSelf { text = "Score : " + $score }  				
			}
		}

	}

func inlist nValue,aList
	for x in aList
		if x = nValue
			return true
		ok
	next
	return false

func checkwall oGame,oself,diffx,diffy

	xPos = oSelf.x + diffx
	yPos = oSelf.y + diffy
	nValue = oGame.aObjects[2].getvalue(xPos,yPos)
	nValue = inlist(nValue,[1,2,3])
	nValue = not nValue
	if nValue = 0 return nValue ok

	xPos = oSelf.x + diffx
	yPos = oSelf.y + diffy + oSelf.height
	nValue = oGame.aObjects[2].getvalue(xPos,yPos)
	nValue = inlist(nValue,[1,2,3])
	nValue = not nValue
	if nValue = 0 return nValue ok

	xPos = oSelf.x + diffx + oSelf.width
	yPos = oSelf.y + diffy
	nValue = oGame.aObjects[2].getvalue(xPos,yPos)
	nValue = inlist(nValue,[1,2,3])
	nValue = not nValue
	if nValue = 0 return nValue ok

	xPos = oSelf.x + diffx + oSelf.width
	yPos = oSelf.y + diffy + oSelf.height
	nValue = oGame.aObjects[2].getvalue(xPos,yPos)
	nValue = inlist(nValue,[1,2,3])
	nValue = not nValue
	if nValue = 0 return nValue ok

	return nValue
