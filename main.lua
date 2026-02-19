local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👆 Krynt Hub TapSim",
   Icon = 0, 
   LoadingTitle = "Tap Simulator Script",
   LoadingSubtitle = "by Krynt",
   ConfigurationSaving = { Enabled = true, FolderName = "KryntHub", FileName = "TapSimConfig" },
   Transparent = true, 
   KeySystem = true,
   KeySettings = {
      Title = "Tap Simulator Keys",
      Subtitle = "Key System",
      Note = "Key is in your github key.txt",
      FileName = "KryntKeyCache", 
      SaveKey = true, 
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/key.txt"} 
   }
})

-- Variables
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- ANTI-AFK (Automatic)
Player.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- TABS
local MainTab = Window:CreateTab("Automation", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

-- AUTO TAP
MainTab:CreateToggle({
   Name = "Auto Tap (Fast)",
   CurrentValue = false,
   Flag = "AutoTap", 
   Callback = function(Value)
      _G.AutoTap = Value
      task.spawn(function()
         while _G.AutoTap do
            pcall(function()
                local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Tap", true) or 
                               game:GetService("ReplicatedStorage"):FindFirstChild("Click", true) or
                               game:GetService("ReplicatedStorage"):FindFirstChild("AddTap", true)
                remote:FireServer(1)
            end)
            task.wait(0.001) 
         end
      end)
   end,
})

-- SPEED & JUMP
PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 1000},
   Increment = 1,
   CurrentValue = 16,
   Flag = "WS",
   Callback = function(Value)
      _G.WSValue = Value
      task.spawn(function()
         while _G.WSValue == Value do
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = Value
            end
            task.wait(0.01)
         end
      end)
   end,
})

PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value) _G.InfiniteJump = Value end,
})

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(3)
    end
end)

-- ESP (VISUALS)
VisualsTab:CreateToggle({
   Name = "Player ESP (Boxes)",
   CurrentValue = false,
   Flag = "ESP",
   Callback = function(Value)
      _G.ESP = Value
      while _G.ESP do
         for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= Player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                if not v.Character.HumanoidRootPart:FindFirstChild("KryntESP") then
                    local Billboard = Instance.new("BillboardGui", v.Character.HumanoidRootPart)
                    Billboard.Name = "KryntESP"
                    Billboard.AlwaysOnTop = true
                    Billboard.Size = UDim2.new(4,0,5,0)
                    local Frame = Instance.new("Frame", Billboard)
                    Frame.Size = UDim2.new(1,0,1,0)
                    Frame.BackgroundTransparency = 0.5
                    Frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    local UIStroke = Instance.new("UIStroke", Frame)
                    UIStroke.Thickness = 2
                end
            end
         end
         task.wait(1)
         if not _G.ESP then
            for _, v in pairs(game.Players:GetPlayers()) do
                if v.Character and v.Character.HumanoidRootPart:FindFirstChild("KryntESP") then
                    v.Character.HumanoidRootPart.KryntESP:Destroy()
                end
            end
         end
      end
   end,
})

Rayfield:LoadConfiguration()
