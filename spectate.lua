local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)

-- remove old
if player.PlayerGui:FindFirstChild("SpectateMenu") then
	player.PlayerGui.SpectateMenu:Destroy()
end

local currentSpectate = nil

------------------------------------------------
-- RETURN CAMERA
------------------------------------------------

local function returnToSelf()

	if player.Character and player.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = player.Character.Humanoid
	end

	currentSpectate = nil

end

------------------------------------------------
-- SPECTATE PLAYER
------------------------------------------------

local function spectate(plr)

	if currentSpectate == plr then
		returnToSelf()
		return
	end

	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = plr.Character.Humanoid
		currentSpectate = plr
	end

end

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "SpectateMenu"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,260,0,400)
main.Position = UDim2.new(1,-270,0,40)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.BorderSizePixel = 0
main.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.Text = "Spectate Players"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = main

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,-30)
scroll.Position = UDim2.new(0,0,0,30)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,4)
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)
end)

------------------------------------------------
-- CREATE TEAM SECTION
------------------------------------------------

local teamSections = {}

local function createTeamSection(team)

	local section = Instance.new("Frame")
	section.Size = UDim2.new(1,0,0,24)
	section.BackgroundTransparency = 1
	section.Parent = scroll

	local header = Instance.new("TextLabel")
	header.Size = UDim2.new(1,0,0,22)
	header.BackgroundColor3 = team.TeamColor.Color
	header.Text = team.Name
	header.TextColor3 = Color3.new(1,1,1)
	header.Font = Enum.Font.GothamBold
	header.TextSize = 14
	header.Parent = section

	local container = Instance.new("Frame")
	container.Position = UDim2.new(0,0,0,22)
	container.Size = UDim2.new(1,0,0,0)
	container.BackgroundTransparency = 1
	container.Parent = section

	local list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0,2)
	list.Parent = container

	list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()

		container.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y)
		section.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y + 22)

	end)

	teamSections[team] = container

end

------------------------------------------------
-- CREATE PLAYER ENTRY
------------------------------------------------

local function addPlayer(plr)

	if plr == player then return end

	local team = plr.Team
	if not teamSections[team] then return end

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1,-6,0,22)
	button.Position = UDim2.new(0,3,0,0)
	button.BackgroundColor3 = Color3.fromRGB(35,35,35)
	button.BorderSizePixel = 0
	button.TextColor3 = Color3.new(1,1,1)

	button.Text =
		plr.DisplayName.."  (@"..plr.Name..")"

	button.Font = Enum.Font.SourceSans
	button.TextSize = 14

	button.Parent = teamSections[team]

	button.MouseButton1Click:Connect(function()
		spectate(plr)
	end)

end

------------------------------------------------
-- BUILD LIST
------------------------------------------------

local function refresh()

	for _,child in pairs(scroll:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end

	teamSections = {}

	for _,team in pairs(Teams:GetTeams()) do
		createTeamSection(team)
	end

	for _,plr in pairs(Players:GetPlayers()) do
		addPlayer(plr)
	end

end

refresh()

------------------------------------------------
-- PLAYER EVENTS
------------------------------------------------

Players.PlayerAdded:Connect(function()
	task.wait(.3)
	refresh()
end)

Players.PlayerRemoving:Connect(function()
	task.wait(.3)
	refresh()
end)

for _,plr in pairs(Players:GetPlayers()) do
	plr:GetPropertyChangedSignal("Team"):Connect(refresh)
end

------------------------------------------------
-- RETURN CAMERA ON RESPAWN
------------------------------------------------

player.CharacterAdded:Connect(function()
	task.wait(.2)
	returnToSelf()
end)
