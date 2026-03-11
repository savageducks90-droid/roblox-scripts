local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- loader
local function run(url)

	local success,code = pcall(function()
		return game:HttpGet(url)
	end)

	if success then
		local func = loadstring(code)
		if func then
			func()
		end
	else
		warn("Failed loading:",url)
	end

end

-- GUI
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0,270,0,230)
main.Position = UDim2.new(0.5,-135,0.5,-115)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
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

-- minimize button
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
		main.Size = UDim2.new(0,270,0,230)
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

-- chakra auto detect
local chakraLabel = Instance.new("TextLabel")
chakraLabel.Size = UDim2.new(0,220,0,60)
chakraLabel.BackgroundTransparency = 1
chakraLabel.TextColor3 = Color3.new(1,1,1)
chakraLabel.Font = Enum.Font.SourceSans
chakraLabel.TextWrapped = true
chakraLabel.TextYAlignment = Enum.TextYAlignment.Top
chakraLabel.Text = "Chakra Users: None"
chakraLabel.Parent = container

local function update()

	local cooldowns = ReplicatedStorage:FindFirstChild("Cooldowns")
	if not cooldowns then return end

	local list = {}

	for _,folder in ipairs(cooldowns:GetChildren()) do
		if folder:FindFirstChild("Chakra Sense") then
			table.insert(list,folder.Name)
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
		update()
		task.wait(2)
	end
end)

button("Close Hub",function()
	gui.Enabled = false
end)

-- RightShift toggle
UIS.InputBegan:Connect(function(input,gp)

	if gp then return end

	if input.KeyCode == Enum.KeyCode.RightShift then
		gui.Enabled = not gui.Enabled
	end

end)
