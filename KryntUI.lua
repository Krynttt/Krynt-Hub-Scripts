-- Load Fluent Library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

-- The table we send to the Logic file
local HubData = {
    SelectedCases = {},
    SelectedMutations = {},
    AutoRoll = false,
    AutoBuy = false,
    SetRollTarget = nil, -- We will hook a function to this later
    UpdateStatus = nil   -- We will hook a function to this later
}

-- 1. BUILD THE WINDOW
local Window = Fluent:CreateWindow({
    Title = "Krynt Hub",
    SubTitle = "Fluent Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 380),
    Acrylic = true, -- The beautiful blur effect
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Press Right Ctrl to hide the menu!
})

-- 2. CREATE TABS
local Tabs = {
    Sniper = Window:CreateTab({ Title = "Auto Sniper", Icon = "crosshair" })
}

-- 3. CREATE UI ELEMENTS

-- Status Label
local StatusParagraph = Tabs.Sniper:AddParagraph({
    Title = "Status",
    Content = "Idle"
})
HubData.UpdateStatus = function(text)
    StatusParagraph:SetDesc(text)
end

local section1 = Tabs.Sniper:AddSection("Target Configuration")

-- Multi-Dropdown for Cases
local CaseDropdown = Tabs.Sniper:AddDropdown("CaseSelect", {
    Title = "Select Cases",
    Values = CASES,
    Multi = true,
    Default = {},
})
CaseDropdown:OnChanged(function(Value)
    HubData.SelectedCases = Value -- Updates automatically! Example: {["Arsenal"] = true}
end)

-- Multi-Dropdown for Mutations
local MutationDropdown = Tabs.Sniper:AddDropdown("MutationSelect", {
    Title = "Select Target Mutations",
    Values = MUTATIONS,
    Multi = true,
    Default = {},
})
MutationDropdown:OnChanged(function(Value)
    HubData.SelectedMutations = Value
end)

local section2 = Tabs.Sniper:AddSection("Automation")

-- Set Roll Button
Tabs.Sniper:AddButton({
    Title = "1. Set Roll Target (Stand Near Button)",
    Description = "Saves the nearest button for Ghost Rolling",
    Callback = function()
        if HubData.SetRollTarget then
            HubData.SetRollTarget() -- Calls the logic from the other file
        end
    end
})

-- Auto Roll Toggle
local RollToggle = Tabs.Sniper:AddToggle("RollToggle", {Title = "Auto Roll", Default = false })
RollToggle:OnChanged(function(Value)
    HubData.AutoRoll = Value
end)

-- Auto Buy Toggle
local BuyToggle = Tabs.Sniper:AddToggle("BuyToggle", {Title = "Auto Buy Cases", Default = false })
BuyToggle:OnChanged(function(Value)
    HubData.AutoBuy = Value
end)

-- Notify the user it loaded
Fluent:Notify({
    Title = "Krynt Hub Loaded",
    Content = "The UI has been successfully loaded.",
    Duration = 5
})

return HubData
