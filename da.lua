```lua
-- SAVAGE HUB MAIN LOADER

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

-- wait for player
local player
repeat
	player = Players.LocalPlayer
	task.wait()
until player

-- wait for PlayerGui
local playerGui
repeat
	playerGui = player:FindFirstChild("PlayerGui")
	task.wait()
until playerGui

-- remove old hub
if playerGui:FindFirstChild("SavageHub") then
	playerGui.SavageHub:Destroy()
end

-- safe http loader
local function run(url)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("HTTP FAILED:",url)
		return
	end

	local func,err = loadstring(code)

	if not func then
		warn("LOADSTRING ERROR:",err)
		return
	end

	pcall(func)

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,280,0,330)
main.Position = UDim2.new(0.5,-140,0.5,-165)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- top bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,36)
top.BackgroundColor3 = Color3.fromRGB(170,0,0)
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,1,0)
title.BackgroundTransparency = 1
title.Text = "Savage Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.new(0,30,1,0)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBold
close.BackgroundColor3 = Color3.fromRGB(120,0,0)
close.Parent = top

close.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

-- container
local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,1,-36)
container.Position = UDim2.new(0,0,0,36)
container.BackgroundTransparency = 1
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

-- button creator
local function makeButton(text,callback)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,240,0,34)
	b.BackgroundColor3 = Color3.fromRGB(40,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Text = text
	b.Parent = container

	b.MouseButton1Click:Connect(callback)

end

-- buttons
makeButton("ESP",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp_fixed.lua")

end)

makeButton("Spectate",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")

end)

makeButton("Reward Reaper",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/reward_reaper.lua")

end)

-- chakra sense detector
local chakraLabel = Instance.new("TextLabel")
chakraLabel.Size = UDim2.new(0,240,0,80)
chakraLabel.BackgroundTransparency = 1
chakraLabel.TextColor3 = Color3.new(1,1,1)
chakraLabel.Font = Enum.Font.SourceSansBold
chakraLabel.TextWrapped = true
chakraLabel.Text = "Chakra Users: None"
chakraLabel.Parent = container

local function updateChakra()

	local cooldowns = ReplicatedStorage:FindFirstChild("Cooldowns")
	if not cooldowns then return end

	local list = {}

	for _,folder in ipairs(cooldowns:GetChildren()) do

		if folder:FindFirstChild("Chakra Sense") then
			table.insert(list,folder.Name)
		end

	end

	if #list == 0 then
		chakraLabel.Text = "Chakra Users: None"
	else
		chakraLabel.Text = "Chakra Users:\n"..table.concat(list,"\n")
	end

end

task.spawn(function()

	while true do
		updateChakra()
		task.wait(2)
	end

end)

-- toggle hub
UIS.InputBegan:Connect(function(input,gp)

	if gp then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end

end)

print("Savage Hub Loaded")
```
