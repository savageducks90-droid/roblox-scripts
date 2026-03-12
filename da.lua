-- SAVAGE HUB MAIN

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")

local playerGui = player.PlayerGui

-- remove old hub
local old = playerGui:FindFirstChild("SavageHub")
if old then
	old:Destroy()
end

------------------------------------------------
-- SAFE SCRIPT LOADER
------------------------------------------------

local function run(url)

	-- bypass github cache
	url = url.."?"..math.random(100000,999999)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("HTTP FAILED:",url)
		return
	end

	-- detect github html error pages
	if string.find(code,"<!DOCTYPE") then
		warn("SCRIPT NOT FOUND:",url)
		return
	end

	local func,err = loadstring(code)

	if not func then
		warn("LOADSTRING ERROR:",err)
		return
	end

	pcall(func)

end

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,280,0,360)
main.Position = UDim2.new(0.5,-140,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,36)
top.BackgroundColor3 = Color3.fromRGB(170,0,0)
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,1,0)
title.BackgroundTransparency = 1
title.Text = "Savage Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = top

local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,1,-36)
container.Position = UDim2.new(0,0,0,36)
container.BackgroundTransparency = 1
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

------------------------------------------------
-- BUTTON CREATOR
------------------------------------------------

local function button(text,callback)

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

------------------------------------------------
-- SCRIPT BUTTONS
------------------------------------------------

button("ESP",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp.lua")
end)

button("Spectate",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")
end)

button("Reward Reaper",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/reward_reaper.lua")
end)

------------------------------------------------
-- HUB TOGGLE
------------------------------------------------

UIS.InputBegan:Connect(function(input,gp)

	if gp then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end

end)

print("Savage Hub Loaded")
