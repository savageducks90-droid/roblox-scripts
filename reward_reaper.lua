local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

local rewards = {
"BarbaritRewards",
"ChakraKnightRewards",
"Haku BossRewards",
"Hyuga BossRewards",
"LavaSnakeRewards",
"LavarossaRewards",
"MandaRewards",
"SamuraiRewards",
"TairockRewards",
"WoodenGolemRewards"
}

local index = 1

local gui = Instance.new("ScreenGui")
gui.Name = "RewardReaper"
gui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,220,0,110)
frame.Position = UDim2.new(0.5,-110,0.5,-55)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,0,25)
label.Position = UDim2.new(0,0,0,10)
label.Text = "Next: "..rewards[index]
label.TextColor3 = Color3.new(1,1,1)
label.BackgroundTransparency = 1
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1,-20,0,45)
button.Position = UDim2.new(0,10,0,50)
button.Text = "Reap Rewards"
button.BackgroundColor3 = Color3.fromRGB(25,25,25)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = frame

local function teleportToReward(name)

local reward = workspace:FindFirstChild(name,true)

if reward then

local part

if reward:IsA("Model") then
part = reward.PrimaryPart or reward:FindFirstChildWhichIsA("BasePart")
elseif reward:IsA("BasePart") then
part = reward
end

if part then
root.CFrame = part.CFrame + Vector3.new(0,5,0)
end

end

end

button.MouseButton1Click:Connect(function()

teleportToReward(rewards[index])

index = index + 1
if index > #rewards then
index = 1
end

label.Text = "Next: "..rewards[index]

end)

UIS.InputBegan:Connect(function(input,gp)

if gp then return end

if input.KeyCode == Enum.KeyCode.RightControl then
gui.Enabled = not gui.Enabled
end

end)

print("Reward Reaper Loaded")
