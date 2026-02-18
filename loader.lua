-- [[ KRYNT HUB CUSTOM KEY SYSTEM ]]
local GITHUB_KEY_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/key.txt"
local GITHUB_MAIN_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/main.lua"

-- Create the UI
local sg = Instance.new("ScreenGui", game.CoreGui)
sg.Name = "KryntKeySystem"

local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
local corner = Instance.new("UICorner", frame)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "KRYNT HUB | KEY"
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.BackgroundTransparency = 1

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0.35, 0)
box.PlaceholderText = "Enter Key Here..."
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
box.TextColor3 = Color3.new(1, 1, 1)
local boxCorner = Instance.new("UICorner", box)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.8, 0, 0, 40)
btn.Position = UDim2.new(0.1, 0, 0.65, 0)
btn.Text = "CHECK KEY"
btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
local btnCorner = Instance.new("UICorner", btn)

-- Logic
btn.MouseButton1Click:Connect(function()
    btn.Text = "Verifying..."
    local s, correctKey = pcall(function() return game:HttpGet(GITHUB_KEY_URL) end)
    
    if s then
        local cleanCorrect = correctKey:gsub("%s+", "")
        local cleanInput = box.Text:gsub("%s+", "")
        
        if cleanInput == cleanCorrect then
            btn.Text = "CORRECT!"
            btn.BackgroundColor3 = Color3.new(0, 1, 0)
            task.wait(1)
            sg:Destroy() -- Remove Key System
            
            -- LOAD THE MAIN SCRIPT
            local s2, mainCode = pcall(function() return game:HttpGet(GITHUB_MAIN_URL) end)
            if s2 then
                loadstring(mainCode)()
            end
        else
            btn.Text = "WRONG KEY!"
            btn.BackgroundColor3 = Color3.new(1, 0, 0)
            task.wait(1)
            btn.Text = "CHECK KEY"
        end
    else
        btn.Text = "CONNECTION ERROR"
    end
end)
