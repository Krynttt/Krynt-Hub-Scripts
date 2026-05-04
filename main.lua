-- ==========================================
-- KRYNT HUB: AUTO ROLL + AUTO BUY SNIPER
-- ==========================================

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

local SelectedCases = {}
local SelectedMutations = {}
local AutoBuyActive = false
local AutoRollActive = false
local lp = game.Players.LocalPlayer

-- ==========================================
-- 1. UI CONSTRUCTION
-- ==========================================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "KryntHubV3"

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 340)
Main.Position = UDim2.new(0.5, -180, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Main.Draggable = true
Main.Active = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "KRYNT HUB: ALL-IN-ONE"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.Code
Title.TextSize = 14

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
            targetTable[item] = not targetTable[item]
            b.BackgroundColor3 = targetTable[item] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(50, 50, 50)
        end)
    end
end

CreateScroll("Cases", 0.03, CASES, SelectedCases)
CreateScroll("Mutations", 0.52, MUTATIONS, SelectedMutations)


-- ==========================================
-- 2. CORE FUNCTIONS
-- ==========================================

-- Function 1: Find the nearest button to you (For Auto-Roll)
local function getNearestClickDetector()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local rootPos = char.HumanoidRootPart.Position
    local closest = nil
    local shortestDist = 20 -- Will only look for buttons within 20 studs
    
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

-- Function 2: Find the specific Cases on your plot
local function fireCaseOnPlot(caseName)
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot:FindFirstChild("Owner") and plot.Owner.Value == lp.Name then
            local c = plot:FindFirstChild(caseName, true)
            if c then
                local cd = c:FindFirstChildOfClass("ClickDetector")
                if cd then fireclickdetector(cd) end
            end
        end
    end
end

-- Function 3: Check if you got the Mutation
local function hasTargetMutation()
    local events = lp:FindFirstChild("Events", true)
    if events then
        for mutName, isSelected in pairs(SelectedMutations) do
            if isSelected and events:FindFirstChild(mutName) then 
                return true 
            end
        end
    end
    return false
end


-- ==========================================
-- 3. THE LOOPS (The Automation)
-- ==========================================

-- AUTO ROLL LOOP (Uses nearest detector)
RollBtn.MouseButton1Click:Connect(function()
    AutoRollActive = not AutoRollActive
    RollBtn.Text = AutoRollActive and "AUTO ROLL: ON" or "AUTO ROLL: OFF"
    RollBtn.BackgroundColor3 = AutoRollActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    if AutoRollActive then
        Status.Text = "Status: Auto-Rolling nearest button..."
        task.spawn(function()
            while AutoRollActive do
                local target = getNearestClickDetector()
                if target then
                    fireclickdetector(target)
                end
                task.wait(0.05) -- Fast clicking
            end
        end)
    end
end)

-- AUTO BUY LOOP (Uses Case names)
BuyBtn.MouseButton1Click:Connect(function()
    AutoBuyActive = not AutoBuyActive
    BuyBtn.Text = AutoBuyActive and "AUTO BUY: ON" or "AUTO BUY: OFF"
    BuyBtn.BackgroundColor3 = AutoBuyActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    if AutoBuyActive then
        Status.Text = "Status: Auto-Buying cases..."
        task.spawn(function()
            while AutoBuyActive do
                -- Stop if we hit the mutation
                if hasTargetMutation() then
                    AutoBuyActive = false
                    BuyBtn.Text = "AUTO BUY: OFF"
                    BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
                    Status.Text = "Status: MATCH FOUND! STOPPING."
                    break
                end
                
                -- Buy the selected cases
                for caseName, isSelected in pairs(SelectedCases) do
                    if isSelected then 
                        fireCaseOnPlot(caseName) 
                    end
                end
                task.wait(0.1)
            end
        end)
    end
end)
