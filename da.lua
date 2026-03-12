repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,250,0,120)
frame.Position = UDim2.new(0.5,-125,0.5,-60)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Parent = gui
frame.Active = true
frame.Draggable = true

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.Text = "Savage Hub Loaded"
label.TextColor3 = Color3.new(1,1,1)
label.TextScaled = true
label.Parent = frame

print("Savage Hub Loaded")
