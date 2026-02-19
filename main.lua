local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "👆 Krynt Hub TapSim",
   Icon = 0, 
   LoadingTitle = "Tap Simulator Script",
   LoadingSubtitle = "by Krynt",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KryntHub", 
      FileName = "TapSimConfig"
   },
   -- TRANSPARENCY SETTING
   Transparent = true, 
   
   KeySystem = true,
   KeySettings = {
      Title = "Tap Simulator Keys",
      Subtitle = "Key System",
      Note = "The key is in your GitHub key.txt!",
      FileName = "KryntKeyCache", 
      SaveKey = true, 
      GrabKeyFromSite = true,
      Key = {"https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/key.txt"} 
   }
})

-- MAIN TAB (Automation)
local MainTab = Window:CreateTab("Automation", 4483362458)

local Toggle = MainTab:CreateToggle({
   Name = "Auto Tap",
   CurrentValue = false,
   Flag = "AutoTap1", 
   Callback = function(Value)
      _G.AutoTap = Value
      while _G.AutoTap do
         task.wait(0.01)
         -- TRYING COMMON REMOTE NAMES (Edit 'Click' if your game uses 'Tap' or 'AddClick')
         local remote = game:GetService("ReplicatedStorage"):FindFirstChild("Click", true) or 
                        game:GetService("ReplicatedStorage"):FindFirstChild("Tap", true)
         
         if remote and remote:IsA("RemoteEvent") then
            remote:FireServer()
         end
      end
   end,
})

-- PLAYER TAB (Speed & Jump)
local PlayerTab = Window:CreateTab("Player", 4483362458)

local SpeedSlider = PlayerTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 1000},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

local JumpToggle = PlayerTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      _G.InfiniteJump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if _G.InfiniteJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
         end
      end)
   end,
})

Rayfield:LoadConfiguration()
