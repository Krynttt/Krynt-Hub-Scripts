
```lua
if not game.Loaded then game.Loaded:Wait() end
task.wait(3)
local username = game:GetService("Players").LocalPlayer.Name
local giver = ""
local recivername = ""
    -- Made by kugio
local function getGUIDs(player)
    local plr = game:GetService("Players"):FindFirstChild(player)
    if not plr then return {} end
    
    local guids = {}
    for _, v in pairs(plr.Backpack:GetChildren()) do
        local guid = v:GetAttribute("GUID")
        if guid then guids[guid] = true end
    end
    return guids
end
    -- Made by kugio

local remote = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_trade_i")
    -- Made by kugio

if username == giver then
    local args = {
        game:GetService("Players")[recivername].UserId
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("ref_trade_r"):InvokeServer(unpack(args))
    task.wait()
    
   
    local giverGUIDs = getGUIDs(giver)
    local receiverGUIDs = getGUIDs(recivername)
    
    for guid, _ in pairs(giverGUIDs) do
        if not receiverGUIDs[guid] then
            remote:FireServer("AddItem", guid)
            receiverGUIDs = getGUIDs(recivername)
        end
    end
task.wait(11)
    -- Made by kugio

local args = {
                "Confirm"
            }
game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_trade_i"):FireServer(unpack(args))
task.wait(11)
local args = {
                "Confirm"
            }
game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_trade_i"):FireServer(unpack(args))
task.wait(0.15)
game:GetService("Players").LocalPlayer:Kick("Made by kugio, telegram @kugio")
task.wait(5)
game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
else
while task.wait() do
if game:GetService("Players"):FindFirstChild(giver) then
    -- Made by kugio

    local args = {
        game:GetService("Players")[giver].UserId
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("ref_trade_r"):InvokeServer(unpack(args))
    local args = {
    "Confirm"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("rev_trade_i"):FireServer(unpack(args)) 
        end
    end
end
    -- Made by kugio```
