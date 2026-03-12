local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local function createESP(player)

	if player == LocalPlayer then return end

	local function apply(character)

		local head = character:WaitForChild("Head",5)
		local humanoid = character:WaitForChild("Humanoid",5)

		if not head or not humanoid then return end

		-- remove old ESP
		local old = head:FindFirstChild("MiniESP")
		if old then
			old:Destroy()
		end

		local gui = Instance.new("BillboardGui")
		gui.Name = "MiniESP"
		gui.Size = UDim2.new(0,120,0,40)
		gui.StudsOffset = Vector3.new(0,2.5,0)
		gui.AlwaysOnTop = true
		gui.Parent = head

		------------------------------------------------
		-- NAME
		------------------------------------------------

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1,0,0,16)
		nameLabel.BackgroundTransparency = 1
		nameLabel.Text = player.DisplayName.." (@"..player.Name..")"
		nameLabel.TextColor3 = Color3.new(1,1,1)
		nameLabel.TextStrokeTransparency = 0
		nameLabel.Font = Enum.Font.SourceSansBold
		nameLabel.TextScaled = true
		nameLabel.Parent = gui

		------------------------------------------------
		-- HEALTH BAR BG
		------------------------------------------------

		local hpBG = Instance.new("Frame")
		hpBG.Size = UDim2.new(0.75,0,0,6)
		hpBG.Position = UDim2.new(0.125,0,0,20)
		hpBG.BackgroundColor3 = Color3.fromRGB(40,40,40)
		hpBG.BorderSizePixel = 0
		hpBG.Parent = gui

		------------------------------------------------
		-- HEALTH BAR
		------------------------------------------------

		local hpBar = Instance.new("Frame")
		hpBar.Size = UDim2.new(1,0,1,0)
		hpBar.BackgroundColor3 = Color3.fromRGB(255,0,0)
		hpBar.BorderSizePixel = 0
		hpBar.Parent = hpBG

		------------------------------------------------
		-- HP TEXT
		------------------------------------------------

		local hpText = Instance.new("TextLabel")
		hpText.Size = UDim2.new(1,0,0,12)
		hpText.Position = UDim2.new(0,0,0,28)
		hpText.BackgroundTransparency = 1
		hpText.TextColor3 = Color3.new(1,1,1)
		hpText.TextStrokeTransparency = 0
		hpText.Font = Enum.Font.SourceSansBold
		hpText.TextScaled = true
		hpText.Parent = gui

		------------------------------------------------
		-- UPDATE LOOP
		------------------------------------------------

		local connection
		connection = RunService.RenderStepped:Connect(function()

			if not humanoid or humanoid.Health <= 0 then
				connection:Disconnect()
				return
			end

			local percent = humanoid.Health / humanoid.MaxHealth

			hpBar.Size = UDim2.new(percent,0,1,0)

			hpText.Text =
				math.floor(humanoid.Health)
				.."/"..
				math.floor(humanoid.MaxHealth)

		end)

	end

	if player.Character then
		apply(player.Character)
	end

	player.CharacterAdded:Connect(apply)

end

------------------------------------------------
-- APPLY TO PLAYERS
------------------------------------------------

for _,p in pairs(Players:GetPlayers()) do
	createESP(p)
end

Players.PlayerAdded:Connect(createESP)
