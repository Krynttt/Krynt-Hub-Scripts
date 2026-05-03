-- 1. Create the UI Container
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

-- 2. Properties (Appearance)
ScreenGui.Name = "KryntTestUI"
ScreenGui.Parent = game.CoreGui -- This makes it stay even if you reset

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.Position = UDim2.new(0.5, -50, 0.5, -25) -- Center of screen
MainFrame.Size = UDim2.new(0, 150, 0, 70)
MainFrame.Active = true
MainFrame.Draggable = true -- Allows you to move it on mobile

ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Red (OFF)
ToggleBtn.Size = UDim2.new(1, -10, 1, -10)
ToggleBtn.Position = UDim2.new(0, 5, 0, 5)
ToggleBtn.Text = "Auto Roll: OFF"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 14

-- 3. Logic Variables
local active = false
local path = workspace.Plots.Plot_1.Plot_Models.BaseModel.ButtonModel.PacketClick.ClickDetector

-- 4. Toggle Function
ToggleBtn.MouseButton1Click:Connect(function()
    active = not active
    
    if active then
        ToggleBtn.Text = "Auto Roll: ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- Green (ON)
        
        -- Start the clicking loop
        task.spawn(function()
            while active do
                if path then
                    fireclickdetector(path)
                end
                task.wait(0.3)
            end
        end)
    else
        ToggleBtn.Text = "Auto Roll: OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- Red
    end
end)
