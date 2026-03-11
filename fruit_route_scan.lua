local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local route = {

Vector3.new(55.9,217.1,-885.8),

Vector3.new(-132.2,178.4,-1347.2),
Vector3.new(-58.7,149.9,-1528.3),
Vector3.new(459.0,149.0,-1754.2),
Vector3.new(431.3,148.9,-1514.1),
Vector3.new(407.4,145.6,-2067.3),
Vector3.new(65.1,353.2,-1888.3),
Vector3.new(-304.2,146.0,-1798.8),
Vector3.new(-583.2,146.2,-1367.9),
Vector3.new(-652.0,276.1,-1574.2),
Vector3.new(-665.8,150.2,-1991.8),
Vector3.new(-488.6,440.3,-2133.7),
Vector3.new(-892,434.0,-2132.4),
Vector3.new(-531.2,249.0,-954.0),

Vector3.new(55.9,217.1,-885.8)

}

local items = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true,
	["Mango"] = true
}

local function scan()

	for _,v in pairs(workspace:GetDescendants()) do

		if items[v.Name] then
			print("Fruit found:",v.Name)
		end

	end

end

local function teleport(pos)

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	root.CFrame = CFrame.new(pos)

end

task.spawn(function()

	for _,pos in ipairs(route) do

		teleport(pos)

		task.wait(2)

		scan()

	end

	print("Route scan finished")

end)

print("Fruit Route Scanner Loaded")
