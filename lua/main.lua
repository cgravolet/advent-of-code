local day10 = require("day10")

if #arg <= 0 then
    print("Error - Missing command argument.")
    return
end

if arg[1] == "day10" then
    day10:run()
end