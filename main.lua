-- Simple Power-Up Script
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Increase Jump Power
humanoid.JumpPower = 100
humanoid.UseJumpPower = true

print("Script Loaded Successfully!")
