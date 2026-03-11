local workspace = game:GetService("Workspace")

local fruits = {
	["Life Up Fruit"] = true,
	["Chakra Fruit"] = true
}

local function addESP(obj)

	if obj:FindFirstChild("FruitESP") then return end

	local part = obj:IsA("Model") and obj:FindFirstChildWhichIsA("BasePart") or obj
	if not part then return end

	local gui = Instance.new("BillboardGui")
	gui.Name = "FruitESP"
	gui.Size = UDim2.new(0,120,0,25)
	gui.StudsOffset = Vector3.new(0,2,0)
	gui.AlwaysOnTop = true
	gui.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0,255,0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.Text = obj.Name
	label.Parent = gui

end

local function scan()

	for _,v in pairs(workspace:GetDescendants()) do
		if fruits[v.Name] then
			addESP(v)
		end
	end

end

scan()

workspace.DescendantAdded:Connect(function(obj)

	if fruits[obj.Name] then
		task.wait(0.1)
		addESP(obj)
	end

end)
