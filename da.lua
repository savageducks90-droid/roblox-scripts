repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")
local playerGui = player.PlayerGui

-- prevent duplicates
if playerGui:FindFirstChild("SavageHub") then
	playerGui.SavageHub:Destroy()
end

-- loader
local function run(url)
	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("Failed loading:",url)
		return
	end

	local func,err = loadstring(code)
	if not func then
		warn("Loadstring Error:",err)
		return
	end

	pcall(func)
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Enabled = true
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,280,0,340)
main.Position = UDim2.new(0.4,0,0.3,0)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Parent = gui

-- top bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,36)
top.BackgroundColor3 = Color3.fromRGB(170,0,0)
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,1,0)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Savage Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = top

-- close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,1,0)
closeBtn.Position = UDim2.new(1,-30,0,0)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
closeBtn.Parent = top

closeBtn.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

-- drag
local dragging = false
local dragStart
local startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

main.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
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

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0,8)
padding.Parent = container

-- button creator
local function button(text,callback)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0,240,0,32)
	b.BackgroundColor3 = Color3.fromRGB(45,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Text = text
	b.Parent = container

	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(80,0,0)
	end)
	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(45,0,0)
	end)
	b.MouseButton1Click:Connect(callback)
end

-- buttons
button("Load ESP",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp_fixed.lua")
end)

button("Load Spectate",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")
end)

button("Chakra Sense Users",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/chakra.lua")
end)

button("Fruit Finder",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/fruit_esp.lua")
end)

button("Fruit Radar",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/fruit_radar.lua")
end)

button("Fruit Route Scan",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/fruit_route_scan.lua")
end)

-- chakra users label
local chakraLabel = Instance.new("TextLabel")
chakraLabel.Size = UDim2.new(0,240,0,60)
chakraLabel.BackgroundTransparency = 1
chakraLabel.TextColor3 = Color3.new(1,1,1)
chakraLabel.Font = Enum.Font.SourceSans
chakraLabel.TextWrapped = true
chakraLabel.TextYAlignment = Enum.TextYAlignment.Top
chakraLabel.Text = "Chakra Users: None"
chakraLabel.Parent = container

local function updateList()
	local cooldowns = ReplicatedStorage:FindFirstChild("Cooldowns")
	if not cooldowns then
		return
	end
	local list = {}
	for _,f in ipairs(cooldowns:GetChildren()) do
		if f:FindFirstChild("Chakra Sense") then
			table.insert(list,f.Name)
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
		updateList()
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
