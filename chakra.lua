local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local cooldowns = RS:WaitForChild("Cooldowns")

-- prevent duplicate GUI
if player.PlayerGui:FindFirstChild("ChakraCounter") then
	player.PlayerGui.ChakraCounter:Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ChakraCounter"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0,180,0,22)
label.Position = UDim2.new(0.5,-90,0,5)
label.BackgroundColor3 = Color3.fromRGB(0,0,0)
label.BackgroundTransparency = 0.3
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true
label.Parent = gui

-- count chakra users
local function update()

	local count = 0

	for _,folder in ipairs(cooldowns:GetChildren()) do
		if folder:FindFirstChild("Chakra Sense") then
			count += 1
		end
	end

	label.Text = "Chakra Users: "..count

end

-- update when cooldown folders change
cooldowns.ChildAdded:Connect(update)
cooldowns.ChildRemoved:Connect(update)

-- update when abilities change
for _,folder in ipairs(cooldowns:GetChildren()) do

	folder.ChildAdded:Connect(update)
	folder.ChildRemoved:Connect(update)

end

update()
