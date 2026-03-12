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
main.Size = UDim2.new(0,280,0,460)
main.Position = UDim2.new(0.5,-140,0.5,-230)
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

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,36,1,0)
minimize.Position = UDim2.new(1,-36,0,0)
minimize.Text = "-"
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundTransparency = 1
minimize.Font = Enum.Font.GothamBold
minimize.TextSize = 22
minimize.Parent = top

minimize.MouseButton1Click:Connect(function()

	if minimized then
		main.Size = UDim2.new(0,280,0,460)
		minimize.Text = "-"
	else
		main.Size = UDim2.new(0,280,0,36)
		minimize.Text = "+"
	end

	minimized = not minimized

end)

------------------------------------------------
-- CONTAINER
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
-- VISUAL SECTION
------------------------------------------------

local visualTitle = Instance.new("TextLabel")
visualTitle.Size = UDim2.new(0,240,0,20)
visualTitle.BackgroundTransparency = 1
visualTitle.Text = "Visuals"
visualTitle.TextColor3 = Color3.fromRGB(255,80,80)
visualTitle.Font = Enum.Font.GothamBold
visualTitle.TextSize = 16
visualTitle.Parent = container

button("ESP",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp.lua")
end)

button("Spectate",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")
end)

------------------------------------------------
-- UTILITY
------------------------------------------------

local utilTitle = Instance.new("TextLabel")
utilTitle.Size = UDim2.new(0,240,0,20)
utilTitle.BackgroundTransparency = 1
utilTitle.Text = "Utility"
utilTitle.TextColor3 = Color3.fromRGB(255,80,80)
utilTitle.Font = Enum.Font.GothamBold
utilTitle.TextSize = 16
utilTitle.Parent = container

button("Reward Reaper",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/reward_reaper.lua")
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

	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

	for _,v in pairs(workspace:GetDescendants()) do

		if table.find(fruits,v.Name) then

			local part = v:IsA("BasePart") and v or v:FindFirstChildWhichIsA("BasePart")

			if part then

				local gui = Instance.new("BillboardGui")
				gui.Size = UDim2.new(0,120,0,40)
				gui.AlwaysOnTop = true
				gui.Parent = part

				local text = Instance.new("TextLabel")
				text.Size = UDim2.new(1,0,1,0)
				text.BackgroundTransparency = 1
				text.TextColor3 = Color3.new(1,0,0)
				text.TextScaled = true
				text.Parent = gui

				task.spawn(function()

					while part.Parent do

						if root then
							local dist = math.floor((root.Position - part.Position).Magnitude)
							text.Text = v.Name.." ["..dist.."m]"
						end

						task.wait(.5)

					end

				end)

			end

		end

	end

end)

------------------------------------------------
-- CHAKRA SENSOR COUNTER
------------------------------------------------

local chakraGui = Instance.new("ScreenGui")
chakraGui.Parent = playerGui
chakraGui.Name = "ChakraCounter"

local chakraLabel = Instance.new("TextLabel")
chakraLabel.Size = UDim2.new(0,200,0,30)
chakraLabel.Position = UDim2.new(0.5,-100,0,0)
chakraLabel.BackgroundTransparency = 1
chakraLabel.TextColor3 = Color3.new(1,1,1)
chakraLabel.Font = Enum.Font.GothamBold
chakraLabel.TextScaled = true
chakraLabel.Text = "Chakra Sensors: 0"
chakraLabel.Parent = chakraGui

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

		chakraLabel.Text = "Chakra Sensors: "..count

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

print("Savage Hub Loaded")
