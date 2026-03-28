-- VISIONWARE STYLE CUSTOM SCRIPT
_G.AutoTap = true
_G.AutoBreakables = true

-- [ AUTO TAP LOGIC ]
task.spawn(function()
    local clickRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Click")
    while _G.AutoTap do
        -- Most simulators require a "true" or empty argument to click
        clickRemote:FireServer(true) 
        task.wait(0.01) -- Max Speed
    end
end)

-- [ AUTO BREAKABLES LOGIC ]
task.spawn(function()
    local breakRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Break")
    
    while _G.AutoBreakables do
        -- The script looks through the workspace for items to break
        -- In Clicker Simulator Ultimate, these are usually in a folder called 'Breakables'
        local world = game:GetService("Workspace"):FindFirstChild("Breakables")
        
        if world then
            for _, object in pairs(world:GetChildren()) do
                if not _G.AutoBreakables then break end
                
                -- We tell the server to "Break" this specific object
                if object:IsA("Model") or object:IsA("BasePart") then
                    breakRemote:FireServer(object.Name)
                end
            end
        end
        task.wait(0.5) -- Scans for new breakables every half-second
    end
end)

print("Custom Vision-Logic Loaded: Taps & Breakables ON")
