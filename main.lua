-- [[ KRYNT HUB - MY KNIFE FARM V4.3 (VERIFIED NAMES) ]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CaseRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("CaseTriggered")

-- // CONFIGURATION TABLES //
_G.AutoRoll = false
_G.AutoBuy = false

local SelectedCases = {}
local SelectedMutations = {}

-- EXACT LIST FROM YOUR DECOMPILED CardImages
local CasesList = {
    "Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", 
    "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", 
    "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"
}

-- EXACT LIST FROM YOUR DECOMPILED EventRarityMultipler
local MutationsList = {
    "Rusty", "Normal", "Golden", "Space", "Blood", 
    "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"
}

-- // UI SETUP // (Standard Krynt Hub UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHub_Verified"; ScreenGui.Parent = game:GetService("CoreGui"); ScreenGui.ResetOnSpawn = false
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 300); MainFrame.Position = UDim2.new(0.5, -175, 0.3, 0); MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); MainFrame.Draggable = true; MainFrame.Active = true; MainFrame.Parent = ScreenGui
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35); Title.Text = "KRYNT HUB: VERIFIED SNIPER"; Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Title.TextColor3 = Color3.new(1, 1, 1); Title.Parent = MainFrame

-- Scrolling Lists
local function createScroll(pos, titleText)
    local label = Instance.new("TextLabel", MainFrame)
    label.Size = UDim2.new(0.45, 0, 0, 20); label.Position = UDim2.new(pos.X.Scale, 0, 0.15, 0); label.Text = titleText; label.TextColor3 = Color3.new(1,1,1); label.BackgroundTransparency = 1
    local scroll = Instance.new("ScrollingFrame", MainFrame)
    scroll.Size = UDim2.new(0.45, 0, 0, 120); scroll.Position = UDim2.new(pos.X.Scale, 0, 0.22, 0); scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30); scroll.CanvasSize = UDim2.new(0, 0, 4, 0); scroll.ScrollBarThickness = 4
    Instance.new("UIListLayout", scroll).Padding = UDim.new(0, 2)
    return scroll
end

local CaseScroll = createScroll(UDim2.new(0.02, 0, 0, 0), "CASES")
local MutScroll = createScroll(UDim2.new(0.53, 0, 0, 0), "MUTATIONS")

local function populate(list, scroll, targetTable)
    for _, name in pairs(list) do
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, -5, 0, 25); btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45); btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        btn.MouseButton1Click:Connect(function()
            targetTable[name] = not targetTable[name]
            btn.BackgroundColor3 = targetTable[name] and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(45, 45, 45)
            btn.TextColor3 = targetTable[name] and Color3.new(1, 1, 1) or Color3.new(0.7, 0.7, 0.7)
        end)
    end
end

populate(CasesList, CaseScroll, SelectedCases)
populate(MutationsList, MutScroll, SelectedMutations)

local RollBtn = Instance.new("TextButton", MainFrame); RollBtn.Size = UDim2.new(0.45, 0, 0, 35); RollBtn.Position = UDim2.new(0.02, 0, 0.7, 0); RollBtn.Text = "AUTO-ROLL: OFF"; RollBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); RollBtn.TextColor3 = Color3.new(1,1,1)
local BuyBtn = Instance.new("TextButton", MainFrame); BuyBtn.Size = UDim2.new(0.45, 0, 0, 35); BuyBtn.Position = UDim2.new(0.53, 0, 0.7, 0); BuyBtn.Text = "AUTO-BUY: OFF"; BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); BuyBtn.TextColor3 = Color3.new(1,1,1)

-- // LOGIC //

local function getMyPlot()
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot:GetAttribute("Owner") == lp.UserId then return plot end
    end
end

task.spawn(function()
    while true do
        local plot = getMyPlot()
        if plot then
            local packet = plot:FindFirstChild("PacketClick", true)
            
            if _G.AutoRoll and packet and packet:FindFirstChild("ClickDetector") then
                fireclickdetector(packet.ClickDetector)
            end

            if _G.AutoBuy and packet then
                local textObj = packet:FindFirstChildOfClass("TextLabel", true) or packet:FindFirstChildOfClass("StringValue", true)
                if textObj then
                    local content = string.lower(textObj:IsA("TextLabel") and textObj.Text or textObj.Value)
                    
                    for caseName, active in pairs(SelectedCases) do
                        if active and string.find(content, string.lower(caseName)) then
                            -- Check Mutations
                            local mutActiveCount = 0
                            for _, mActive in pairs(SelectedMutations) do if mActive then mutActiveCount = mutActiveCount + 1 end end

                            local matchedMutation = (mutActiveCount == 0) -- True if no filter set
                            if not matchedMutation then
                                for mutName, mActive in pairs(SelectedMutations) do
                                    if mActive and string.find(content, string.lower(mutName)) then
                                        matchedMutation = true
                                        break
                                    end
                                end
                            end

                            if matchedMutation then
                                -- DEBUG PRINT: Check F9 console to see if this fires
                                print("Krynt Hub Attempting Buy: " .. caseName)
                                CaseRemote:Fire
