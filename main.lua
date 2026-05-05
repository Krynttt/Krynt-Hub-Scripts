-- [[ KRYNT HUB - MY KNIFE FARM V4 (ADVANCED SNIPER) ]]

local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CaseRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game"):WaitForChild("CaseTriggered")

-- // CONFIGURATION TABLES //
_G.AutoRoll = false
_G.AutoBuy = false

local SelectedCases = {}
local SelectedMutations = {}

local CasesList = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Arsenal"}
local MutationsList = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

-- // UI SETUP //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KryntHub_Advanced"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 300)
MainFrame.Position = UDim2.new(0.5, -175, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "KRYNT HUB: ADVANCED SNIPER"
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Parent = MainFrame

-- Scrolling Frames for Selection
local function createScroll(pos, titleText)
    local label = Instance.new("TextLabel", MainFrame)
    label.Size = UDim2.new(0.45, 0, 0, 20)
    label.Position = UDim2.new(pos.X.Scale, 0, 0.15, 0)
    label.Text = titleText
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)

    local scroll = Instance.new("ScrollingFrame", MainFrame)
    scroll.Size = UDim2.new(0.45, 0, 0, 120)
    scroll.Position = UDim2.new(pos.X.Scale, 0, 0.22, 0)
    scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
    scroll.ScrollBarThickness = 4
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 2)
    return scroll
end

local CaseScroll = createScroll(UDim2.new(0.02, 0, 0, 0), "SELECT CASES")
local MutScroll = createScroll(UDim2.new(0.53, 0, 0, 0), "SELECT MUTATIONS")

-- Populate Selection Buttons
local function populate(list, scroll, targetTable)
    for _, name in pairs(list) do
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, -5, 0, 25)
        btn.Text = name
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        
        btn.MouseButton1Click:Connect(function()
            if targetTable[name] then
                targetTable[name] = nil
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                btn.TextColor3 = Color3.new(0.7, 0.7, 0.7)
            else
                targetTable[name] = true
                btn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                btn.TextColor3 = Color3.new(1, 1, 1)
            end
        end)
    end
end

populate(CasesList, CaseScroll, SelectedCases)
populate(MutationsList, MutScroll, SelectedMutations)

-- Main Controls
local RollBtn = Instance.new("TextButton", MainFrame)
RollBtn.Size = UDim2.new(0.45, 0, 0, 35); RollBtn.Position = UDim2.new(0.02, 0, 0.7, 0); RollBtn.Text = "AUTO-ROLL: OFF"; RollBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

local BuyBtn = Instance.new("TextButton", MainFrame)
BuyBtn.Size = UDim2.new(0.45, 0, 0, 35); BuyBtn.Position = UDim2.new(0.53, 0, 0, 7, 0); BuyBtn.Position = UDim2.new(0.53, 0, 0.7, 0); BuyBtn.Text = "AUTO-BUY: OFF"; BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

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
            
            -- AUTO ROLL
            if _G.AutoRoll and packet and packet:FindFirstChild("ClickDetector") then
                fireclickdetector(packet.ClickDetector)
            end

            -- AUTO BUY (SMART FILTER)
            if _G.AutoBuy and packet then
                local textObj = packet:FindFirstChildOfClass("TextLabel", true) or packet:FindFirstChildOfClass("StringValue", true)
                if textObj then
                    local content = string.lower(textObj:IsA("TextLabel") and textObj.Text or textObj.Value)
                    
                    -- Check if any selected Case is in the text
                    local caseMatched = false
                    for caseName, _ in pairs(SelectedCases) do
                        if string.find(content, string.lower(caseName)) then caseMatched = true break end
                    end

                    if caseMatched then
                        -- Check Mutation Filter
                        local mutCount = 0
                        for _ in pairs(SelectedMutations) do mutCount = mutCount + 1 end

                        if mutCount == 0 then
                            -- No mutation selected? Buy the case regardless
                            CaseRemote:FireServer()
                            task.wait(0.4)
                        else
                            -- Mutation selected? Only buy if it matches
                            for mutName, _ in pairs(SelectedMutations) do
                                if string.find(content, string.lower(mutName)) then
                                    CaseRemote:FireServer()
                                    task.wait(0.4)
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Button Connections
RollBtn.MouseButton1Click:Connect(function()
    _G.AutoRoll = not _G.AutoRoll
    RollBtn.Text = "AUTO-ROLL: " .. (_G.AutoRoll and "ON" or "OFF")
    RollBtn.BackgroundColor3 = _G.AutoRoll and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

BuyBtn.MouseButton1Click:Connect(function()
    _G.AutoBuy = not _G.AutoBuy
    BuyBtn.Text = "AUTO-BUY: " .. (_G.AutoBuy and "ON" or "OFF")
    BuyBtn.BackgroundColor3 = _G.AutoBuy and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

local Exit = Instance.new("TextButton", MainFrame)
Exit.Size = UDim2.new(0, 20, 0, 20); Exit.Position = UDim2.new(0.9, 0, 0, 5); Exit.Text = "X"; Exit.TextColor3 = Color3.new(1,0,0); Exit.BackgroundTransparency = 1
Exit.MouseButton1Click:Connect(function() _G.AutoRoll = false; _G.AutoBuy = false; ScreenGui:Destroy() end)
