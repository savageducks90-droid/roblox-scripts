local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)

-- prevent duplicate gui
if player.PlayerGui:FindFirstChild("SpectateMenu") then
	player.PlayerGui.SpectateMenu:Destroy()
end

local currentSpectate = nil
local playerButtons = {}

-- spectate functions
local function returnToSelf()
	if player.Character and player.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = player.Character.Humanoid
	end
	currentSpectate = nil
end

local function spectate(plr)
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = plr.Character.Humanoid
		currentSpectate = plr
	end
end

-- auto reset if spectated player dies
local function watchCharacter(plr)
	plr.CharacterAdded:Connect(function(char)
		if currentSpectate == plr then
			task.wait(0.2)
			spectate(plr)
		end
	end)
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SpectateMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,200,0,320)
mainFrame.Position = UDim2.new(1,-210,0,20)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,0)
scroll.ScrollBarThickness = 6
scroll.BorderSizePixel = 0
scroll.BackgroundTransparency = 1
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,4)
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+6)
end)

local teamFrames = {}

-- team section
local function createTeamFrame(team)

	local section = Instance.new("Frame")
	section.Size = UDim2.new(1,0,0,24)
	section.BackgroundTransparency = 1
	section.Parent = scroll

	local header = Instance.new("Frame")
	header.Size = UDim2.new(1,0,0,20)
	header.BackgroundColor3 = team.TeamColor.Color
	header.BorderSizePixel = 0
	header.Parent = section

	local headerText = Instance.new("TextLabel")
	headerText.Size = UDim2.new(1,0,1,0)
	headerText.BackgroundTransparency = 1
	headerText.Text = team.Name
	headerText.TextColor3 = Color3.new(1,1,1)
	headerText.Font = Enum.Font.SourceSansBold
	headerText.TextScaled = true
	headerText.Parent = header

	local container = Instance.new("Frame")
	container.Size = UDim2.new(1,0,0,0)
	container.Position = UDim2.new(0,0,0,22)
	container.BackgroundTransparency = 1
	container.Parent = section

	local list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0,2)
	list.Parent = container

	list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		container.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y)
		section.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y+22)
	end)

	teamFrames[team] = container
end

-- player button
local function createPlayerEntry(plr)

	local team = plr.Team
	if not teamFrames[team] then return end

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,-4,0,20)
	button.Position = UDim2.new(0,2,0,0)
	button.BackgroundColor3 = Color3.fromRGB(40,40,40)
	button.BorderSizePixel = 0
	button.TextColor3 = Color3.new(1,1,1)
	button.Text = plr.DisplayName.." (@"..plr.Name..")"
	button.Font = Enum.Font.SourceSans
	button.TextScaled = true
	button.Parent = teamFrames[team]

	playerButtons[plr] = button

	button.MouseButton1Click:Connect(function()
		if currentSpectate == plr then
			returnToSelf()
		else
			spectate(plr)
		end
	end)
end

-- refresh list
local function refresh()

	for _,btn in pairs(playerButtons) do
		btn:Destroy()
	end

	playerButtons = {}

	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			createPlayerEntry(plr)
		end
	end
end

-- create teams
for _,team in pairs(Teams:GetTeams()) do
	createTeamFrame(team)
end

refresh()

-- player join
Players.PlayerAdded:Connect(function(plr)
	watchCharacter(plr)
	task.wait(0.5)
	refresh()
end)

-- player leave
Players.PlayerRemoving:Connect(function()
	refresh()
end)

-- team change
Players.PlayerAdded:Connect(function(plr)
	plr:GetPropertyChangedSignal("Team"):Connect(refresh)
end)

-- watch existing players
for _,plr in pairs(Players:GetPlayers()) do
	if plr ~= player then
		watchCharacter(plr)
	end
end

-- return camera when you respawn
player.CharacterAdded:Connect(function()
	task.wait(0.2)
	returnToSelf()
end)
