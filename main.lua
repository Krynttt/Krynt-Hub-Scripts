-- [[ KRYNT HUB - TAP SIMULATOR ULTIMATE ]]
if game.GameId == 8779464785 or game.PlaceId == 9492820210 then

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Krynt Hub | Tap Simulator", "BloodTheme")

    -- [[ ANTI-AFK LOGIC ]]
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)

    -- [[ DRAGGABLE TOGGLE BUTTON ]]
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local OpenBtn = Instance.new("TextButton", ScreenGui)
    OpenBtn.Size = UDim2.new(0, 50, 0, 50)
    OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
    OpenBtn.Text = "K"
    OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    OpenBtn.TextColor3 = Color3.new(1, 1, 1)
    OpenBtn.Draggable = true
    local UIC = Instance.new("UICorner", OpenBtn)
    UIC.CornerRadius = UDim.new(1, 0)
    
    OpenBtn.MouseButton1Click:Connect(function()
        Library:ToggleUI()
    end)

    -- [[ TABS ]]
    local Main = Window:NewTab("Main")
    local Section = Main:NewSection("Auto Farming")
    
    local Eggs = Window:NewTab("Eggs")
    local ESection = Eggs:NewSection("Fast Hatching")

    -- [[ FAST TAP TOGGLE ]]
    _G.AutoTap = false
    Section:NewToggle("Fast Remote Tap (0.1s)", "Taps super fast", function(state)
        _G.AutoTap = state
        if state then
            spawn(function()
                while _G.AutoTap do
                    game:GetService("ReplicatedStorage").Events.Tap:FireServer()
                    task.wait(0.1)
                end
            end)
        end
    end)

    -- [[ FAST HATCH TOGGLE ]]
    _G.FastHatch = false
    ESection:NewToggle("Fast Hatch Rainbow Egg", "0.1s Hatching", function(state)
        _G.FastHatch = state
        if state then
            spawn(function()
                while _G.FastHatch do
                    game:GetService("ReplicatedStorage").Events.Hatch:InvokeServer("Rainbow Egg", "Single")
                    task.wait(0.1)
                end
            end)
        end
    end)

    -- [[ SETTINGS & BATTERY SAVER ]]
    local Settings = Window:NewTab("Settings")
    local SSection = Settings:NewSection("Performance")

    local WhiteScreen = Instance.new("Frame", ScreenGui)
    WhiteScreen.Size = UDim2.new(1, 0, 1, 0)
    WhiteScreen.BackgroundColor3 = Color3.new(1, 1, 1)
    WhiteScreen.Visible = false
    WhiteScreen.ZIndex = 0

    SSection:NewToggle("Battery Saver (White Screen)", "Reduces phone heat", function(state)
        WhiteScreen.Visible = state
    end)

    SSection:NewButton("Destroy Script", "Exit Krynt Hub", function()
        _G.AutoTap = false
        _G.FastHatch = false
        ScreenGui:Destroy()
        Library:ToggleUI()
    end)

else
    game.Players.LocalPlayer:Kick("Krynt Hub: Wrong Game!")
end
