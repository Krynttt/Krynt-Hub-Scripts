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
      Note = "Check your GitHub key.txt",
      FileName = "KryntKeyCache", 
      SaveKey = true, 
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/key.txt"} 
   }
})

-- Variables
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- ANTI-AFK LOGIC (Runs automatically)
local VirtualUser = game:GetService("VirtualUser")
Player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- MAIN TAB
local MainTab = Window:CreateTab("Automation", 4483362458)

local Toggle = MainTab:CreateToggle({
   Name = "Auto Tap (Fast)",
   CurrentValue = false,
   Flag = "AutoTap1", 
   Callback = function(Value)
      _G.AutoTap = Value
      task.spawn(function()
         while _G.AutoTap do
            -- This looks for common Tap Simulator remote names
            local args = { [1] = 1 } -- Some games require a number argument
            local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Tap", true) or 
                           game:GetService("ReplicatedStorage"):FindFirstChild("Click", true) or
                           game:GetService("ReplicatedStorage"):FindFirstChild("AddTap", true)
            
            if remote then
                remote:FireServer(unpack(args))
            end
            task.wait(0.01) 
         end
      end)
   end,
})

-- PLAYER TAB
local PlayerTab = Window:CreateTab("Player", 4483362458)

local SpeedSlider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 1000},
   Increment = 1,
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      _G.WSValue = Value
      -- Looping the speed so it doesn't reset when the UI is closed
      task.spawn(function()
         while _G.WSValue == Value do
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                Player.Character.Humanoid.WalkSpeed = Value
            end
            task.wait(0.1)
         end
      end)
   end,
})

local JumpToggle = PlayerTab:CreateToggle({
   Name = "Real Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      _G.InfiniteJump = Value
   end,
})

-- Physical Jump Logic (Fixed for "Real Jump")
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfiniteJump then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

Rayfield:LoadConfiguration()
