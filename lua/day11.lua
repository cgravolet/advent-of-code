Day11 = {
    path = "../input/day11.txt"
}

function Day11:run()
    local f = assert(io.open(self.path, "r"))
    local s = f:read("*all")
    f:close()
    print(self.path)
    print(s)
end

Day11:run()