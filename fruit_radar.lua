local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local items = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true,
	["Mango"] = true
}

local function createRadar(obj)

	if obj:FindFirstChild("FruitRadar") then return end

	local part = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or obj
	if not part then return end

	local gui = Instance.new("BillboardGui")
	gui.Name = "FruitRadar"
	gui.Size = UDim2.new(0,140,0,30)
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

for _,v in pairs(workspace:GetDescendants()) do
	if items[v.Name] then
		createRadar(v)
	end
end

workspace.DescendantAdded:Connect(function(obj)
	if items[obj.Name] then
		task.wait(.1)
		createRadar(obj)
	end
end)

print("Fruit Radar Loaded")
