local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Game")

local BuyCaseRemote = GameEvents:WaitForChild("CaseTriggered")
local sellThisRemote = GameEvents:WaitForChild("SellThis")
local SlotDropRemote = GameEvents:WaitForChild("SlotDrop")
local spinRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("Rewards"):WaitForChild("SpinRewards")
local spinAmountLabel = lp.PlayerGui:WaitForChild("SpinUI").MainFrame.SpinAmount
local VirtualUser = game:GetService("VirtualUser")

local myPlot = nil

local function assignMyPlot()
    local function clean(str) return str:gsub("%W", ""):lower() end
    local myCleanName = clean(lp.Name)
    local myCleanDisplayName = clean(lp.DisplayName)
    
    for i = 1, 8 do
        local plotName = "Plot_" .. i
        local plotFolder = workspace.Plots:FindFirstChild(plotName)
        if plotFolder then
            local nameplate = plotFolder:FindFirstChild("Plot_Models") and plotFolder.Plot_Models:FindFirstChild("BaseModel") and plotFolder.Plot_Models.BaseModel:FindFirstChild("BillBoardC")
            if nameplate then
                local cleanLabel = clean(nameplate.Nameplate.SurfaceGui.NameOf.Text)
                if string.find(cleanLabel, myCleanName) or string.find(cleanLabel, myCleanDisplayName) then
                    myPlot = plotFolder
                    break
                end
            end
        end
    end
end

assignMyPlot()
if not myPlot then myPlot = workspace.Plots.Plot_1 end

local baseModel = myPlot.Plot_Models.BaseModel
local conveyor = baseModel.PackConveyor
local spawnClick = baseModel.ButtonModel.PacketClick.ClickDetector

local pickupCFrame = baseModel.BoxStand.CFrame * CFrame.new(0, 3, 0)
local sellCFrame = baseModel.SellButton.SellP.CFrame * CFrame.new(0, 2, 0)
local boxPrompt = baseModel.BoxStand:FindFirstChild("ProximityPrompt")

local caseRarirites = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local mutationList = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}
local selectedChestRarities = {} 

local function isMatch(selectedTable, value)
    if not selectedTable or next(selectedTable) == nil then return false end
    for k, v in pairs(selectedTable) do
        local key = tostring(type(k) == "string" and k or v)
        if string.find(string.lower(value), string.lower(key)) then return true end
    end
    return false
end

local function getKnifeValue(tool)
    local billboard = tool:FindFirstChild("BillboardGui", true)
    local givingAmount = billboard and billboard:FindFirstChild("GivingAmount")
    
    if givingAmount and givingAmount:IsA("TextLabel") then
        local cleanString = givingAmount.Text:gsub("[$,/knife%s]", "")
        return tonumber(cleanString) or 0
    end
    return 0
end

local function findCurrentBest()
    local backpack = lp:WaitForChild("Backpack")
    local best = nil
    local high = -1
    
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") and not item:FindFirstChildOfClass("Model") then
            local val = getKnifeValue(item)
            if val > high then
                high = val
                best = item
            end
        end
    end
    return best
end

local function findMatchingChest()
    local backpack = lp:WaitForChild("Backpack")
    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            local caseModel = item:FindFirstChildOfClass("Model")
            if caseModel then
                local rarity = caseModel.Name
                if isMatch(selectedChestRarities, rarity) then
                    return item
                end
            end
        end
    end
    return nil
end

local function fireFarPrompt(prompt)
    pcall(function()
        if prompt and prompt:IsA("ProximityPrompt") then
            local oldDist = prompt.MaxActivationDistance
            local oldLos = prompt.RequiresLineOfSight
            prompt.MaxActivationDistance = 9e9
            prompt.RequiresLineOfSight = false
            fireproximityprompt(prompt)
            task.spawn(function()
                task.wait(0.05)
                if prompt and prompt.Parent then
                    prompt.MaxActivationDistance = oldDist
                    prompt.RequiresLineOfSight = oldLos
                end
            end)
        end
    end)
end

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()

local Window = Library:CreateWindow({
    Title = "MKF🔪 | Krynt Hub",
    Center = true,
    AutoShow = true,
    TabWidth = 160,
    Footer = "MKF Premium 👑"
})

local Options = Library.Options
local Toggles = Library.Toggles
local MainTab = Window:AddTab("MKF Premium", "box")

local FarmBox = MainTab:AddLeftGroupbox("Economy & Farming")
local ChestBox = MainTab:AddRightGroupbox("Chest Management")
local PlotBox = MainTab:AddLeftGroupbox("Plot Control")

FarmBox:AddDropdown("TargetCases", {
    Text = "Rarities to Auto Buy",
    Default = 1,
    Values = caseRarirites,
    Multi = true,
})

FarmBox:AddDropdown("TargetMutations", {
    Text = "Target Mutations (Optional)",
    Values = mutationList,
    Multi = true,
})

local isBuying = false
FarmBox:AddToggle("AutoRollSnipe", { Text = "Auto Roll & Buy Targets", Default = false })

if conveyor:FindFirstChild("SpawnedCase") then
    conveyor.SpawnedCase.ChildAdded:Connect(function(child)
        if not Toggles.AutoRollSnipe.Value then return end
        
        task.spawn(function()
            task.wait(0.05)
            local rLabel = child:FindFirstChild("Rarity", true)
            local mLabel = child:FindFirstChild("EventRarity", true)
            
            if rLabel then
                local timeout = 0
                while (rLabel.Text == "" or rLabel.Text == "Label") and timeout < 50 do
                    task.wait(0.05)
                    timeout = timeout + 1
                end
                
                local curRarity = rLabel.Text
                local curMutation = "Normal"
                
                if mLabel and mLabel.Text ~= "" and mLabel.Text ~= "Label" then
                    curMutation = mLabel.Text
                end
                
                local targets = Options.TargetCases.Value
                local mutations = Options.TargetMutations.Value
                
                local rarityMatch = (type(targets) == "table" and targets[curRarity])
                local mutationMatch = true
                
                if type(mutations) == "table" and next(mutations) ~= nil then
                    mutationMatch = mutations[curMutation]
                end
                
                if rarityMatch and mutationMatch then
                    isBuying = true 
                    pcall(function() BuyCaseRemote:FireServer() end)
                    task.wait(0.6)
                    isBuying = false 
                end
            end
        end)
    end)
end

Toggles.AutoRollSnipe:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoRollSnipe.Value do
            pcall(function() 
                if spawnClick and not isBuying then 
                    fireclickdetector(spawnClick) 
                end
            end)
            task.wait(0.05)
        end
    end)
end)

FarmBox:AddToggle("AutoSell", { Text = "Master Sell Loop (Box Carry)", Default = false })
Toggles.AutoSell:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoSell.Value do
            pcall(function()
                local char = lp.Character or lp.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                
                local returnPos = root.CFrame
                root.CFrame = pickupCFrame
                task.wait(0.4)
                
                local pTimeout = 0
                while Toggles.AutoSell.Value and not char:FindFirstChild("OpenBox") and pTimeout < 40 do
                    if boxPrompt then fireFarPrompt(boxPrompt) end
                    task.wait(0.1)
                    pTimeout = pTimeout + 1
                end
                
                if char:FindFirstChild("OpenBox") then
                    root.CFrame = sellCFrame
                    task.wait(0.5)
                    
                    local sTimeout = 0
                    while char:FindFirstChild("OpenBox") and sTimeout < 50 do
                        task.wait(0.1)
                        sTimeout = sTimeout + 1
                    end
                end
                
                root.CFrame = returnPos
            end)
            task.wait(1)
        end
    end)
end)

FarmBox:AddToggle("AutoSpin", { Text = "Auto Spam Spins", Default = false })
Toggles.AutoSpin:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoSpin.Value do
            pcall(function()
                local spinCount = tonumber(string.match(spinAmountLabel.Text, "%d+")) or 0
                if spinCount > 0 then
                    spinRemote:FireServer()
                end
            end)
            task.wait(0.1)
        end
    end)
end)

FarmBox:AddToggle("AntiAFK", { Text = "Anti AFK", Default = false })
lp.Idled:Connect(function()
    if Toggles.AntiAFK.Value then
        VirtualUser:Button2Down(Vector2.zero, workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.zero, workspace.CurrentCamera.CFrame)
    end
end)

ChestBox:AddDropdown("ChestRarities", {
    Text = "Chests to Place",
    Default = 1,
    Values = caseRarirites,
    Multi = true,
})
Options.ChestRarities:OnChanged(function()
    selectedChestRarities = Options.ChestRarities.Value
end)

ChestBox:AddToggle("AutoPlaceChest", { Text = "Auto Place Selected Chests", Default = false })
Toggles.AutoPlaceChest:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoPlaceChest.Value do
            pcall(function()
                local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
                local char = lp.Character or lp.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                local hum = char:WaitForChild("Humanoid")
                local oldPos = root.CFrame

                for _, slot in pairs(slotsFolder:GetChildren()) do
                    if not Toggles.AutoPlaceChest.Value then break end
                    
                    local standPart = slot:FindFirstChild("StandPart")
                    local prompt = standPart and standPart:FindFirstChild("ProximityPrompt")

                    if prompt and prompt.ActionText == "Place" then
                        local chestToUse = findMatchingChest()
                        
                        if chestToUse then
                            hum:EquipTool(chestToUse)
                            task.wait(0.1)

                            root.CFrame = standPart.CFrame * CFrame.new(0, 3, 0)
                            task.wait(0.15)
                            
                            local attempts = 0
                            while prompt.ActionText == "Place" and attempts < 5 do
                                fireproximityprompt(prompt)
                                task.wait(0.25)
                                attempts = attempts + 1
                            end
                        else
                            break 
                        end
                    end
                end
                root.CFrame = oldPos
            end)
            task.wait(0.5)
        end
    end)
end)

ChestBox:AddToggle("AutoOpen", { Text = "Auto Open Chests (Physical)", Default = false })
Toggles.AutoOpen:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoOpen.Value do
            pcall(function()
                local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
                local char = lp.Character or lp.CharacterAdded:Wait()
                local root = char:WaitForChild("HumanoidRootPart")
                local oldPos = root.CFrame

                if slotsFolder then
                    for i = 1, 10 do
                        if not Toggles.AutoOpen.Value then break end
                        
                        local sObj = slotsFolder:FindFirstChild("Slot" .. i)
                        if sObj then
                            local standPart = sObj:FindFirstChild("StandPart")
                            local openPrompt = standPart and standPart:FindFirstChild("ProximityPrompt")
                            
                            if openPrompt and (openPrompt.ActionText == "Open" or openPrompt.ActionText == "Skip") then
                                root.CFrame = standPart.CFrame * CFrame.new(0, 3, 0)
                                task.wait(0.15)
                                fireproximityprompt(openPrompt)
                            end
                        end
                    end
                end
                root.CFrame = oldPos
            end)
            task.wait(0.5)
        end
    end)
end)

PlotBox:AddToggle("AutoDropKnives", { Text = "Auto Drop Knives Fast", Default = false })
Toggles.AutoDropKnives:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoDropKnives.Value do
            pcall(function()
                local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
                if slotsFolder then
                    for i = 1, 10 do
                        local sName = "Slot" .. i
                        local sObj = slotsFolder:FindFirstChild(sName)
                        
                        if sObj then
                            local standModel = sObj:FindFirstChild("StandModel")
                            if standModel then
                                local hasPacket = false
                                for _, child in ipairs(standModel:GetChildren()) do
                                    if child:IsA("Model") then
                                        hasPacket = true
                                        break
                                    end
                                end
                                
                                if hasPacket then
                                    SlotDropRemote:FireServer(sName)
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(1) 
        end
    end)
end)

PlotBox:AddButton("Equip Best Knives", function()
    local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local oldPos = root.CFrame

    for _, slot in pairs(slotsFolder:GetChildren()) do
        local standPart = slot:FindFirstChild("StandPart")
        local prompt = standPart and standPart:FindFirstChild("ProximityPrompt")

        if prompt and prompt.ActionText == "Place" then
            local hasCaseModel = false
            if slot:FindFirstChild("StandModel") then
                for _, child in pairs(slot.StandModel:GetChildren()) do
                    if string.find(string.lower(child.Name), "case") or string.find(string.lower(child.Name), "chest") then
                        hasCaseModel = true
                        break
                    end
                end
            end

            if not hasCaseModel then
                local knifeToUse = findCurrentBest() 
                
                if knifeToUse then
                    hum:EquipTool(knifeToUse)
                    task.wait(0.1)

                    root.CFrame = standPart.CFrame * CFrame.new(0, 3, 0)
                    task.wait(0.12) 
                    
                    local attempts = 0
                    while prompt.ActionText ~= "Remove" and prompt.ActionText ~= "Open" and attempts < 5 do
                        fireproximityprompt(prompt)
                        task.wait(0.2)
                        attempts = attempts + 1
                    end
                else
                    break 
                end
            end
        end
    end

    root.CFrame = oldPos
end)

PlotBox:AddButton("Remove All Knives", function()
    local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
    if not slotsFolder then return end

    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local oldPos = root.CFrame

    for _, slot in pairs(slotsFolder:GetChildren()) do
        local standPart = slot:FindFirstChild("StandPart")
        local prompt = standPart and standPart:FindFirstChild("ProximityPrompt")
        
        if prompt and prompt.ActionText == "Remove" then
            root.CFrame = standPart.CFrame * CFrame.new(0, 3, 0)
            task.wait(0.1) 
            local attempts = 0

            while prompt.ActionText == "Remove" and attempts < 10 do
                fireproximityprompt(prompt)
                task.wait(0.15)
                attempts = attempts + 1
            end
        end
    end

    root.CFrame = oldPos 
end)

PlotBox:AddToggle("AutoUpgradeAll", { Text = "Upgrades All Knives", Default = false })
Toggles.AutoUpgradeAll:OnChanged(function()
    task.spawn(function()
        while Toggles.AutoUpgradeAll.Value do
            pcall(function()
                local slotsFolder = myPlot.Plot_Models.BaseModel:FindFirstChild("Slots")
                if slotsFolder then
                    for _, slot in pairs(slotsFolder:GetChildren()) do
                        if not Toggles.AutoUpgradeAll.Value then break end

                        local upgradePart = slot:FindFirstChild("UpgradePart")
                        if upgradePart then
                            local priceLabel = upgradePart:FindFirstChild("Price", true)
                            
                            if priceLabel and priceLabel.Text ~= "Max" then
                                local cd = upgradePart:FindFirstChild("ClickDetector")
                                if cd then
                                    fireclickdetector(cd)
                                end
                            end
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)
