local Players = game:GetService("Players")
local Teams = game:GetService("Teams")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)

local currentSpectate = nil
local playerButtons = {}

-- Spectate functions
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

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,200,0,320)
mainFrame.Position = UDim2.new(1,-210,0,20)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- ScrollFrame
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,0,1,0)
scroll.CanvasSize = UDim2.new(0,0,0,0)
scroll.ScrollBarThickness = 6
scroll.BorderSizePixel = 0
scroll.BackgroundTransparency = 1
scroll.Parent = mainFrame

-- Layout
local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,4)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 6)
end)

local teamFrames = {}

-- Create team section
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

	local playerContainer = Instance.new("Frame")
	playerContainer.Size = UDim2.new(1,0,0,0)
	playerContainer.Position = UDim2.new(0,0,0,22)
	playerContainer.BackgroundTransparency = 1
	playerContainer.Parent = section

	local list = Instance.new("UIListLayout")
	list.Padding = UDim.new(0,2)
	list.SortOrder = Enum.SortOrder.LayoutOrder
	list.Parent = playerContainer

	list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		playerContainer.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y)
		section.Size = UDim2.new(1,0,0,list.AbsoluteContentSize.Y + 22)
	end)

	teamFrames[team] = playerContainer
end

-- Player entry
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

-- Clear list
local function clearPlayerEntries()
	for plr,btn in pairs(playerButtons) do
		if btn then
			btn:Destroy()
		end
	end
	playerButtons = {}
end

-- Refresh list
local function refreshPlayerList()
	clearPlayerEntries()

	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player then
			createPlayerEntry(plr)
		end
	end
end

-- Create teams
for _,team in pairs(Teams:GetTeams()) do
	createTeamFrame(team)
end

-- Initial load
refreshPlayerList()

-- Refresh every 30 seconds
task.spawn(function()
	while true do
		task.wait(30)
		refreshPlayerList()
	end
end)

-- Player join
Players.PlayerAdded:Connect(function()
	task.wait(1)
	refreshPlayerList()
end)

-- Player leave
Players.PlayerRemoving:Connect(function()
	refreshPlayerList()
end)
