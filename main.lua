local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local plotsFolder = workspace:WaitForChild("Plots")

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local ExitBtn = Instance.new("TextButton")

ScreenGui.Name = "KryntHub_MyKnifeFarm"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "KRYNT HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- // AUTO-ROLL LOGIC //
_G.AutoRoll = false -- Starts OFF by default

local function getMyPlot()
    for _, plot in pairs(plotsFolder:GetChildren()) do
        if plot:GetAttribute("Owner") == lp.UserId then
            return plot
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if _G.AutoRoll then
            local myPlot = getMyPlot()
            if myPlot then
                local button = myPlot:FindFirstChild("Plot_Models")
                    and myPlot.Plot_Models:FindFirstChild("BaseModel")
                    and myPlot.Plot_Models.BaseModel:FindFirstChild("ButtonModel")
                    and myPlot.Plot_Models.BaseModel.ButtonModel:FindFirstChild("PacketClick")

                if button then
                    if button:FindFirstChild("ClickDetector") then
                        fireclickdetector(button.ClickDetector)
                    else
                        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            firetouchinterest(hrp, button, 0)
                            task.wait()
                            firetouchinterest(hrp, button, 1)
                        end
                    end
                end
            end
        end
        task.wait(0.01) -- High-speed roll
    end
end)

-- // UI BUTTONS //

-- Toggle Button (ON/OFF)
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Text = "Auto-Roll: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Start Red
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = not _G.AutoRoll
    if _G.AutoRoll then
        ToggleBtn.Text = "Auto-Roll: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50) -- Green when ON
    else
        ToggleBtn.Text = "Auto-Roll: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50) -- Red when OFF
    end
end)

-- Minimize Button
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Position = UDim2.new(0.7, 0, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.BackgroundTransparency = 1

local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 200, 0
