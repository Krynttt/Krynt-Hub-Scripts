-- 1. DATA TABLES
local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

-- 2. STATE
local SelectedCases = {}
local SelectedMutations = {}
local IsRunning = false

-- 3. UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 350, 0, 300)
Main.Position = UDim2.new(0.5, -175, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "KRYNT MULTI-SNIPER"
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

-- SCROLLING FRAMES
local function CreateScroll(name, pos, list, targetTable)
    local Label = Instance.new("TextLabel", Main)
    Label.Size = UDim2.new(0.45, 0, 0, 20)
    Label.Position = UDim2.new(pos.X.Scale, pos.X.Offset, 0, 35)
    Label.Text = name
    Label.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    Label.BackgroundTransparency = 1

    local Scroll = Instance.new("ScrollingFrame", Main)
    Scroll.Size = UDim2.new(0.45, 0, 0, 180)
    Scroll.Position = UDim2.new(pos.X.Scale, pos.X.Offset, 0, 55)
    Scroll.CanvasSize = UDim2.new(0, 0, 0, #list * 25)
    Scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    
    local UIList = Instance.new("UIListLayout", Scroll)
    
    for _, item in pairs(list) do
        local Btn = Instance.new("TextButton", Scroll)
        Btn.Size = UDim2.new(1, -10, 0, 20)
        Btn.Text = item
        Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        Btn.TextColor3 = Color3.new(1, 1, 1)
        
        Btn.MouseButton1Click:Connect(function()
            if targetTable[item] then
                targetTable[item] = nil
                Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            else
                targetTable[item] = true
                Btn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
            end
        end)
    end
end

CreateScroll("SELECT CASES", UDim2.new(0, 10, 0, 0), CASES, SelectedCases)
CreateScroll("SELECT MUTATIONS", UDim2.new(0.5, 5, 0, 0), MUTATIONS, SelectedMutations)

-- START BUTTON
local StartBtn = Instance.new("TextButton", Main)
StartBtn.Size = UDim2.new(1, -20, 0, 40)
StartBtn.Position = UDim2.new(0, 10, 0, 245)
StartBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
StartBtn.Text = "START AUTO-BUY"
StartBtn.TextColor3 = Color3.new(1,1,1)

-- 4. LOGIC
local player = game.Players.LocalPlayer

local function checkCurrent()
    local events = player:FindFirstChild("Events", true)
    if events then
        for mutName, _ in pairs(SelectedMutations) do
            if events:FindFirstChild(mutName) then return true end
        end
    end
    return false
end

local function fireOnPlot(caseName)
    for _, plot in pairs(workspace.Plots:GetChildren()) do
        if plot:FindFirstChild("Owner") and plot.Owner.Value == player.Name then
            local c = plot:FindFirstChild(caseName, true)
            if c then
                local cd = c:FindFirstChildOfClass("ClickDetector")
                if cd then fireclickdetector(cd) end
            end
        end
    end
end

StartBtn.MouseButton1Click:Connect(function()
    IsRunning = not IsRunning
    StartBtn.Text = IsRunning and "STOP SNIPER" or "START AUTO-BUY"
    StartBtn.BackgroundColor3 = IsRunning and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    if IsRunning then
        task.spawn(function()
            while IsRunning do
                -- Check if we have ANY of the selected mutations
                if checkCurrent() then
                    IsRunning = false
                    StartBtn.Text = "MATCH FOUND!"
                    break
                end
                
                -- Buy all selected cases in the cycle
                for caseName, _ in pairs(SelectedCases) do
                    fireOnPlot(caseName)
                end
                
                task.wait(0.1)
            end
        end)
    end
end)
