
-- [[ KRYNT HUB OFFICIAL LOADER ]]
local GITHUB_KEY_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/key.txt"
local GITHUB_MAIN_URL = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/main.lua"

-- Ensure Orion is loaded safely
local success, OrionLib = pcall(function() 
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Orion/main/source'))() 
end)

if not success then 
    warn("Krynt Hub: Failed to load Orion Library. Internet or Executor issue.")
    return 
end

local Window = OrionLib:MakeWindow({Name = "Krynt Hub | Key System", HidePremium = true, SaveConfig = false, IntroEnabled = false})
local Tab = Window:MakeTab({Name = "Key System", Icon = "rbxassetid://4483345998"})

Tab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        local keySuccess, CorrectKey = pcall(function() return game:HttpGet(GITHUB_KEY_URL) end)
        
        if keySuccess then
            -- Remove any hidden spaces/newlines
            local cleanCorrectKey = CorrectKey:gsub("%s+", "")
            local cleanInput = Value:gsub("%s+", "")

            if cleanInput == cleanCorrectKey then
                OrionLib:MakeNotification({Name = "Verified", Content = "Loading Krynt Hub...", Time = 3})
                task.wait(1)
                OrionLib:Destroy()
                
                -- Final Load of Main Script
                local mainSuccess, mainCode = pcall(function() return game:HttpGet(GITHUB_MAIN_URL) end)
                if mainSuccess then
                    loadstring(mainCode)()
                else
                    warn("Krynt Hub: Could not find main.lua")
                end
            else
                OrionLib:MakeNotification({Name = "Error", Content = "Wrong Key!", Time = 3})
            end
        else
            warn("Krynt Hub: Could not connect to GitHub key file.")
        end
    end      
})
