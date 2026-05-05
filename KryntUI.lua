-- ==========================================
-- KRYNT HUB: UI VISUAL TEST (NO GAMEPLAY LOGIC)
-- ==========================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local CASES = {"Common", "Rare", "Epic", "Elite", "Legendary", "Mythic", "Secret", "Limited", "Exclusive", "Timeless", "Godly", "Soul", "Fruit", "Ninja", "Historical", "Shadow", "Frost", "Demon", "Arsenal"}
local MUTATIONS = {"Rusty", "Normal", "Golden", "Space", "Blood", "Dark", "Candy", "Rainbow", "Emerald", "Blue Gem"}

-- 1. BUILD THE WINDOW
local Window = Fluent:CreateWindow({
    Title = "Krynt Hub",
    SubTitle = "Visual UI Test",
    TabWidth = 160,
    Size = UDim2.fromOffset(480, 380),
    Acrylic = true, -- Blur effect (looks like Windows 11)
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- 2. CREATE TABS
local Tabs = {
    Sniper = Window:CreateTab({ Title = "Auto Sniper", Icon = "crosshair" }),
    Settings = Window:CreateTab({ Title = "Settings", Icon = "settings" })
}

-- 3. BUILD THE "SNIPER" TAB

-- Status Display
local StatusParagraph = Tabs.Sniper:AddParagraph({
    Title = "Status",
    Content = "Waiting for input..."
})

Tabs.Sniper:AddSection("Target Configuration")

-- Multi-Dropdown for Cases
local CaseDropdown = Tabs.Sniper:AddDropdown("CaseSelect", {
    Title = "Select Cases to Buy",
    Values = CASES,
    Multi = true,
    Default = {},
})
CaseDropdown:OnChanged(function(Value)
    local selectedNames = {}
    for name, isSelected in pairs(Value) do
        if isSelected then table.insert(selectedNames, name) end
    end
    StatusParagraph:SetDesc("Selected Cases: " .. table.concat(selectedNames, ", "))
end)

-- Multi-Dropdown for Mutations
local MutationDropdown = Tabs.Sniper:AddDropdown("MutationSelect", {
    Title = "Select Target Mutations",
    Values = MUTATIONS,
    Multi = true,
    Default = {},
})
MutationDropdown:OnChanged(function(Value)
    local selectedNames = {}
    for name, isSelected in pairs(Value) do
        if isSelected then table.insert(selectedNames, name) end
    end
    -- Just for the visual test, update the status when you click things
    print("Mutations updated visually.")
end)

Tabs.Sniper:AddSection("Automation Controls")

-- Mock "Set Target" Button
Tabs.Sniper:AddButton({
    Title = "1. Set Roll Target",
    Description = "Saves the nearest button for Ghost Rolling",
    Callback = function()
        StatusParagraph:SetDesc("Status: Target Saved! (Visual test only)")
        Fluent:Notify({ Title = "Success", Content = "Roll Target Saved.", Duration = 3 })
    end
})

-- Mock Auto Roll Toggle
local RollToggle = Tabs.Sniper:AddToggle("RollToggle", {Title = "Auto Roll", Default = false })
RollToggle:OnChanged(function(Value)
    if Value then
        StatusParagraph:SetDesc("Status: Auto-Rolling started! (Visual test only)")
    else
        StatusParagraph:SetDesc("Status: Auto-Rolling stopped.")
    end
end)

-- Mock Auto Buy Toggle
local BuyToggle = Tabs.Sniper:AddToggle("BuyToggle", {Title = "Auto Buy Cases", Default = false })
BuyToggle:OnChanged(function(Value)
    if Value then
        StatusParagraph:SetDesc("Status: Auto-Buying started! (Visual test only)")
    else
        StatusParagraph:SetDesc("Status: Auto-Buying stopped.")
    end
end)

-- 4. SETTINGS TAB
Tabs.Settings:AddButton({
    Title = "Destroy UI",
    Description = "Closes the menu and unloads the script.",
    Callback = function()
        Window:Destroy()
    end
})

-- Select the first tab automatically when loaded
Window:SelectTab(1)

Fluent:Notify({
    Title = "UI Loaded",
    Content = "This is a visual test. No cases will be bought.",
    Duration = 5
})
