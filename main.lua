-- [[ KRYNT HUB - MY KNIFE FARM ]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHub_Final"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 160)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true -- Required for minimize effect

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "KRYNT HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

-- Minimize Button (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = MainFrame
MinimizeBtn.Position = UDim2.new(0.7, 0, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.TextSize = 20

-- Exit Button (X)
local ExitBtn = Instance.new("TextButton")
ExitBtn.Parent = MainFrame
ExitBtn.Position = UDim2.new(0.85, 0, 0, 5)
ExitBtn.Size = UDim2.new(0, 20, 0, 20)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1, 0, 0)
ExitBtn.BackgroundTransparency = 1
ExitBtn.TextSize = 16

-- Toggle Button (ON/OFF)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 40)
ToggleBtn.Text = "Auto-Roll: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16

-- // LOGIC //
_G.AutoRoll = false

local function getMyPlot()
    local plots = workspace:FindFirstChild("Plots")
    if not plots then return nil end
    for _, plot in pairs(plots:GetChildren()) do
        if plot:GetAttribute("Owner") == lp.UserId then
            return plot
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if _G.AutoRoll then
            pcall(function()
                local myPlot = getMyPlot()
                if myPlot then
                    -- Navigating your specific Dex path
                    local models = myPlot:FindFirstChild("Plot_Models")
                    local base = models and models:FindFirstChild("BaseModel")
                    local billboard = base and base:FindFirstChild("BillBoardC")
                    local packet = billboard and billboard:FindFirstChild("PacketClick")
                    local cd = packet and packet:FindFirstChild("ClickDetector")

                    if cd then
                        fireclickdetector(cd)
                    end
                end
            end)
        end
        task.wait(0.01)
    end
end)

-- // BUTTON CONNECTIONS //

-- Toggle Logic
ToggleBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = not _G.AutoRoll
    ToggleBtn.Text = _G.AutoRoll and "Auto-Roll: ON" or "Auto-Roll: OFF"
    ToggleBtn.BackgroundColor3 = _G.AutoRoll and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

-- Minimize Logic
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 30), "Out", "Quad", 0.3, true)
    else
        MainFrame:TweenSize(UDim2.new(0, 200, 0, 160), "Out", "Quad", 0.3, true)
    end
end)

-- Exit Logic
ExitBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = false
    ScreenGui:Destroy()
end)

print("Krynt Hub: Final Version Loaded")
