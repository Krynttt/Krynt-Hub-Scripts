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
   KeySystem = true,
   KeySettings = {
      Title = "Tap Simulator Keys",
      Subtitle = "Key System",
      Note = "Join our Discord for the key!",
      FileName = "KryntKeyCache", 
      SaveKey = true, 
      GrabKeyFromSite = true,
      -- This points to your specific GitHub key file
      Key = {"https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/refs/heads/main/key.txt"} 
   }
})

-- Main Tab
local MainTab = Window:CreateTab("Automation", 4483362458)

-- Auto Tap Toggle Logic
local Toggle = MainTab:CreateToggle({
   Name = "Auto Tap",
   CurrentValue = false,
   Flag = "AutoTapFlag", 
   Callback = function(Value)
      _G.AutoTap = Value
      while _G.AutoTap do
         task.wait(0.01) -- Adjust speed here
         -- The line below is a placeholder. 
         -- You'll need the specific RemoteEvent name for the game you're playing.
         game:GetService("ReplicatedStorage").Events.Tap:FireServer() 
      end
   end,
})

-- Section for Credits
local CreditsSection = MainTab:CreateSection("Credits")
MainTab:CreateLabel("Script created by Krynt")

Rayfield:LoadConfiguration()

   
