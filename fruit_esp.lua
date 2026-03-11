local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local items = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true,
	["Mango"] = true
}

local function createESP(obj)

	if obj:FindFirstChild("FruitESP") then return end

	local part = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or obj
	if not part then return end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "FruitESP"
	billboard.Size = UDim2.new(0,120,0,28)
	billboard.StudsOffset = Vector3.new(0,3,0)
	billboard.AlwaysOnTop = true
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0,255,0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.Text = obj.Name
	label.Parent = billboard

end

for _,v in pairs(workspace:GetDescendants()) do
	if items[v.Name] then
		createESP(v)
	end
end

workspace.DescendantAdded:Connect(function(obj)
	if items[obj.Name] then
		task.wait(.1)
		createESP(obj)
	end
end)

print("Fruit ESP Loaded")
