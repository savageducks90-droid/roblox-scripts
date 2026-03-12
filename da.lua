-- SAVAGE HUB

repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

------------------------------------------------
-- REMOVE OLD HUB
------------------------------------------------

local old = playerGui:FindFirstChild("SavageHub")
if old then
	old:Destroy()
end

------------------------------------------------
-- SAFE LOADER
------------------------------------------------

local function run(url)

	url = url.."?"..math.random(1000,9999)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("HTTP FAILED:",url)
		return
	end

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
main.Size = UDim2.new(0,280,0,420)
main.Position = UDim2.new(0.5,-140,0.5,-210)
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
-- BUTTON FUNCTION
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
-- ESP
------------------------------------------------

button("ESP",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp.lua")

end)

------------------------------------------------
-- SPECTATE
------------------------------------------------

button("Spectate",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")

end)

------------------------------------------------
-- REWARD REAPER
------------------------------------------------

button("Reward Reaper",function()

	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/reward_reaper.lua")

end)

------------------------------------------------
-- CHAKRA SENSE DETECTOR
------------------------------------------------

local chakraLabel = Instance.new("TextLabel")
chakraLabel.Size = UDim2.new(0,240,0,70)
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

------------------------------------------------
-- FRUIT RADAR
------------------------------------------------

local fruits = {
	"Life Up Fruit",
	"Chakra Fruit",
	"Mango"
}

button("Fruit Radar",function()

	for _,v in pairs(workspace:GetDescendants()) do

		if table.find(fruits,v.Name) then

			if v:IsA("BasePart") then

				local billboard = Instance.new("BillboardGui")
				billboard.Size = UDim2.new(0,100,0,40)
				billboard.AlwaysOnTop = true
				billboard.Parent = v

				local text = Instance.new("TextLabel")
				text.Size = UDim2.new(1,0,1,0)
				text.BackgroundTransparency = 1
				text.Text = v.Name
				text.TextColor3 = Color3.new(1,0,0)
				text.TextScaled = true
				text.Parent = billboard

			end

		end

	end

end)

------------------------------------------------
-- FRUIT ROUTE SCAN
------------------------------------------------

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

button("Fruit Route Scan",function()

	local char = player.Character
	if not char then return end

	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	for _,pos in ipairs(route) do

		root.CFrame = CFrame.new(pos)
		task.wait(1)

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

print("Savage Hub Loaded")
