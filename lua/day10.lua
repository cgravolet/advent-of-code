local utility = require("utility")

local Day10 = {
    path = "../input/day10.txt"
}

function Day10:run()
    local f = assert(io.open(self.path, "r"))
    local s = f:read("*all")
    f:close()
    local instructions = self.make_instructions(s)
    local part1, part2 = self.solve(instructions)
    print("Part 1:\n" .. part1 .. "\n")
    print("Part 2:\n" .. part2 .. "\n")
end

function Day10.make_instructions(s)
    local instructions = {}

    for line in s:gmatch("([^\n]*)\n?") do
        local i, j = string.find(line, "-?%d+")

        if i then
            local val = line:sub(i, j)
            table.insert(instructions, {cycles = 2, value = tonumber(val)})
        else
            table.insert(instructions, {cycles = 1, value = 0})
        end
    end
    return instructions
end

function Day10.solve(ins)
    local cycle, pixels, pos, x, sum = 1, "", 0, 1, 0

    while #ins > 0 do
        if (cycle - 20) % 40 == 0 then sum = sum + x * cycle end

        -- Draw the pixel
        local pixel = "."
        if pos >= x - 1 and pos <= x + 1 then pixel = "#" end
        pixels, pos = pixels .. pixel, pos + 1

        -- Reset position if this is end of the CRT's draw distance
        if pos % 40 == 0 then
            pixels, pos = pixels .. "\n", 0
        end

        -- Apply instruction to move the register
        ins[1].cycles = ins[1].cycles - 1
        if ins[1].cycles <= 0 then
            x = x + ins[1].value
            table.remove(ins, 1)
        end
        cycle = cycle + 1
    end
    return sum, pixels
end

return Day10