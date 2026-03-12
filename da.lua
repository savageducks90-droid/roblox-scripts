```lua
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")

local playerGui = player.PlayerGui

-- remove duplicates
if playerGui:FindFirstChild("SavageHub") then
	playerGui.SavageHub:Destroy()
end

-- script loader
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
		warn("Loadstring error:",err)
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
main.Active = true
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

-- close button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0,30,1,0)
close.Position = UDim2.new(1,-30,0,0)
close.Text = "X"
close.Font = Enum.Font.GothamBold
close.TextColor3 = Color3.new(1,1,1)
close.BackgroundColor3 = Color3.fromRGB(120,0,0)
close.Parent = top

close.MouseButton1Click:Connect(function()
	gui.Enabled = false
end)

-- drag system
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

	local b =
```
