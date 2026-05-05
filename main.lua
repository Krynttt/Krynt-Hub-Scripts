-- ==========================================
-- KRYNT HUB V5: FUZZY SEARCH EDITION
-- ==========================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

if CoreGui:FindFirstChild("KryntHubV5") then
    CoreGui.KryntHubV5:Destroy()
end

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

local SelectedCases = {}
local SelectedMutations = {}
local AutoBuyActive = false
local AutoRollActive = false

-- ==========================================
-- 1. UI CONSTRUCTION (Same as V4)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KryntHubV5"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 340)
Main.Position = UDim2.new(0.5, -180, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Draggable = true
Main.Active = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, -30, 0, 30)
Title.Text = " KRYNT HUB V5 (FUZZY SEARCH)"
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

local RollBtn = Instance.new("TextButton", Main)
RollBtn.Size = UDim2.new(0.5, -15, 0, 35)
RollBtn.Position = UDim2.new(0, 10, 0, 250)
RollBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
RollBtn.Text = "AUTO ROLL: OFF"
RollBtn.TextColor3 = Color3.new(1,1,1)
RollBtn.Font = Enum.Font.Code

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
-- 2. SMART FUZZY SEARCH FUNCTIONS
-- ==========================================

local function getMutationCount()
    local count = 0
    for _, _ in pairs(SelectedMutations) do count = count + 1 end
    return count
end

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

-- NEW: Fuzzy Case Finder
local function fireCase(caseName)
    local lowerCaseName = string.lower(caseName)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            -- Get the names of the part and the model holding it
            local parentName = obj.Parent and string.lower(obj.Parent.Name) or ""
            local modelName = obj.Parent and obj.Parent.Parent and string.lower(obj.Parent.Parent.Name) or ""
            
            -- If the word (e.g. "arsenal") is inside "arsenal case", click it!
            if string.find(parentName, lowerCaseName) or string.find(modelName, lowerCaseName) then
                fireclickdetector(obj)
            end
        end
    end
end

-- NEW: Fuzzy Mutation Finder
local function hasTargetMutation()
    if getMutationCount() == 0 then return false end
    
    local events = lp:FindFirstChild("Events", true)
    if not events then return false end
    
    for mutName, _ in pairs(SelectedMutations) do
        local lowerMut = string.lower(mutName)
        -- Scan EVERYTHING inside the Events folder
        for _, v in pairs(events:GetDescendants()) do
            -- Match the Name of the object or the Value if it's a string
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
                task.wait(0.1)
            end
        end)
    end
end)
