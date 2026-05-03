-- 1. LOAD THE UI LIBRARY
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- 2. CREATE THE MAIN WINDOW
local Window = OrionLib:MakeWindow({
    Name = "My Knife Farm Hub", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "KnifeFarmConfig"
})

-- 3. SETUP PLAYER AND PLOT LOGIC
local player = game.Players.LocalPlayer

local function findMyPlot()
    -- This looks through every plot to see if your name is part of the folder name
    for _, p in pairs(workspace.Plots:GetChildren()) do
        if string.find(p.Name, player.Name) then
            return p
        end
    end
    -- Fallback: If the game doesn't name the plot after you, we use Plot_7 as a backup
    return workspace.Plots:FindFirstChild("Plot_7") 
end

local myPlot = findMyPlot()

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
            -- If plot wasn't found at startup, try finding it again
            if not myPlot then myPlot = findMyPlot() end
            
            if myPlot then
                -- This uses the exact path you found in Dex
                local myButton = myPlot.Plot_Models.BaseModel.ButtonModel.PacketClick.ClickDetector
                
                task.spawn(function()
                    while _G.AutoRoll do
                        if myButton then
                            fireclickdetector(myButton)
                        else
                            warn("Button not found in path!")
                            break
                        end
                        task.wait(0.3)
                    end
                end)
            else
                warn("Could not find a plot associated with your name.")
            end
        end
    end    
})

-- 6. INITIALIZE UI
OrionLib:Init()
