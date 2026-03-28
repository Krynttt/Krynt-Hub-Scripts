-- KRYNT HUB: FULL UI EDITION
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. Create the Main Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHubUI"
ScreenGui.Parent = CoreGui

-- 2. Create the Background Frame (The Menu)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 120) -- Small and mobile friendly
MainFrame.Active = true
MainFrame.Draggable = true -- Hold the top to move it

local Corner = Instance.new("UICorner")
Corner.CornerRadius = Tool.new(0, 10)
Corner.Parent = MainFrame

-- 3. Title Label
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Krynt Hub Scripts"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18

-- 4. Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Start Red
ToggleBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "AUTO TAP: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = ToggleBtn

-- 5. THE LOGIC (The most important part)
_G.AutoTap = false
local clickRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Click")

-- This loop runs FOREVER but only clicks if _G.AutoTap is true
task.spawn(function()
    while true do
        if _G.AutoTap == true then
            clickRemote:FireServer(true)
        end
        task.wait(0.1) -- Your requested 0.1s speed
    end
end)

-- 6. Button Click Connection
ToggleBtn.MouseButton1Click:Connect(function()
    -- This flips the value: if it was false, it becomes true.
    _G.AutoTap = not _G.AutoTap
    
    if _G.AutoTap then
        ToggleBtn.Text = "AUTO TAP: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50) -- Green
        print("Auto-Tap Started")
    else
        ToggleBtn.Text = "AUTO TAP: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Red
        print("Auto-Tap Stopped")
    end
end)

-- 7. Auto Breakables (Always on)
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
