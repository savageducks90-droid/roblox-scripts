repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")

local playerGui = player.PlayerGui

if playerGui:FindFirstChild("SavageHub") then
	playerGui.SavageHub:Destroy()
end

local function run(url)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if not success then
		warn("Failed:",url)
		return
	end

	local func = loadstring(code)

	if func then
		pcall(func)
	end

end

local gui = Instance.new("ScreenGui")
gui.Name = "SavageHub"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,250,0,260)
frame.Position = UDim2.new(0.5,-125,0.5,-130)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Parent = gui

local layout = Instance.new("UIListLayout")
layout.Parent = frame

local function button(name,callback)

	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1,0,0,30)
	b.Text = name
	b.Parent = frame

	b.MouseButton1Click:Connect(callback)

end

button("ESP",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/esp_fixed.lua")
end)

button("Spectate",function()
	run("https://raw.githubusercontent.com/savageducks90-droid/roblox-scripts/main/spectate.lua")
end)

button("Chakra Users",function()
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

UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end
end)

print("Savage Hub Loaded")
