-- 1. DATA
local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

-- 2. STATE
local SelectedCases = {}
local SelectedMutations = {}
local AutoBuyActive = false
local AutoRollActive = false

-- 3. UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
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

-- AUTO ROLL BUTTON (The missing feature)
local RollBtn = Instance.new("TextButton", Main)
RollBtn.Size = UDim2.new(0.5, -15, 0, 35)
RollBtn.Position = UDim2.new(0, 10, 0, 250)
RollBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 150)
RollBtn.Text = "AUTO ROLL: OFF"
RollBtn.TextColor3 = Color3.new(1,1,1)

-- AUTO BUY BUTTON
local BuyBtn = Instance.new("TextButton", Main)
BuyBtn.Size = UDim2.new(0.5, -15, 0, 35)
BuyBtn.Position = UDim2.new(0.5, 5, 0, 250)
BuyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
BuyBtn.Text = "AUTO BUY: OFF"
BuyBtn.TextColor3 = Color3.new(1,1,1)

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 300)
Status.Text = "Status: Idle"
Status.TextColor3 = Color3.new(0.7, 0.7, 0.7)
Status.BackgroundTransparency = 1

-- SCROLLING MENUS
local function CreateScroll(name, xPos, list, targetTable)
    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Size = UDim2.new(0.45, 0, 0, 180)
    Scroll.Position = UDim2.new(xPos, 0, 0, 60)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #list * 25)
    Scroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UIListLayout", Scroll)

    for _, item in pairs(list) do
        local b = Instance.new("TextButton", Scroll)
        b.Size = UDim2.new(1, -5, 0, 22)
        b.Text = item
        b.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        b.TextColor3 = Color3.new(1, 1, 1)
        b.MouseButton1Click:Connect(function()
            targetTable[item] = not targetTable[item]
            b.BackgroundColor3 = targetTable[item] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(50, 50, 50)
        end)
    end
end

CreateScroll("Cases", 0.03, CASES, SelectedCases)
CreateScroll("Mutations", 0.52, MUTATIONS, SelectedMutations)

-- 4. LOGIC
local lp = game.Players.LocalPlayer

-- Check for Mutations
local function hasTarget()
    local events = lp:FindFirstChild("Events", true)
    if events then
        for name, selected in pairs(SelectedMutations) do
            if selected and events:FindFirstChild(name) then return true end
        end
    end
    return false
end

-- Find Click Detectors
local function fireDetector(name)
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot:FindFirstChild("Owner") and plot.Owner.Value == lp.Name then
            local target = plot:FindFirstChild(name, true)
            if target then
                local cd = target:FindFirstChildOfClass("ClickDetector")
                if cd then fireclickdetector(cd) end
            end
        end
    end
end

-- AUTO ROLL LOOP
RollBtn.MouseButton1Click:Connect(function()
    AutoRollActive = not AutoRollActive
    RollBtn.Text = AutoRollActive and "AUTO ROLL: ON" or "AUTO ROLL: OFF"
    RollBtn.BackgroundColor3 = AutoRollActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 150)
    
    task.spawn(function()
        while AutoRollActive do
            -- Usually, the main roll button is just called "Roll" or "Clicker"
            -- You can change "Roll" to the name of your main detector
            fireDetector("Roll") 
            task.wait(0.01)
        end
    end)
end)

-- AUTO BUY LOOP
BuyBtn.MouseButton1Click:Connect(function()
    AutoBuyActive = not AutoBuyActive
    BuyBtn.Text = AutoBuyActive and "AUTO BUY: ON" or "AUTO BUY: OFF"
    BuyBtn.BackgroundColor3 = AutoBuyActive and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    task.spawn(function()
        while AutoBuyActive do
            if hasTarget() then
                AutoBuyActive = false
                BuyBtn.Text = "FOUND!"
                Status.Text = "Status: Mutation Found! Stopped."
                break
            end
            
            for case, selected in pairs(SelectedCases) do
                if selected then fireDetector(case) end
            end
            task.wait(0.1)
        end
    end)
end)
