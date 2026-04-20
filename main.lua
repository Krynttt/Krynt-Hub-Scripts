local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Cleanup duplicate GUIs
if CoreGui:FindFirstChild("KryntPSLoader") then
    CoreGui.KryntPSLoader:Destroy()
end

-- Main UI Setup
local sg = Instance.new("ScreenGui")
sg.Name = "KryntPSLoader"
sg.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 320, 0, 200)
main.Position = UDim2.new(0.5, -160, 0.5, -100)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true -- You can move it around
main.Parent = sg

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 10)

-- Header
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Text = "Krynt Hub"
title.TextColor3 = Color3.fromRGB(0, 255, 150)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = main

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 20)
subTitle.Position = UDim2.new(0, 0, 0, 38)
subTitle.Text = "Private Server Copy/Paster"
subTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subTitle.TextSize = 13
subTitle.Font = Enum.Font.Gotham
subTitle.BackgroundTransparency = 1
subTitle.Parent = main

-- The Display/Status Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 280, 0, 40)
statusLabel.Position = UDim2.new(0.5, -140, 0, 75)
statusLabel.Text = "Status: Ready"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 14
statusLabel.Font = Enum.Font.Code
statusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
statusLabel.Parent = main
Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0, 6)

-- The Button to trigger the action
local actionBtn = Instance.new("TextButton")
actionBtn.Size = UDim2.new(0, 280, 0, 45)
actionBtn.Position = UDim2.new(0.5, -140, 0, 130)
actionBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
actionBtn.Text = "GET PS LINK"
actionBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
actionBtn.Font = Enum.Font.GothamBold
actionBtn.TextSize = 16
actionBtn.Parent = main

local btnCorner = Instance.new("UICorner", actionBtn)

-- Close Button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 25
close.BackgroundTransparency = 1
close.Parent = main
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Script Functionality
actionBtn.MouseButton1Click:Connect(function()
    actionBtn.Text = "LOADING..."
    actionBtn.Active = false
    task.wait(1) -- Visual feedback delay
    
    local code = game.PrivateServerLinkCode
    
    if code and code ~= "" then
        local fullLink = "https://www.roblox.com/share?code=" .. code .. "&type=Server"
        
        -- Show the link in the status box
        statusLabel.Text = "Link: " .. code:sub(1,10) .. "..." 
        
        -- Copy to clipboard
        if setclipboard then
            setclipboard(fullLink)
            actionBtn.Text = "COPIED TO CLIPBOARD!"
            actionBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        else
            actionBtn.Text = "COPIED (Manual backup in console)"
            print("Full Link: " .. fullLink)
        end
    else
        statusLabel.Text = "ERROR: No PS Code Found!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        actionBtn.Text = "TRY AGAIN"
        actionBtn.Active = true
    end
end)
