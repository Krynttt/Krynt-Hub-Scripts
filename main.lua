-- This is your actual cheat menu
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Krynt Hub | Tap Simulator", "BloodTheme")

local Main = Window:NewTab("Main")
local Section = Main:NewSection("Tap Simulator Cheats")

Section:NewButton("Auto Tap (Coming Soon)", "Feature in progress", function()
    print("Button clicked!")
end)

Section:NewSlider("Walkspeed", "Speed up", 200, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
