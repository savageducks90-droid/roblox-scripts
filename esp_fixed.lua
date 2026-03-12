local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local function createESP(player)

	if player == LocalPlayer then return end

	local function apply(character)

		local head = character:WaitForChild("Head",5)
		local humanoid = character:WaitForChild("Humanoid",5)

		if not head or not humanoid then return end

		if head:FindFirstChild("MiniESP") then
			head.MiniESP:Destroy()
		end

		local gui = Instance.new("BillboardGui")
		gui.Name = "MiniESP"
		gui.Size = UDim2.new(0,100,0,30)
		gui.StudsOffset = Vector3.new(0,2.5,0)
		gui.AlwaysOnTop = true
		gui.Parent = head

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1,0,0,14)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = player.Name
		nameLabel.TextColor3 = Color3.new(1,1,1)
		nameLabel.TextStrokeTransparency = 0
		nameLabel.Font = Enum.Font.SourceSansBold
		nameLabel.TextScaled = true
		nameLabel.Parent = gui

		local hpBG = Instance.new("Frame")
		hpBG.Size = UDim2.new(0.7,0,0,6)
		hpBG.Position = UDim2.new(0.15,0,0,16)
		hpBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
		hpBG.BorderSizePixel = 0
		hpBG.Parent = gui

		local hpBar = Instance.new("Frame")
		hpBar.Size = UDim2.new(1,0,1,0)
		hpBar.BackgroundColor3 = Color3.fromRGB(255,0,0)
		hpBar.BorderSizePixel = 0
		hpBar.Parent = hpBG

		local connection
		connection = RunService.RenderStepped:Connect(function()

			if humanoid.Health <= 0 then
				connection:Disconnect()
				return
			end

			local hpPercent = humanoid.Health / humanoid.MaxHealth
			hpBar.Size = UDim2.new(hpPercent,0,1,0)

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

print("ESP Loaded")
