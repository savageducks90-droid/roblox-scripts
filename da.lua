-- SAVAGE HUB LOADER

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------
-- SAFE SCRIPT LOADER
------------------------------------------------

local function run(url)

	url = url.."?"..math.random(1000,9999)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("Failed loading:",url)
		return
	end

	local func = loadstring(code)

	if func then
		pcall(func)
	end

end

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,280,0,340)
main.Position = UDim2.new(.5,-140,.5,-170)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

------------------------------------------------
-- TOP BAR
------------------------------------------------

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

------------------------------------------------
-- MINIMIZE BUTTON
------------------------------------------------

local minimized = false

local mini = Instance.new("TextButton")
mini.Size = UDim2.new(0,36,1,0)
mini.Position = UDim2.new(1,-36,0,0)
mini.Text = "-"
mini.TextColor3 = Color3.new(1,1,1)
mini.BackgroundTransparency = 1
mini.Font = Enum.Font.GothamBold
mini.TextSize = 20
mini.Parent = top

mini.MouseButton1Click:Connect(function()

	if minimized then
		main.Size = UDim2.new(0,280,0,340)
		mini.Text = "-"
	else
		main.Size = UDim2.new(0,280,0,36)
		mini.Text = "+"
	end

	minimized = not minimized

end)

------------------------------------------------
-- BUTTON CONTAINER
------------------------------------------------

local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,1,-36)
container.Position = UDim2.new(0,0,0,36)
container.BackgroundTransparency = 1
container.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0,6)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Parent = container

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
-- TELEPORT ROUTE
------------------------------------------------

button("Fruit Route Teleport",function()

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local route = {

	Vector3.new(-132.2,178.4,-1347.2),
	Vector3.new(-58.7,149.9,-1528.3),
	Vector3.new(459.0,149.0,-1754.2),
	Vector3.new(431.3,148.9,-1514.1),
	Vector3.new(407.4,145.6,-2067.3),
	Vector3.new(65.1,353.2,-1888.3),
	Vector3.new(-304.2,146.0,-1798.8),
	Vector3.new(-583.2,146.2,-1367.9),
	Vector3.new(-652.0,276.1,-1574.2),
	Vector3.new(-665.8,150.2,-1991.8),
	Vector3.new(-488.6,440.3,-2133.7),
	Vector3.new(-892,434.0,-2132.4),
	Vector3.new(-531.2,249.0,-954.0),
	Vector3.new(55.9,217.1,-885.8)

	}

	for _,pos in ipairs(route) do
		root.CFrame = CFrame.new(pos)
		task.wait(1)
	end

end)

------------------------------------------------
-- CHAKRA SENSOR COUNTER
------------------------------------------------

local chakraGui = Instance.new("ScreenGui")
chakraGui.Parent = playerGui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,200,0,30)
label.Position = UDim2.new(.5,-100,0,0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.GothamBold
label.TextScaled = true
label.Text = "Chakra Sensors: 0"
label.Parent = chakraGui

task.spawn(function()

	while true do

		local count = 0
		local cooldowns = ReplicatedStorage:FindFirstChild("Cooldowns")

		if cooldowns then
			for _,v in pairs(cooldowns:GetChildren()) do
				if v:FindFirstChild("Chakra Sense") then
					count += 1
				end
			end
		end

		label.Text = "Chakra Sensors: "..count

		task.wait(2)

	end

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
