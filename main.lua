local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local plotsFolder = workspace:WaitForChild("Plots")

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHub_Debug"
ScreenGui.ResetOnSpawn = false
-- Using PlayerGui if CoreGui fails on some executors
local parent = game:GetService("CoreGui") or lp:WaitForChild("PlayerGui")
ScreenGui.Parent = parent

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.Text = "Auto-Roll: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Parent = MainFrame

local ExitBtn = Instance.new("TextButton")
ExitBtn.Size = UDim2.new(0, 20, 0, 20)
ExitBtn.Position = UDim2.new(0.85, 0, 0, 0)
ExitBtn.Text = "X"
ExitBtn.Parent = MainFrame

-- // LOGIC //
_G.AutoRoll = false

local function getMyPlot()
    for _, plot in pairs(plotsFolder:GetChildren()) do
        -- Double check if the attribute is actually "Owner"
        if plot:GetAttribute("Owner") == lp.UserId then
            return plot
        end
    end
    return nil
end

task.spawn(function()
    while true do
        if _G.AutoRoll then
            local success, err = pcall(function()
                local myPlot = getMyPlot()
                if myPlot then
                    -- Very aggressive path checking
                    local button = myPlot:FindFirstChild("Plot_Models", true) 
                    if button and button.Name == "PacketClick" then
                        if button:FindFirstChild("ClickDetector") then
                            fireclickdetector(button.ClickDetector)
                        else
                            -- Fallback to Touch (ensure character exists)
                            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                firetouchinterest(hrp, button, 0)
                                task.wait()
                                firetouchinterest(hrp, button, 1)
                            end
                        end
                    end
                end
            end)
            if not success then warn("Krynt Error: " .. err) end
        end
        task.wait(0.01)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = not _G.AutoRoll
    ToggleBtn.Text = _G.AutoRoll and "Auto-Roll: ON" or "Auto-Roll: OFF"
    ToggleBtn.BackgroundColor3 = _G.AutoRoll and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

ExitBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = false
    ScreenGui:Destroy()
end)

print("Krynt Hub Loaded Successfully")
