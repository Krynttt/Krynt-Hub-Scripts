-- [[ KRYNT HUB OFFICIAL LOADER ]]
local GITHUB_KEY_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/key.txt"
local GITHUB_MAIN_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/main.lua"

-- 1. Krynt Hub Intro
local function ShowIntro()
    local sg = Instance.new("ScreenGui", game.CoreGui)
    local f = Instance.new("Frame", sg)
    f.Size = UDim2.new(0, 280, 0, 140)
    f.Position = UDim2.new(0.5, -140, 0.4, 0)
    f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    f.BorderSizePixel = 0
    local corner = Instance.new("UICorner", f)
    corner.CornerRadius = UDim.new(0, 10)

    local t1 = Instance.new("TextLabel", f)
    t1.Size = UDim2.new(1, 0, 0.4, 0)
    t1.Text = "Krynt Hub"
    t1.TextColor3 = Color3.fromRGB(255, 0, 0)
    t1.TextSize = 32
    t1.Font = Enum.Font.GothamBold
    t1.BackgroundTransparency = 1

    local t2 = Instance.new("TextLabel", f)
    t2.Position = UDim2.new(0, 0, 0.4, 0)
    t2.Size = UDim2.new(1, 0, 0.3, 0)
    t2.Text = "Tap Simulator Script"
    t2.TextColor3 = Color3.new(1, 1, 1)
    t2.TextSize = 18
    t2.BackgroundTransparency = 1

    local t3 = Instance.new("TextLabel", f)
    t3.Position = UDim2.new(0, 0, 0.7, 0)
    t3.Size = UDim2.new(1, 0, 0.3, 0)
    t3.Text = "By Krynt"
    t3.TextColor3 = Color3.fromRGB(180, 180, 180)
    t3.TextSize = 14
    t3.BackgroundTransparency = 1

    task.wait(3)
    sg:Destroy()
end

-- 2. Key System (Orion Library)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Krynt Hub | Key System", HidePremium = true, SaveConfig = false, IntroEnabled = false})

local Tab = Window:MakeTab({Name = "Key System", Icon = "rbxassetid://4483345998"})

Tab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        local success, CorrectKey = pcall(function() return game:HttpGet(GITHUB_KEY_URL) end)
        
        -- Clean up the strings
        local cleanCorrectKey = CorrectKey:gsub("%s+", "")
        local cleanInput = Value:gsub("%s+", "")

        if success and cleanInput == cleanCorrectKey then
            OrionLib:MakeNotification({Name = "Verified", Content = "Access Granted!", Time = 5})
            task.wait(1)
            OrionLib:Destroy()
            ShowIntro()
            
            -- Loads the Main Script from your GitHub
            loadstring(game:HttpGet(GITHUB_MAIN_URL))()
        else
            OrionLib:MakeNotification({Name = "Error", Content = "Wrong Key!", Time = 5})
        end
    end      
})

Tab:AddButton({
    Name = "Get Key Link",
    Callback = function()
        setclipboard(GITHUB_KEY_URL)
        OrionLib:MakeNotification({Name = "Copied", Content = "Key link copied!", Time = 5})
    end
})
