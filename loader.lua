-- [[ KRYNT HUB DEBUG LOADER ]]
local k_url = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/key.txt"
local m_url = "https://raw.githubusercontent.com/Krynttt/Krynt-Hub-Scripts/main/main.lua"

print("--- Krynt Hub Debug ---")

local s1, key = pcall(function() return game:HttpGet(k_url) end)
local s2, main = pcall(function() return game:HttpGet(m_url) end)

if not s1 then 
    warn("Failed to find key.txt - check link!") 
elseif not s2 then 
    warn("Failed to find main.lua - check link!")
else
    print("Files found! Loading...")
    local func, err = loadstring(main)
    if func then
        func()
    else
        warn("Error in main.lua code: " .. tostring(err))
    end
end
