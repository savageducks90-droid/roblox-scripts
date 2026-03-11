
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

-- loader function
local function run(url)

	print("Loading:", url)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("HTTP Failed:",url)
		return
	end

	local func,err = loadstring(code)

	if not func then
		warn("Loadstring Error:",err)
		return
	end

	local ok,runtime = pcall(func)

	if not ok then
		warn("Runtime Error:",runtime)
	end

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0,270,0,320)
main.Position = UDim2.new(0.5,-135,0.5,-160)
main.BackgroundColor3 = Color3.fromRGB(20,20,20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui

-- top bar
local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,34)
top.BackgroundColor3 = Color3.fromRGB(170,0,0)
top.BorderSizePixel = 0
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,1,0)
title.BackgroundTransparency = 1
title.Text = "Savage Hub"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = top

-- minimize
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0,30,1,0)
minimize.Position = UDim2.new(1,-30,0,0)
minimize.Text = "-"
minimize.Font = Enum.Font.GothamBold
minimize.TextColor3 = Color3.new(1,1,1)
minimize.BackgroundColor3 = Color3.fromRGB(120,0,0)
minimize.Parent = top

local minimized = false

minimize.MouseButton1Click:Connect(function()

	if minimized then
		main.Size = UDim2.new(0,270,0,320)
	else
		main.Size = UDim2.new(0,270,0,34)
	end

	minimized = not minimized

end)

-- container
local container = Instance.new("Frame")
container.Size = UDim2.new(1,0,1,-34)
container.Position = UDim2.new(0,0,0,34)
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
	b.Size = UDim2.new(0,220,0,32)
	b.BackgroundColor3 = Color3.fromRGB(40,0,0)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.Text = text
	b.Parent = container

	b.MouseEnter:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(70,0,0)
	end)

	b.MouseLeave:Connect(function()
		b.BackgroundColor3 = Color3.fromRGB(40,0,0)
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

button("Close Hub",function()
	gui.Enabled = false
end)

-- toggle with RightShift
UIS.InputBegan:Connect(function(input,gp)

	if gp then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end

end)

print("Savage Hub Loaded")
```
