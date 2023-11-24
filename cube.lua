-- title:  3D Mesh Renderer
-- author: ChatGPT
-- desc:   Renders a 3D object with unique color for each face
-- script: lua

local cube_mesh = {
    vertices = {
        {-1, -1, -1}, {1, -1, -1}, {1, 1, -1}, {-1, 1, -1},
        {-1, -1, 1}, {1, -1, 1}, {1, 1, 1}, {-1, 1, 1}
    },
    faces = {
        {1, 2, 3, 4}, -- Back
        {5, 6, 7, 8}, -- Front
        {1, 5, 8, 4}, -- Left
        {2, 6, 7, 3}, -- Right
        {1, 2, 6, 5}, -- Bottom
        {4, 3, 7, 8}  -- Top
    },
    colors = {
        {1, 0.5, 0}, -- Red
        {0, 1, 0.2}, -- Green
        {0.1, 0.4, 0}, -- Blue
        {0, 0, 0.5}, -- Yellow
        {1, 0, 1}, -- Magenta
        {0, 1, 1}  -- Cyan
    }
}

function project_vertex(v, camera_distance)
    local x, y, z = v[1], v[2], v[3]
    return {
        x * camera_distance / (camera_distance + z)*10 + 120,
        y * camera_distance / (camera_distance + z)*10 + 68,
        z
    }
end

function draw_face(vertices, color)
    for i = 1, #vertices - 2 do
        local v1, v2, v3 = vertices[1], vertices[i + 1], vertices[i + 2]
        tri(v1[1], v1[2], v2[1], v2[2], v3[1], v3[2], color)
    end
end

function rotate(vertices, angle_x, angle_y, angle_z)
    local rotated_vertices = {}
    local cos_x, sin_x = math.cos(angle_x), math.sin(angle_x)
    local cos_y, sin_y = math.cos(angle_y), math.sin(angle_y)
    local cos_z, sin_z = math.cos(angle_z), math.sin(angle_z)

    for _, vertex in ipairs(vertices) do
        local x, y, z = vertex[1], vertex[2], vertex[3]

        -- Rotate around the X axis
        local x1, y1, z1 = x, y * cos_x - z * sin_x, y * sin_x + z * cos_x

        -- Rotate around the Y axis
        local x2, y2, z2 = x1 * cos_y - z1 * sin_y, y1, x1 * sin_y + z1 * cos_y

        -- Rotate around the Z axis
        local x3, y3, z3 = x2 * cos_z - y2 * sin_z, x2 * sin_z + y2 * cos_z, z2

        table.insert(rotated_vertices, {x3, y3, z3})
    end

    return rotated_vertices
end


function average_projected_z(projected_vertices, face_indices)
    local total_z = 0
    for _, vertex_index in ipairs(face_indices) do
        total_z = total_z + projected_vertices[vertex_index][3]
    end
    return total_z / #face_indices
end




function render_mesh(mesh, rotated_vertices, camera_distance)
    local projected_faces = {}
    local projected_vertices = {}

    for _, vertex in ipairs(rotated_vertices) do
        table.insert(projected_vertices, project_vertex(vertex, camera_distance))
    end

    for i, face in ipairs(mesh.faces) do
        local avg_z = average_projected_z(projected_vertices, face)
        table.insert(projected_faces, {face_index = i, vertices = projected_vertices, avg_z = avg_z})
    end

    table.sort(projected_faces, function(a, b) return a.avg_z > b.avg_z end)

    for _, face_data in ipairs(projected_faces) do
        local projected_face_vertices = {}
        for _, vertex_index in ipairs(mesh.faces[face_data.face_index]) do
            table.insert(projected_face_vertices, face_data.vertices[vertex_index])
        end
        local r, g, b = mesh.colors[face_data.face_index][1], mesh.colors[face_data.face_index][2], mesh.colors[face_data.face_index][3]
        local face_color = ((r + g + b) / 3) * 16
        for i = 1, #projected_face_vertices - 2 do
            local v1, v2, v3 = projected_face_vertices[1], projected_face_vertices[i + 1], projected_face_vertices[i + 2]
            local x1, y1, z1 = v1[1], v1[2], v1[3]
            local x2, y2, z2 = v2[1], v2[2], v2[3]
            local x3, y3, z3 = v3[1], v3[2], v3[3]
            tri(x1, y1, x2, y2, x3, y3, face_color)        end
    end
end

local angle_x = 0
local angle_y = 0
local angle_z = 0

function generate_random_positions(count, position_range)
    local positions = {}
    for _ = 1, count do
        local x = math.random() * position_range * 2 - position_range
        local y = math.random() * position_range * 2 - position_range
        local z = math.random() * position_range * 2 - position_range
        table.insert(positions, {x, y, z})
    end
    return positions
end

local random_positions = generate_random_positions(64, 5)


function average_z(vertices)
    local total_z = 0
    for _, vertex in ipairs(vertices) do
        total_z = total_z + vertex[3]
    end
    return total_z / #vertices
end


local random_positions = generate_random_positions(64, 5)

function combine_meshes(meshes)
    local combined_mesh = {vertices = {}, faces = {}, colors = {}}
    local vertex_offset = 0

    for _, mesh in ipairs(meshes) do
        for _, vertex in ipairs(mesh.vertices) do
            table.insert(combined_mesh.vertices, vertex)
        end

        for _, face in ipairs(mesh.faces) do
            local offset_face = {}
            for _, vertex_index in ipairs(face) do
                table.insert(offset_face, vertex_index + vertex_offset)
            end
            table.insert(combined_mesh.faces, offset_face)
        end

        for _, color in ipairs(mesh.colors) do
            table.insert(combined_mesh.colors, color)
        end

        vertex_offset = vertex_offset + #mesh.vertices
    end

    return combined_mesh
end

function generate_random_positions(count, position_range)
    local positions = {}
    for _ = 1, count do
        local x = math.random() * position_range * 2 - position_range
        local y = math.random() * position_range * 2 - position_range
        local z = math.random() * position_range * 2 - position_range
        table.insert(positions, {x, y, z})
    end
    return positions
end

function TIC()
    cls()
    angle_x = angle_x + 0.01
    angle_y = angle_y - 0.05
    angle_z = angle_z + 0.01

local cubes = {}
for i = 1, time()*0.01 do
    local x = random_positions[i][1]
    local y = random_positions[i][2]
    local z = random_positions[i][3]

    local mesh_instance = {
        vertices = {},
        faces = cube_mesh.faces,
        colors = cube_mesh.colors
    }
    for _, vertex in ipairs(cube_mesh.vertices) do
        table.insert(mesh_instance.vertices, {vertex[1] + x, vertex[2] + y, vertex[3] + z})
    end
    table.insert(cubes, mesh_instance)
end

    local combined_mesh = combine_meshes(cubes)
    local rotated_vertices = rotate(combined_mesh.vertices, angle_x, angle_y, angle_z)
    render_mesh(combined_mesh, rotated_vertices, 100)

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

