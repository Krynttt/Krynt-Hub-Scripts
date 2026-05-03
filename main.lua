-- 1. Load UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Knife Farm Hub", HidePremium = false, SaveConfig = true})

-- 2. Variables
local player = game.Players.LocalPlayer
local myPlot = nil

-- 3. Find YOUR Plot (Dynamic replacement for Plot_1)
for _, p in pairs(workspace.Plots:GetChildren()) do
    if p:FindFirstChild("Owner") and p.Owner.Value == player.Name then
        myPlot = p
        break
    end
end

-- 4. Create the UI Tab
local MainTab = Window:MakeTab({
    Name = "Auto Roll",
    Icon = "rbxassetid://4483362458"
})

-- 5. The Toggle using your Correct Path
MainTab:AddToggle({
    Name = "Enable Auto-Roll",
    Default = false,
    Callback = function(Value)
        _G.AutoRoll = Value
        
        if Value and myPlot then
            -- This uses your exact path, but starts from 'myPlot' instead of 'Plot_1'
            local detector = myPlot.Plot_Models.BaseModel.ButtonModel.PacketClick.ClickDetector
            
            task.spawn(function()
                while _G.AutoRoll do
                    if detector then
                        fireclickdetector(detector)
                    end
                    task.wait(0.3)
                end
            end)
        elseif Value and not myPlot then
            warn("Could not find your plot! Make sure you claimed one.")
        end
    end    
})

OrionLib:Init()
