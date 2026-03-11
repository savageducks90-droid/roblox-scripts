local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

-- TELEPORT ROUTE
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

-- fruits to detect
local fruits = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true
}

-- radar
local function createRadar(obj)

	if obj:FindFirstChild("FruitRadar") then return end

	local part = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or obj
	if not part then return end

	local gui = Instance.new("BillboardGui")
	gui.Name = "FruitRadar"
	gui.Size = UDim2.new(0,140,0,28)
	gui.StudsOffset = Vector3.new(0,3,0)
	gui.AlwaysOnTop = true
	gui.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0,255,0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.Parent = gui

	RunService.RenderStepped:Connect(function()

		local char = player.Character
		if not char then return end

		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end

		local dist = (root.Position - part.Position).Magnitude

		label.Text = obj.Name.." ["..math.floor(dist).."m]"

	end)

end

-- scan world
local function scan()

	for _,v in pairs(workspace:GetDescendants()) do
		if fruits[v.Name] then
			createRadar(v)
		end
	end

end

workspace.DescendantAdded:Connect(function(obj)

	if fruits[obj.Name] then
		task.wait(0.1)
		createRadar(obj)
	end

end)

-- teleport function
local function teleport(pos)

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	root.CFrame = CFrame.new(pos)

end

-- route scan
task.spawn(function()

	for _,pos in ipairs(route) do

		teleport(pos)

		task.wait(2)

		scan()

	end

	print("Fruit route scan complete")

end)
