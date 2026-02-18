-- [[ KRYNT HUB - TAP SIMULATOR UNIVERSAL ]]
if game.GameId == 8779464785 or game.PlaceId == 9492820210 then

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Krynt Hub | Tap Simulator", "BloodTheme")

    -- [[ MINIMIZE BUTTON SETUP ]]
    local ScreenGui = Instance.new("ScreenGui")
    local OpenBtn = Instance.new("TextButton")

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "KryntMinimize"

    OpenBtn.Parent = ScreenGui
    OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Red
    OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
    OpenBtn.Size = UDim2.new(0, 50, 0, 50)
    OpenBtn.Text = "K"
    OpenBtn.TextColor3 = Color3.new(1, 1, 1)
    OpenBtn.Draggable = true -- Allows you to move it around your screen

    -- Make it a circle
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 100)
    UICorner.Parent = OpenBtn

    -- Toggle Function
    OpenBtn.MouseButton1Click:Connect(function()
        Library:ToggleUI()
    end)

    -- [[ TABS ]]
    local Main = Window:NewTab("Main")
    local Farm = Main:NewSection("Automatic Farming")
    
    local Settings = Window:NewTab("Settings")
    local Manage = Settings:NewSection("Script Management")

    -- [[ FARMING LOGIC ]]
    _G.AutoTap = false
    Farm:NewToggle("Auto Tap", "Clicks for you", function(state)
        _G.AutoTap = state
        spawn(function()
            while _G.AutoTap do
                game:GetService("ReplicatedStorage").Events.Tap:FireServer()
                task.wait(0.05)
            end
        end)
    end)

    -- [[ CANCEL EXECUTION / DESTROY ]]
    Manage:NewButton("Destroy Script", "Stops everything and removes UI", function()
        _G.AutoTap = false
        _G.AutoRebirth = false
        Library:ToggleUI() -- Hide UI
        ScreenGui:Destroy() -- Remove Minimize Button
        -- Effectively stops the script from running further
    end)

    -- [[ PLAYER TAB ]]
    local Player = Window:NewTab("Player")
    local PSection = Player:NewSection("Character")
    PSection:NewSlider("WalkSpeed", "Speed", 250, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

else
    game.Players.LocalPlayer:Kick("Krynt Hub: Wrong Game!")
end
