local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Prevent duplicate GUIs
if CoreGui:FindFirstChild("KryntPSLoader") then
    CoreGui.KryntPSLoader:Destroy()
end

-- Create UI
local sg = Instance.new("ScreenGui")
sg.Name = "KryntPSLoader"
sg.Parent = CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 180)
main.Position = UDim2.new(0.5, -150, 0.5, -90)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Parent = sg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Krynt Hub"
title.TextColor3 = Color3.fromRGB(0, 255, 120) -- Green accent
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = main

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 20)
subTitle.Position = UDim2.new(0, 0, 0, 35)
subTitle.Text = "Private Server Copy/Paster"
subTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subTitle.TextSize = 14
subTitle.Font = Enum.Font.Gotham
subTitle.BackgroundTransparency = 1
subTitle.Parent = main

-- Status/Action Label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 40)
statusLabel.Position = UDim2.new(0, 20, 0, 80)
statusLabel.Text = "Loading PS Link..."
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.TextSize = 16
statusLabel.Font = Enum.Font.GothamSemibold
statusLabel.BackgroundTransparency = 1
statusLabel.Parent = main

-- Copy Button (Hidden initially)
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 200, 0, 35)
copyBtn.Position = UDim2.new(0.5, -100, 0, 125)
copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
copyBtn.Text = "Copy PS Link"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.Visible = false
copyBtn.Parent = main

local btnCorner = Instance.new("UICorner", copyBtn)

-- Close Button
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "X"
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.BackgroundTransparency = 1
close.Parent = main
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- Script Logic
task.wait(1.5) -- Fake loading for effect

local code = game.PrivateServerLinkCode
if code and code ~= "" then
    local fullLink = "https://www.roblox.com/share?code=" .. code .. "&type=Server"
    statusLabel.Text = "Link Found!"
    copyBtn.Visible = true
    
    copyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(fullLink)
            copyBtn.Text = "COPIED!"
            copyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 70)
            task.wait(2)
            copyBtn.Text = "Copy PS Link"
            copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        else
            statusLabel.Text = "Clipboard not supported!"
        end
    end)
else
    statusLabel.Text = "No PS Link Found"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
end
