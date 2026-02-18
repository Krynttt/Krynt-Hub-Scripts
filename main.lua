-- [[ KRYNT HUB - TAP SIMULATOR PRO ]]
if game.GameId == 8779464785 or game.PlaceId == 9492820210 then

    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Krynt Hub | Tap Simulator", "BloodTheme")

    -- [[ DRAGGABLE MINIMIZE BUTTON ]]
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local OpenBtn = Instance.new("TextButton", ScreenGui)
    
    OpenBtn.Name = "KryntToggle"
    OpenBtn.Size = UDim2.new(0, 50, 0, 50)
    OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
    OpenBtn.Text = "K"
    OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    OpenBtn.TextColor3 = Color3.new(1, 1, 1)
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.TextSize = 20
    OpenBtn.Draggable = true -- THIS MAKES IT DRAGGABLE
    
    local UIC = Instance.new("UICorner", OpenBtn)
    UIC.CornerRadius = UDim.new(1, 0) -- Makes it a circle
    
    OpenBtn.MouseButton1Click:Connect(function()
        Library:ToggleUI()
    end)

    -- [[ TABS ]]
    local Main = Window:NewTab("Main")
    local Section = Main:NewSection("Fast Farming")
    
    local Eggs = Window:NewTab("Eggs")
    local ESection = Eggs:NewSection("Fast Hatching")

    -- [[ 0.1s AUTO TAP ]]
    _G.AutoTap = false
    Section:NewToggle("Super Fast Tap (0.1s)", "Auto clicks the remote", function(state)
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

    -- [[ 0.1s RAINBOW EGG HATCH ]]
    _G.FastHatch = false
    ESection:NewToggle("Fast Hatch Rainbow Egg", "Hatch at light speed", function(state)
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

    -- [[ PLAYER TAB ]]
    local Player = Window:NewTab("Player")
    local PSection = Player:NewSection("Movement")
    PSection:NewSlider("Speed", "Walk faster", 250, 16, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
    end)

    -- [[ SETTINGS ]]
    local Settings = Window:NewTab("Settings")
    Settings:NewSection("Script"):NewButton("Destroy Hub", "Removes everything", function()
        _G.AutoTap = false
        _G.FastHatch = false
        ScreenGui:Destroy()
        Library:ToggleUI()
    end)

else
    game.Players.LocalPlayer:Kick("Krynt Hub: Use this in Tap Simulator!")
end
