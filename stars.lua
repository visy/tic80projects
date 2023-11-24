-- title:   game title
-- author:  game developer, email, etc.
-- desc:    short description

t=0
x=96
y=24

stars = {}
starcount = 1024

cam = {
	x = 0,
	y = 0
}

min_z = 15
max_z = 50

function draw_space()
	cls(0)
end

function draw_stars()

	table.sort(stars, function(a, b) return a.z > b.z end)

	local xo = -128
	local yo = -64

	local zz = 5+math.cos(time()*0.0001)*8

	for i=1,starcount do
		local s = stars[i]
		local angle = math.cos(time()*0.0001+math.sin(time()*0.0001)+s.z*0.004)*3.14
		local sin = math.sin(angle)*zz
		local cos = math.cos(angle)*zz

		s.xrot = ((xo+s.x)*cos - (yo+s.y)*sin)
		s.yrot = ((yo+s.y)*cos + (xo+s.x)*sin)
	
		s.xrot = s.xrot-xo	
		s.yrot = s.yrot-yo	
		s.z = s.z-1
		s.z=s.z % 256

		local proj_z = s.z / max_z
		
		local pos = {
			x = (128-s.xrot) / proj_z,
			y = (64-s.yrot) / proj_z
		}

		local size = s.size / proj_z
		elli(128+pos.x - size / 2, 64+pos.y - size / 2, size, size,16-s.z/32)
	end
end

function draw()
	draw_space()
	draw_stars()
end

function init()
	for i=1,starcount do
		local s = {
		 size=2,
			x=math.random()*320,
			y=math.random()*128,
			z=32*math.random() * (max_z - min_z) + min_z
		}
		table.insert(stars,s)
	end
end

function update()

end

init()

function TIC()

	draw()
	update()
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

-- <SCREEN>
-- 000:00000000000000000000000000000000000d0000000000800000000000000000000000000000000000000000000000a000000000000090000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000
-- 001:0000000000000000000000000000000000ddd00000000000000000000000008000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 002:00000000000000000000000000000000000d0000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 004:000000000000000000000000000000000a0b000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000000000000000000000
-- 006:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000
-- 009:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d00
-- 010:00000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000b00000000000a00000000000000000800000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000ddd0
-- 011:00000000000000000000000000a0000000000000000000000000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000d00
-- 012:00000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:0000000000000a00000000000000000000000000000000000c0000000000000000000000000090008000000000000000000000000b0000000000000008000000000008000000000000000000090000000000b000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00
-- 015:00000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000a0000090000000000000000000b0000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 016:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000000000000000000000000000000000000000000000000000000000
-- 017:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000
-- 018:000000000000000000000000000000000000000000000000000000000000000900000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900
-- 019:000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000
-- 020:0000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 021:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 022:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000c0000000000000
-- 023:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b800000000000000000009000000000000000000000000000c0000000000000000000000000000000000000000000
-- 024:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000800000000000000000000000000000000000000000090000000000000000000000000
-- 025:000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 026:0000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000a0000009000000000000000000000
-- 027:0000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 028:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 029:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 030:00000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000d0000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 031:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 032:000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000b08000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 033:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 035:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000900000000000090000000
-- 036:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000b00000000000000009000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000
-- 037:00000000000c00000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000d000000000000000000000000000090000000000000000000000000000
-- 038:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000ddd00000000000000000000000000000000000000000000000000000000
-- 039:00000000000000000000000000000c0000000a0000000000000000000000000000000000000000000000000000000000000000000a000a000000000000000000000000900000000000000000000000000000900000000000000000d000000000009000000000080000000000000000000000000000000000
-- 040:0000000000000000000000000000000000000000000000000000000000000000000000090000000000000000a0000000000008000900000000000000000b000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000c00000000000
-- 041:00000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000
-- 044:00000000000000000000000000000000000000000000000000b0000000000000000000000090000000000000000000a000000000000000000000000000000000090000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000a000
-- 045:000000000000000000000000000000000000000000000000000000000000000aa000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 046:00000000000000000000900000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 047:000000000c00000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 048:00000000ccc0000000000000000000000000000000000000080000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 049:000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000a000000000000
-- 050:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000008000000000000000000000000
-- 051:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000008000000000
-- 052:00000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000
-- 053:0000000000000000000a00000000000000000000000000000000a000000000900000000000000900000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000b000000000000000000000000000000000
-- 054:000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 055:000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000800000000000000000008000000000000000000000000000
-- 056:000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000
-- 057:000000900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000090000000
-- 058:0000000eee0000000000000008000000000000000090000000000000000b000000e0000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 059:000000eeeee000000000000000000000000000000000000000000000000000000eee0000000000000000000000000b000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 060:000000eeeee00000a0000000000000000000000000000000000000000000000000e0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000009000000000000000000000
-- 061:000000eeeee000000000000000000000800000000000000000000000009000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 062:0000000eee000000000000000000000000000000000000000000000000000008000000000009000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b00000000000000000000a0000000000000
-- 063:0000000000b000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000
-- 064:000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000a000000000008800000000000000000000000b000000000000000
-- 065:0000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000800000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000800000000
-- 066:0000000000000000000000000000000000000000000000000000800000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000
-- 067:0000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000008000000000000000000000000
-- 068:900000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000b0000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 069:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 070:0000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000008000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000
-- 071:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 072:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 073:000000000000000000000000000000000000000000000000000000000000000000b800000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000aa000008000000000000000000000000000000000000000000000000000000000000000000
-- 074:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000800000000000000000000000000000000000000000
-- 075:000000000000000000000000000000000090000000000000000090000080000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000
-- 076:000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd000000000000000000000000000000000c000000000000000000000000009000000000000000000000000000000000000000000000090000000000000
-- 077:0000000000000000000000000000000000000000000000000000000c00080000000000000000000000b0000000000000000000000000000000000d000000000000000000000000000000000090000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000
-- 078:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 079:080000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 080:000000000000000000000000000d00000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000
-- 081:00000000000000000000000000ddd000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000
-- 082:000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000009000000000000000000000000000000000000000000000000008000
-- 083:0000000000000000000a0000000000000000000000000000000000000000000000000008000000000000090000000000000000000000000000000000000000000000000000000000000000000a00000000000000000800000000000000000000000000000000000000000000000000000000000000000000
-- 084:0000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000a00000
-- 085:0000000000000900000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000
-- 086:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000
-- 087:000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000c000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000
-- 088:0000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000
-- 089:0000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000a00090000000000000000000000000000000080000000000000000000000000000000000000000000000000000
-- 090:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000
-- 091:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000
-- 092:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000
-- 093:0000000000000000000000000000000000000000000000b00000000000b000000000000000000b000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 095:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000a0000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 096:0000000000b0000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000
-- 097:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000c00000000000a000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000
-- 098:0000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000ccc00000000000800000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000
-- 099:000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000a0000000000000000000000000000000000c0000000000000000000090000000000000a0000000000000000000090000000000000000000000000000000000000000000000000000
-- 100:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000
-- 101:000000000000000000000000000000000090000000000000000000000000000a00000000000000000000000000000000000000000000a00000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 102:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000008000000000000000000
-- 103:00000a0000000000000000000000000000000000000000000000000000000090000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 104:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000000000d0000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000
-- 105:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000
-- 106:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000a0000000000000000000000000000000000900000000000000000000000000000000000b00000000000000
-- 107:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000
-- 108:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000
-- 109:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 110:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000009000000000000000000000000000000000000000000000000000000000b00008000000000000000000000000000000000000000000000000000
-- 111:000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 112:00ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 113:000d0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000a0080000000000000000
-- 114:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000a0000000
-- 115:00000000000000000000000000000000000000a00000000000000000b000000000000000b00000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 116:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b08000000000000000000000000000000000000000000008000000000000000000
-- 117:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000000000
-- 118:c000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000009000000000000000000000000800000000000080000000000000000000000000000000000000000000000000000000000000000000000000c0
-- 119:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000
-- 121:0000000000000000000000000000000000000000000000000a00000000000000b0000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000b0000000000
-- 122:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 123:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000009000000000000000000000000000000000000000000000
-- 124:00000000000000000000000000000000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 125:000000000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000008000000b00000000000000000000000000000000000
-- 126:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 127:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b0000000000000000000000000000000000000000b0000000000000000000000000000000000a00000000900000000000000000000000000000000000000000000000000000
-- 128:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000080000000000000000000000000000000008
-- 129:00000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 130:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 131:0000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000090000000000000000000000000000000000000
-- 132:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000900000000000000000000000000000000000000000000000000000000000000000000000000
-- 133:00000000000000000000000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 134:0000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000
-- 135:00000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000eee00000000000000000000000000000000000000000000000000000000000000000000900000000000
-- </SCREEN>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

