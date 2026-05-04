-- ==========================================
-- KRYNT HUB V4: AUTO ROLL + AUTO BUY + EXIT
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- CLEANUP: Delete old menu if you re-execute
if CoreGui:FindFirstChild("KryntHubV4") then
    CoreGui.KryntHubV4:Destroy()
end

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

local SelectedCases = {}
local SelectedMutations = {}
local AutoBuyActive = false
local AutoRollActive = false

-- ==========================================
-- 1. UI CONSTRUCTION
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KryntHubV4"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 340)
Main.Position = UDim2.new(0.5, -180, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Draggable = true
Main.Active = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Text = " KRYNT HUB V4"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- EXIT BUTTON
local ExitBtn = Instance.new("TextButton", Main)
ExitBtn.Size = UDim2.new(0, 30, 0, 30)
ExitBtn.Position = UDim2.new(1, -30, 0, 0)
ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1,1,1)
ExitBtn.Font = Enum.Font.GothamBold

-- ROLL BUTTON
local RollBtn = Instance.new("TextButton", Main)
RollBtn.Size = UDim2.new(0.5, -15, 0, 35)
RollBtn.Position = UDim2.new(0, 10, 0, 250)
RollBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
RollBtn.Text = "AUTO ROLL: OFF"
RollBtn.TextColor3 = Color3.new(1,1,1)
RollBtn.Font = Enum.Font.Code

-- BUY BUTTON
local BuyBtn = Instance.new("TextButton", Main)
BuyBtn.Size = UDim2.new(0.5, -15, 0, 35)
BuyBtn.Position = UDim2.new(0.5, 5, 0, 250)
BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
BuyBtn.Text = "AUTO BUY: OFF"
BuyBtn.TextColor3 = Color3.new(1,1,1)
BuyBtn.Font = Enum.Font.Code

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 300)
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.new(0.8, 0.8, 0.8)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Code

-- SCROLLING MENUS
local function CreateScroll(name, xPos, list, targetTable)
    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Size = UDim2.new(0.45, 0, 0, 180)
    Scroll.Position = UDim2.new(xPos, 0, 0, 60)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #list * 25)
    Scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Scroll.ScrollBarThickness = 4
    
    local UIList = Instance.new("UIListLayout", Scroll)

    for _, item in pairs(list) do
        local b = Instance.new("TextButton", Scroll)
        b.Size = UDim2.new(1, -5, 0, 22)
        b.Text = item
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        b.TextColor3 = Color3.new(1, 1, 1)
        b.Font = Enum.Font.Code
        
        b.MouseButton1Click:Connect(function()
            if targetTable[item] then
                targetTable[item] = nil
                b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            else
                targetTable[item] = true
                b.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
            end
        end)
    end
end

CreateScroll("Cases", 0.03, CASES, SelectedCases)
CreateScroll("Mutations", 0.52, MUTATIONS, SelectedMutations)


-- ==========================================
-- 2. CORE FUNCTIONS
-- ==========================================

-- Count how many mutations are selected
local function getMutationCount()
    local count = 0
    for _, _ in pairs(SelectedMutations) do count = count + 1 end
    return count
end

-- Find nearest roll button
local function getNearestClickDetector()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local rootPos = char.HumanoidRootPart.Position
    local closest, shortestDist = nil, 20
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") and obj.Parent and obj.Parent:IsA("BasePart") then
            local dist = (obj.Parent.Position - rootPos).Magnitude
            if dist < shortestDist then
                shortestDist = dist
                closest = obj
            end
        end
    end
    return closest
end

-- Smarter Case Finder (Checks plot first, then whole map)
local function fireCase(caseName)
    -- Attempt 1: Check Plot
    local plotsFolder = workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in pairs(plotsFolder:GetChildren()) do
            local ownerVal = plot:FindFirstChild("Owner")
            if ownerVal and ownerVal.Value == lp.Name then
                local c = plot:FindFirstChild(caseName, true)
                if c then
                    local cd = c:FindFirstChildOfClass("ClickDetector")
                    if cd then fireclickdetector(cd); return end
                end
            end
        end
    end
    
    -- Attempt 2: Backup Map Search (If plot logic fails)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == caseName then
            local cd = obj:FindFirstChildOfClass("ClickDetector")
            if cd then fireclickdetector(cd); return end
        end
    end
end

-- Check Events Folder
local function hasTargetMutation()
    if getMutationCount() == 0 then return false end -- If none selected, never stop!
    
    local events = lp:FindFirstChild("Events", true)
    if events then
        for mutName, _ in pairs(SelectedMutations) do
            if events:FindFirstChild(mutName) then return true end
        end
    end
    return false
end

-- ==========================================
-- 3. BUTTON CONNECTIONS
-- ==========================================

ExitBtn.MouseButton1Click:Connect(function()
    AutoBuyActive = false
    AutoRollActive = false
    ScreenGui:Destroy()
end)

RollBtn.MouseButton1Click:Connect(function()
    AutoRollActive = not AutoRollActive
    RollBtn.Text = AutoRollActive and "AUTO ROLL: ON" or "AUTO ROLL: OFF"
    RollBtn.BackgroundColor3 = AutoRollActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if AutoRollActive then
        Status.Text = "Status: Rolling nearest button..."
        task.spawn(function()
            while AutoRollActive do
                local target = getNearestClickDetector()
                if target then fireclickdetector(target) end
                task.wait(0.05)
            end
        end)
    end
end)

BuyBtn.MouseButton1Click:Connect(function()
    -- Check if they selected a case first
    local hasCases = false
    for _, _ in pairs(SelectedCases) do hasCases = true; break end
    if not hasCases then 
        Status.Text = "Status: Select a Case first!"
        return 
    end

    AutoBuyActive = not AutoBuyActive
    BuyBtn.Text = AutoBuyActive and "AUTO BUY: ON" or "AUTO BUY: OFF"
    BuyBtn.BackgroundColor3 = AutoBuyActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    if AutoBuyActive then
        if getMutationCount() == 0 then
            Status.Text = "Status: Infinite Buy Mode (No Mutations Selected)"
        else
            Status.Text = "Status: Hunting for Mutations..."
        end

        task.spawn(function()
            while AutoBuyActive do
                if hasTargetMutation() then
                    AutoBuyActive = false
                    BuyBtn.Text = "AUTO BUY: OFF"
                    BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                    Status.Text = "Status: MATCH FOUND! STOPPED."
                    break
                end
                
                for caseName, _ in pairs(SelectedCases) do
                    fireCase(caseName)
                end
                task.wait(0.1)
            end
        end)
    end
end)
