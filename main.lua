-- 1. LOAD THE UI LIBRARY
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- 2. CREATE THE MAIN WINDOW
local Window = OrionLib:MakeWindow({
    Name = "My Knife Farm Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "KnifeFarmConfig"
})

-- 3. SETUP YOUR PLOT LOGIC
local player = game.Players.LocalPlayer
local myPlot = nil

-- This function looks for your plot
local function findPlot()
    for _, p in pairs(workspace.Plots:GetChildren()) do
        local ownerValue = p:FindFirstChild("Owner")
        if ownerValue and ownerValue.Value == player.Name then
            return p
        end
    end
    return nil
end

myPlot = findPlot()

-- 4. CREATE THE TAB
local MainTab = Window:MakeTab({
    Name = "Auto Roll",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

-- 5. ADD THE TOGGLE
MainTab:AddToggle({
    Name = "Enable Auto-Roll",
    Default = false,
    Callback = function(Value)
        _G.AutoRoll = Value
        
        if Value then
            -- Refresh plot check in case it wasn't found at execution
            if not myPlot then myPlot = findPlot() end
            
            if myPlot then
                local myButton = myPlot.Plot_Models.BaseModel.ButtonModel.PacketClick.ClickDetector
                
                task.spawn(function()
                    while _G.AutoRoll do
                        if myButton then
                            fireclickdetector(myButton)
                        end
                        task.wait(0.3) -- Cooldown for mobile stability
                    end
                end)
            else
                -- Notify user if plot is still missing
                OrionLib:MakeNotification({
                    Name = "Plot Error",
                    Content = "Could not find your plot. Try claiming one first!",
                    Image = "rbxassetid://4483362458",
                    Time = 5
                })
            end
        end
    end    
})

-- 6. INITIALIZE UI
OrionLib:Init()
