-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description
-- site:    website link
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

-- TIC-80 lua test program

t=0
x=96
y=24

function BDR(row)
 if (row > 3 and row < 140) then
  poke(0x03FF8,((math.floor(row+sy-sq-4)>>math.floor(sq*0.09)) % 2)*12)
 else
  if (row <= 3) then
		poke(0x03FF8,row)
		else
		poke(0x03FF8,-1-row)
		end
 end
	
	for x = 0, 240 do
 local c =	pix(x,row)
 if (c == 2) then pix(x,row,c*x*0.1+row*0.1) end
	end

end


function drawBackground()
	-- add scroll offset

-- sy = 0
	cls(0)
	for i=0,18 do


		for j=0,12 do
			-- with scroll offset, line  0

			rect(i*sq-sx,j*sq-sy,sq/2,sq/2,12)
			-- scroll offset, line 1
			rect(sq/2+i*sq-sx,j*sq+sq/2-sy,sq/2,sq/2,12)
		end
	end
end

function TIC()

	ss = 0.05
	sq = 64
	sx = math.floor(time()*ss) % sq
	sy = math.floor(time()*-ss) % sq

	if btn(0) then y=y-1 end
	if btn(1) then y=y+1 end
	if btn(2) then x=x-1 end
	if btn(3) then x=x+1 end

	cls(13)

	drawBackground()

	t=t+1


	for i = 0, 8 do
	cc = 8
	texti = "Full!"
 xzs = 120-(4.7*cc*#texti)/2
 yzs = (140/2)-(cc*7)/2
 
 xzs = xzs + math.sin(time()*0.005-i*0.1)*20
 yzs = yzs + math.cos(time()*0.005-i*0.1)*20

	print(texti, xzs, yzs, 13-i, false, cc, false)

	end

	print(texti, xzs+1, yzs+1, 2, false, cc, false)

end

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

