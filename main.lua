-- 1. UI Setup (Manual)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.5, -60, 0.2, 0) -- Top-middle of screen
MainFrame.Size = UDim2.new(0, 120, 0, 50)
MainFrame.Active = true
MainFrame.Draggable = true

ToggleBtn.Parent = MainFrame
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleBtn.Text = "AUTO: OFF"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 14

-- 2. Variables
local player = game.Players.LocalPlayer
local active = false

-- 3. The Universal Searcher (Finds the plot you are standing on)
local function getMyNearestDetector()
    local nearestDetector = nil
    local shortestDistance = 50 -- Only search within 50 studs

    for _, p in pairs(workspace.Plots:GetChildren()) do
        -- Try to find the ClickDetector using the path you provided
        local success, detector = pcall(function()
            return p.Plot_Models.BaseModel.ButtonModel.PacketClick.ClickDetector
        end)

        if success and detector and detector.Parent then
            local distance = (player.Character.HumanoidRootPart.Position - detector.Parent.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestDetector = detector
            end
        end
    end
    return nearestDetector
end

-- 4. Toggle Logic
ToggleBtn.MouseButton1Click:Connect(function()
    active = not active
    
    if active then
        ToggleBtn.Text = "AUTO: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        
        task.spawn(function()
            while active do
                local target = getMyNearestDetector()
                if target then
                    fireclickdetector(target)
                end
                task.wait(0.3)
            end
        end)
    else
        ToggleBtn.Text = "AUTO: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)
