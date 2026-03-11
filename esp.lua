local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local function createESP(player)
	if player == LocalPlayer then return end

	local function apply(character)

		local head = character:WaitForChild("Head")
		local humanoid = character:WaitForChild("Humanoid")

		-- GUI
		local gui = Instance.new("BillboardGui")
		gui.Name = "MiniESP"
		gui.Size = UDim2.new(0,100,0,30)
		gui.StudsOffset = Vector3.new(0,2.5,0)
		gui.AlwaysOnTop = true
		gui.Parent = head

		-- name
		local name = Instance.new("TextLabel")
		name.Size = UDim2.new(1,0,0,14)
		name.BackgroundTransparency = 1
		name.Text = player.Name
		name.TextColor3 = Color3.new(1,1,1)
		name.TextStrokeTransparency = 0
		name.Font = Enum.Font.SourceSansBold
		name.TextScaled = true
		name.Parent = gui

		-- health background
		local hpBG = Instance.new("Frame")
		hpBG.Size = UDim2.new(0.7,0,0,6)
		hpBG.Position = UDim2.new(0,0,0,16)
		hpBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
		hpBG.BorderSizePixel = 0
		hpBG.Parent = gui

		-- health bar
		local hpBar = Instance.new("Frame")
		hpBar.Size = UDim2.new(1,0,1,0)
		hpBar.BackgroundColor3 = Color3.fromRGB(255,0,0)
		hpBar.BorderSizePixel = 0
		hpBar.Parent = hpBG

		-- health text
		local hpText = Instance.new("TextLabel")
		hpText.Size = UDim2.new(0.3,0,0,10)
		hpText.Position = UDim2.new(0.72,0,0,14)
		hpText.BackgroundTransparency = 1
		hpText.TextColor3 = Color3.new(1,1,1)
		hpText.TextStrokeTransparency = 0
		hpText.Font = Enum.Font.SourceSansBold
		hpText.TextScaled = true
		hpText.Parent = gui

		RunService.RenderStepped:Connect(function()
			if humanoid then
				local hpPercent = humanoid.Health / humanoid.MaxHealth
				hpBar.Size = UDim2.new(hpPercent,0,1,0)

				hpText.Text = math.floor(humanoid.Health).."/"..math.floor(humanoid.MaxHealth)
			end
		end)

	end

	if player.Character then
		apply(player.Character)
	end

	player.CharacterAdded:Connect(apply)
end

for _,p in pairs(Players:GetPlayers()) do
	createESP(p)
end

Players.PlayerAdded:Connect(createESP)
