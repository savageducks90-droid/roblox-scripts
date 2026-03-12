```lua
-- SAVAGE HUB CLEAN LOADER

if not game:IsLoaded() then
	game.Loaded:Wait()
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer

while not player do
	task.wait()
	player = Players.LocalPlayer
end

local playerGui = player:WaitForChild("PlayerGui")

-- remove old gui
local old = playerGui:FindFirstChild("SavageHub")
if old then
	old:Destroy()
end

-- create gui
local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,260,0,140)
frame.Position = UDim2.new(0.5,-130,0.5,-70)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(170,0,0)
title.Text = "Savage Hub Loaded"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-20,0,50)
button.Position = UDim2.new(0,10,0,60)
button.Text = "Test Button"
button.BackgroundColor3 = Color3.fromRGB(40,40,40)
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 18
button.Parent = frame

print("Savage Hub Loaded Successfully")
```
