-- KRYNT HUB: MOBILE TOGGLE EDITION
local Player = game.Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- 1. Create the UI
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local Corner = Instance.new("UICorner")

ScreenGui.Name = "KryntToggleUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 2. Style the Button
ToggleButton.Name = "AutoTapToggle"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when OFF
ToggleButton.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 100, 0, 50)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.Text = "AUTO TAP: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true -- You can move it around!

Corner.CornerRadius = Tool.new(0, 8)
Corner.Parent = ToggleButton

-- 3. Logic Variables
_G.AutoTap = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local clickRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Click")

-- 4. The Tapping Function
task.spawn(function()
    while true do
        if _G.AutoTap then
            clickRemote:FireServer(true)
        end
        task.wait(0.1) -- Your 0.1s speed
    end
end)

-- 5. Toggle Button Function
ToggleButton.MouseButton1Click:Connect(function()
    _G.AutoTap = not _G.AutoTap
    
    if _G.AutoTap then
        ToggleButton.Text = "AUTO TAP: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green when ON
    else
        ToggleButton.Text = "AUTO TAP: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red when OFF
    end
end)

-- 6. Auto Breakables (Always Runs in Background)
task.spawn(function()
    local breakRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Break")
    while true do
        local folder = workspace:FindFirstChild("Breakables")
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                breakRemote:FireServer(v.Name)
            end
        end
        task.wait(0.5)
    end
end)

print("Krynt Hub UI Loaded!")
