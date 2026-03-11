local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")

local cooldowns = RS:WaitForChild("Cooldowns")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0,180,0,22)
label.Position = UDim2.new(0.5,-90,0,5)
label.BackgroundColor3 = Color3.fromRGB(0,0,0)
label.BackgroundTransparency = 0.3
label.TextColor3 = Color3.new(1,1,1)
label.Font = Enum.Font.SourceSansBold
label.TextScaled = true

local function update()
	local count = 0
	for _,f in ipairs(cooldowns:GetChildren()) do
		if f:FindFirstChild("Chakra Sense") then
			count += 1
		end
	end
	label.Text = "Chakra: "..count
end

for _,f in ipairs(cooldowns:GetChildren()) do
	f.ChildAdded:Connect(update)
	f.ChildRemoved:Connect(update)
end

cooldowns.ChildAdded:Connect(function(f)
	f.ChildAdded:Connect(update)
	f.ChildRemoved:Connect(update)
	update()
end)

cooldowns.ChildRemoved:Connect(update)

update()
