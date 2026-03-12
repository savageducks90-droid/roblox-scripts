local Players = game:GetService("Players")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- remove old gui
if player.PlayerGui:FindFirstChild("SpectateMenu") then
	player.PlayerGui.SpectateMenu:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "SpectateMenu"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,200,0,300)
frame.Position = UDim2.new(1,-210,0,20)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Parent = gui

local layout = Instance.new("UIListLayout")
layout.Parent = frame

local currentSpectate = nil

local function returnToSelf()

	if player.Character and player.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = player.Character.Humanoid
	end

	currentSpectate = nil

end

local function spectate(plr)

	if currentSpectate == plr then
		returnToSelf()
		return
	end

	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		camera.CameraSubject = plr.Character.Humanoid
		currentSpectate = plr
	end

end

for _,plr in pairs(Players:GetPlayers()) do

	if plr ~= player then

		local button = Instance.new("TextButton")
		button.Size = UDim2.new(1,0,0,25)
		button.Text = plr.Name
		button.BackgroundColor3 = Color3.fromRGB(40,40,40)
		button.TextColor3 = Color3.new(1,1,1)
		button.Parent = frame

		button.MouseButton1Click:Connect(function()
			spectate(plr)
		end)

	end

end

print("Spectate Loaded")
