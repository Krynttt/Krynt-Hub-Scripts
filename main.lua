-- [[ KRYNT HUB - TAP SIMULATOR PRO ]]
if game.GameId == 8779464785 or game.PlaceId == 9492820210 then

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Krynt Hub | Tap Simulator", "BloodTheme")

    -- [[ MINIMIZE BUTTON ]]
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local OpenBtn = Instance.new("TextButton", ScreenGui)
    OpenBtn.Size = UDim2.new(0, 45, 0, 45)
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
    local Section = Main:NewSection("Fast Farming")
    
    local Eggs = Window:NewTab("Eggs")
    local ESection = Eggs:NewSection("Fast Hatching")

    -- [[ 0.1s REMOTE TAP TOGGLE ]]
    _G.AutoTap = false
    Section:NewToggle("Super Fast Tap (0.1s)", "Turn ON to start tapping", function(state)
        _G.AutoTap = state
        if state then
            print("Auto Tap: STARTED")
            spawn(function()
                while _G.AutoTap do
                    game:GetService("ReplicatedStorage").Events.Tap:FireServer()
                    task.wait(0.1)
                end
                print("Auto Tap: STOPPED")
            end)
        end
    end)

    -- [[ 0.1s RAINBOW EGG HATCH TOGGLE ]]
    _G.FastHatch = false
    ESection:NewToggle("Fast Hatch Rainbow Egg", "Turn ON to start hatching", function(state)
        _G.FastHatch = state
        if state then
            print("Fast Hatch: STARTED")
            spawn(function()
                while _G.FastHatch do
                    local args = {
                        [1] = "Rainbow Egg",
                        [2] = "Single" 
                    }
                    game:GetService("ReplicatedStorage").Events.Hatch:InvokeServer(unpack(args))
                    task.wait(0.1)
                end
                print("Fast Hatch: STOPPED")
            end)
        end
    end)

    -- [[ SETTINGS ]]
    local Settings = Window:NewTab("Settings")
    Settings:NewSection("Management"):NewButton("Destroy Script", "Remove everything", function()
        _G.AutoTap = false
        _G.FastHatch = false
        ScreenGui:Destroy()
        Library:ToggleUI()
    end)

else
    print("Wrong Game")
end
