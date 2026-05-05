-- ==========================================
-- KRYNT HUB V6: GHOST TELEPORT & ANYWHERE BUY
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

if CoreGui:FindFirstChild("KryntHubV6") then
    CoreGui.KryntHubV6:Destroy()
end

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

local SelectedCases = {}
local SelectedMutations = {}
local AutoBuyActive = false
local AutoRollActive = false
local SavedRollDetector = nil -- Saves your specific roll button

-- ==========================================
-- 1. UI CONSTRUCTION
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KryntHubV6"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 380)
Main.Position = UDim2.new(0.5, -180, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Draggable = true
Main.Active = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Text = " KRYNT HUB V6 (GHOST BYPASS)"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.Code
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local ExitBtn = Instance.new("TextButton", Main)
ExitBtn.Size = UDim2.new(0, 30, 0, 30)
ExitBtn.Position = UDim2.new(1, -30, 0, 0)
ExitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ExitBtn.Text = "X"
ExitBtn.TextColor3 = Color3.new(1,1,1)
ExitBtn.Font = Enum.Font.GothamBold

-- SET ROLL TARGET BUTTON (NEW)
local SetRollBtn = Instance.new("TextButton", Main)
SetRollBtn.Size = UDim2.new(1, -20, 0, 30)
SetRollBtn.Position = UDim2.new(0, 10, 0, 250)
SetRollBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
SetRollBtn.Text = "1. STAND NEAR ROLL BUTTON & CLICK THIS"
SetRollBtn.TextColor3 = Color3.new(1,1,1)
SetRollBtn.Font = Enum.Font.Code
SetRollBtn.TextSize = 12

local RollBtn = Instance.new("TextButton", Main)
RollBtn.Size = UDim2.new(0.5, -15, 0, 35)
RollBtn.Position = UDim2.new(0, 10, 0, 290)
RollBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
RollBtn.Text = "AUTO ROLL: OFF"
RollBtn.TextColor3 = Color3.new(1,1,1)
RollBtn.Font = Enum.Font.Code

local BuyBtn = Instance.new("TextButton", Main)
BuyBtn.Size = UDim2.new(0.5, -15, 0, 35)
BuyBtn.Position = UDim2.new(0.5, 5, 0, 290)
BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
BuyBtn.Text = "AUTO BUY: OFF"
BuyBtn.TextColor3 = Color3.new(1,1,1)
BuyBtn.Font = Enum.Font.Code

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 340)
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.new(0.8, 0.8, 0.8)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Code

local function CreateScroll(name, xPos, list, targetTable)
    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Size = UDim2.new(0.45, 0, 0, 180)
    Scroll.Position = UDim2.new(xPos, 0, 0, 60)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #list * 25)
    Scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Scroll.ScrollBarThickness = 4
    
    Instance.new("UIListLayout", Scroll)

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
-- 2. CORE LOGIC & GHOST TELEPORT
-- ==========================================

local function getMutationCount()
    local count = 0
    for _, _ in pairs(SelectedMutations) do count = count + 1 end
    return count
end

-- NEW: The Ghost Clicker (Bypasses Distance Checks)
local function ghostClick(cd)
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    if not cd or not cd.Parent or not cd.Parent:IsA("BasePart") then return end

    local hrp = char.HumanoidRootPart
    local originalPos = hrp.CFrame

    -- Teleport to the button, wait a tiny fraction of a second for server to see you, click, and return
    hrp.CFrame = cd.Parent.CFrame
    task.wait(0.05) 
    fireclickdetector(cd)
    hrp.CFrame = originalPos
end

local function fireCase(caseName)
    local lowerCaseName = string.lower(caseName)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            local parentName = obj.Parent and string.lower(obj.Parent.Name) or ""
            local modelName = obj.Parent and obj.Parent.Parent and string.lower(obj.Parent.Parent.Name) or ""
            
            if string.find(parentName, lowerCaseName) or string.find(modelName, lowerCaseName) then
                ghostClick(obj)
            end
        end
    end
end

local function hasTargetMutation()
    if getMutationCount() == 0 then return false end
    
    local events = lp:FindFirstChild("Events", true)
    if not events then return false end
    
    for mutName, _ in pairs(SelectedMutations) do
        local lowerMut = string.lower(mutName)
        for _, v in pairs(events:GetDescendants()) do
            if string.find(string.lower(v.Name), lowerMut) then return true end
            if v:IsA("StringValue") and string.find(string.lower(tostring(v.Value)), lowerMut) then return true end
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

SetRollBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
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
    
    if closest then
        SavedRollDetector = closest
        SetRollBtn.Text = "TARGET SAVED! YOU CAN WALK AWAY."
        SetRollBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    else
        SetRollBtn.Text = "NO BUTTON FOUND NEARBY!"
        SetRollBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end
end)

RollBtn.MouseButton1Click:Connect(function()
    if not SavedRollDetector then
        Status.Text = "Status: Set Roll Target first!"
        return
    end

    AutoRollActive = not AutoRollActive
    RollBtn.Text = AutoRollActive and "AUTO ROLL: ON" or "AUTO ROLL: OFF"
    RollBtn.BackgroundColor3 = AutoRollActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if AutoRollActive then
        Status.Text = "Status: Ghost Rolling..."
        task.spawn(function()
            while AutoRollActive do
                if SavedRollDetector then ghostClick(SavedRollDetector) end
                task.wait(0.1) -- Slightly slower so character physics don't break
            end
        end)
    end
end)

BuyBtn.MouseButton1Click:Connect(function()
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
        Status.Text = getMutationCount() == 0 and "Status: Infinite Buy Mode" or "Status: Hunting for Mutations..."

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
                task.wait(0.2)
            end
        end)
    end
end)
