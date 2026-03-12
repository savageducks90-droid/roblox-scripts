local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

local function applyESP(player, character)

	if player == LocalPlayer then return end

	local head = character:WaitForChild("Head",10)
	local humanoid = character:WaitForChild("Humanoid",10)

	if not head or not humanoid then return end

	local old = head:FindFirstChild("SavageESP")
	if old then old:Destroy() end

	local gui = Instance.new("BillboardGui")
	gui.Name = "SavageESP"
	gui.Size = UDim2.new(0,140,0,50)
	gui.StudsOffset = Vector3.new(0,2.5,0)
	gui.AlwaysOnTop = true
	gui.Parent = head

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1,0,0,16)
	name.BackgroundTransparency = 1
	name.TextColor3 = Color3.new(1,1,1)
	name.TextStrokeTransparency = 0
	name.Font = Enum.Font.SourceSansBold
	name.TextScaled = true
	name.Text = player.DisplayName.." (@"..player.Name..")"
	name.Parent = gui

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0.8,0,0,6)
	bg.Position = UDim2.new(0.1,0,0,20)
	bg.BackgroundColor3 = Color3.fromRGB(40,40,40)
	bg.BorderSizePixel = 0
	bg.Parent = gui

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(1,0,1,0)
	bar.BackgroundColor3 = Color3.fromRGB(255,0,0)
	bar.BorderSizePixel = 0
	bar.Parent = bg

	local hpText = Instance.new("TextLabel")
	hpText.Size = UDim2.new(1,0,0,14)
	hpText.Position = UDim2.new(0,0,0,30)
	hpText.BackgroundTransparency = 1
	hpText.TextColor3 = Color3.new(1,1,1)
	hpText.TextStrokeTransparency = 0
	hpText.Font = Enum.Font.SourceSansBold
	hpText.TextScaled = true
	hpText.Parent = gui

	RunService.RenderStepped:Connect(function()

		if humanoid and humanoid.Parent then

			local percent = humanoid.Health / humanoid.MaxHealth

			bar.Size = UDim2.new(percent,0,1,0)

			hpText.Text =
				math.floor(humanoid.Health)
				.."/"..
				math.floor(humanoid.MaxHealth)

		end

	end)

end

local function setupPlayer(player)

	if player == LocalPlayer then return end

	if player.Character then
		applyESP(player, player.Character)
	end

	player.CharacterAdded:Connect(function(char)
		task.wait(.5)
		applyESP(player,char)
	end)

end

for _,p in pairs(Players:GetPlayers()) do
	setupPlayer(p)
end

Players.PlayerAdded:Connect(setupPlayer)
