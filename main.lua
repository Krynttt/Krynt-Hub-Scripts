print("Krynt Hub Loading...")

local Success, Remote = pcall(function()
    return game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Click")
end)

if Success then
    print("Remote Found! Starting Auto-Tap...")
    _G.AutoTap = true
    
    task.spawn(function()
        while _G.AutoTap do
            Remote:FireServer(true)
            task.wait(0.01)
        end
    end)
else
    warn("Failed to find Click remote. Is the game updated?")
end

-- Auto Breakables Logic
task.spawn(function()
    local breakRemote = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Break")
    while true do
        local folder = workspace:FindFirstChild("Breakables")
        if folder then
            for _, v in pairs(folder:GetChildren()) do
                breakRemote:FireServer(v.Name)
            end
        end
        task.wait(0.5)
    end
end)
