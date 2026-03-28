-- KRYNT HUB: MOBILE COMPATIBLE + INF JUMP
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- 1. Create the UI Container (Using PlayerGui for better Delta compatibility)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHub"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- 2. Main Menu Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Hold the title to move

local Corner = Instance.new("UICorner")
Corner.Parent = MainFrame

-- 3. Title Bar
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(255, 170, 0) -- Gold Title
Title.Text = "Krynt Hub Scripts"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

local TitleCorner = Instance.new("UICorner")
TitleCorner.Parent = Title

-- 4. Auto Tap Button
local TapBtn = Instance.new("TextButton")
TapBtn.Parent = MainFrame
TapBtn.Position = UDim2.new(0.1, 0, 0.25, 0)
TapBtn.Size = UDim2.new(0.8, 0, 0, 40)
TapBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
TapBtn.Text = "Auto Tap: OFF"
TapBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TapBtn.Font = Enum.Font.SourceSansBold

-- 5. Infinite Jump Button
local JumpBtn = Instance.new("TextButton")
JumpBtn.Parent = MainFrame
JumpBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
JumpBtn.Size = UDim2.new(0.8, 0, 0, 40)
JumpBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
JumpBtn.Text = "Inf Jump: OFF"
JumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpBtn.Font = Enum.Font.SourceSansBold

-- [ LOGIC ]
_G.AutoTap = false
_G.InfJump = false

-- Tapping Loop
task.spawn(function()
    local Events = game:GetService("ReplicatedStorage"):WaitForChild("Events")
    local Click = Events:WaitForChild("Click")
    while true do
        if _G.AutoTap then
            Click:FireServer(true)
        end
        task.wait(0.1)
    end
end)

-- Infinite Jump Logic
UIS.JumpRequest:Connect(function()
    if _G.InfJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Button Click Events
TapBtn.MouseButton1Click:Connect(function()
    _G.AutoTap = not _G.AutoTap
    TapBtn.Text = _G.AutoTap and "Auto Tap: ON" or "Auto Tap: OFF"
    TapBtn.BackgroundColor3 = _G.AutoTap and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

JumpBtn.MouseButton1Click:Connect(function()
    _G.InfJump = not _G.InfJump
    JumpBtn.Text = _G.InfJump and "Inf Jump: ON" or "Inf Jump: OFF"
    JumpBtn.BackgroundColor3 = _G.InfJump and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

print("Krynt Hub Successfully Loaded!")
