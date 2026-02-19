local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Krynt Hub | Tapping Simulator",
   LoadingTitle = "Krynt Hub",
   LoadingSubtitle = "by Krynt",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "KryntHubConfig", 
      FileName = "MainConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = true, -- Key system is now ENABLED
   KeySettings = {
      Title = "Krynt Hub | Key System",
      Subtitle = "Enter Premium Key",
      Note = "Contact Krynt for the key.",
      FileName = "KryntKey", 
      SaveKey = true, 
      GrabKeyFromSite = false,
      Key = {"kryntpremiumkey"} -- Your custom key
   }
})

-- MAIN TAB
local MainTab = Window:CreateTab("Main", 4483362458)
local Section = MainTab:CreateSection("Auto Farm")

local Toggle1 = MainTab:CreateToggle({
   Name = "Auto Tap",
   CurrentValue = false,
   Flag = "KryntTap", 
   Callback = function(Value)
        _G.AutoTap = Value
        task.spawn(function()
            while _G.AutoTap do
                game:GetService("ReplicatedStorage").Events.Tap:FireServer()
                task.wait()
            end
        end)
   end,
})

local Toggle2 = MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Flag = "KryntRebirth", 
    Callback = function(Value)
         _G.AutoRebirth = Value
         task.spawn(function()
             while _G.AutoRebirth do
                 game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(1)
                 task.wait()
             end
         end)
    end,
 })

-- MISC TAB
local MiscTab = Window:CreateTab("Misc", 4483362458)

local Slider1 = MiscTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "KryntSpeed", 
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = Value end
    end,
 })

 local Slider2 = MiscTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 1,
    Suffix = "Jump",
    CurrentValue = 50,
    Flag = "KryntJump", 
    Callback = function(Value)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = Value end
    end,
 })

Rayfield:LoadConfiguration()
