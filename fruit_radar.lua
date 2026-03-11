local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local fruits = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true
}

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

		if not player.Character then return end
		local root = player.Character:FindFirstChild("HumanoidRootPart")
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

scan()

workspace.DescendantAdded:Connect(function(obj)

	if fruits[obj.Name] then
		task.wait(0.1)
		createRadar(obj)
	end

end)
