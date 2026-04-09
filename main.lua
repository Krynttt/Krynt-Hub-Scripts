local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local RS = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local TeleportService = game:GetService("TeleportService")
local LuckyBlockConfig = require(game:GetService("ReplicatedStorage").Game.LuckyBlockGeneratorConfig)
local LP=game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local Portals = require(game:GetService("ReplicatedStorage").Game:WaitForChild("Portals"))
local IslandParts = game:GetService("Workspace").Game:WaitForChild("IslandParts")
local Workspace = game:GetService("Workspace")
local Worlds = require(game:GetService("ReplicatedStorage").Game:WaitForChild("Worlds"))
local List = game:GetService("Players").LocalPlayer.PlayerGui.RightHud.Main.RightUI.Quests.List
local core = game:GetService("CoreGui")
local cam = workspace.CurrentCamera
local player = game.Players.LocalPlayer
local placeId = game.PlaceId
local originalGravity = workspace.Gravity
local worldChests = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("WorldChests")
local partFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("IslandParts")
local terrain = workspace:FindFirstChildOfClass("Terrain")
local placedFolder = workspace:FindFirstChild("PlacedLuckyBlocks")
local pFolder=workspace:FindFirstChild("PlacedLuckyBlocks")
local PetStats = require(ReplicatedStorage.Game.PetStats)
local Replication = require(ReplicatedStorage.Game.Replication)
local Network=require(RS.Modules.Network)
local Config=require(RS.Game.LuckyBlockGeneratorConfig)
local Rep=require(RS.Game.Replication)
local Rebirths = require(ReplicatedStorage.Game.Rebirths)
local DoubleJumps = require(ReplicatedStorage.Game.DoubleJumps)
local GemShop = require(ReplicatedStorage.Game.GemShop)
local Eggs = require(ReplicatedStorage.Game.Eggs)
local Boosts = require(ReplicatedStorage.Game.Boosts)
local WorldsModule = require(ReplicatedStorage.Game.Worlds)
local PortalsModule = require(ReplicatedStorage.Game.Portals)
local Signal = require(ReplicatedStorage.Modules.Signal)
local EnchantData = require(ReplicatedStorage.Game.EnchantData)
local Quests = require(ReplicatedStorage.Game.Quests)
local TravellingMerchants = require(ReplicatedStorage.Game.TravellingMerchants)
local Items = require(ReplicatedStorage.Game.Items)
local PetTreatsModule = require(ReplicatedStorage.Game.PetTreatsModule)
local ItemDefinitions = require(ReplicatedStorage.Game.Items)
local PetStatsRarities = require(ReplicatedStorage.Game.PetStats.Rarities)

local State = {}

-- State Variables
State.maxRetries = nil
State.retryDelay = nil
State.loadSuccess = nil
State.errorMsg = nil
State.player = nil
State.userid = nil
State.response = nil
State.WEBHOOK_URL = nil
State.username = nil
State.LocalPlayer = nil
State.absNum = nil
State.formatted = nil
State.petTier = nil
State.petLevel = nil
State.globalBestMulti = nil
State.petPercentage = nil
State.baseStat = nil
State.Window = nil
State.Tabs = nil
State.BuildUI = nil
State.antiAfkEnabled = nil
State.antiAfkThread = nil
State.ME = nil
State.CanBeEnabled = nil
State.Booster = nil
State.sP = nil
State.t = nil
State.S = nil
State.O = nil
State.clones = nil
State.cap = nil
State.ok = nil
State.res = nil
State.pg = nil
State.rh = nil
State.main = nil
State.rui = nil
State.badges = nil
State.m = nil
State.Overlay = nil
State.uiParent = nil
State.rowLayout = nil
State.frames = nil
State.last = nil
State.now = nil
State.dt = nil
State.statsUI = nil
State.leaderstats = nil
State.rarest = nil
State.petCount = nil
State.totalPetPower = nil
State.rebirthMulti = nil
State.lbRank = nil
State.secretLuck = nil
State.goldLuck = nil
State.rainbowLuck = nil
State.hatchSpeed = nil
State.boostsMulti = nil
State.walkSpeedValue = nil
State.jumpPowerValue = nil
State.walkSpeedEnabled = nil
State.jumpPowerEnabled = nil
State.originalWalkSpeed = nil
State.originalJumpPower = nil
State.noclipEnabled = nil
State.noclipConnection = nil
State.humanoid = nil
State.infiniteJumpEnabled = nil
State.flyEnabled = nil
State.flyConnection = nil
State.root = nil
State.velocity = nil
State.move = nil
State.flyVel = nil
State.mouse = nil
State.rayParams = nil
State.maxDistance = nil
State.currentPos = nil
State.remainingDistance = nil
State.tool = nil
State.handle = nil
State.flash = nil
State.originalSize = nil
State.originalDescendantData = nil
State.duration = nil
State.steps = nil
State.alpha = nil
State.scale = nil
State.targetPos = nil
State.sound = nil
State.PublicServerSection = nil
State.publicDelayInput = nil
State.AutoRejoinPublicToggle = nil
State.PrivateServerSection = nil
State.privateServerIdInput = nil
State.privateDelayInput = nil
State.match = nil
State.AutoRejoinPrivateToggle = nil
State.luckyBlockNames = nil
State.LuckyBlocksSection = nil
State.placedBlocksParagraph = nil
State.selectedAutoPlaceBlocks = nil
State.autoPlaceEnabled = nil
State.autoPlaceThread = nil
State.autoClaimEnabled = nil
State.autoClaimThread = nil
State.isClaimingBlock = nil
State.blockInfo = nil
State.AutoPlaceDropdown = nil
State.need = nil
State.inv = nil
State.cMap = nil
State.avail = nil
State.high = nil
State.cands = nil
State.pos = nil
State.blockId = nil
State.blockPosition = nil
State.originalStates = nil
State.popupModulePath = nil
State.PopupsModule = nil
State.soundsToMute = nil
State.lastClicks = nil
State.sameCountTimer = nil
State.RebirthSection = nil
State.selectedRebirthIndex = nil
State.rebirthDropdown = nil
State.rebirthOptions = nil
State.isMaxUnlockedSelected = nil
State.useEventClickLogic = nil
State.currentZone = nil
State.autoRebirthRunning = nil
State.autoRebirthThread = nil
State.dropdownUpdateThread = nil
State.zoneUpdateThread = nil
State.suffixes = nil
State.str = nil
State.options = nil
State.maxOptions = nil
State.currentRebirths = nil
State.easterRebirths = nil
State.clicks = nil
State.bestIndex = nil
State.bestAmount = nil
State.maxUnlocked = nil
State.dropdownValues = nil
State.rebirthIndex = nil
State.rebirthDelayInput = nil
State.AutoRebirth = nil
State.UpgradesSection = nil
State.selectedUpgrades = nil
State.upgradeThread = nil
State.upgradesDropdown = nil
State.allSelected = nil
State.lastPurchaseIndex = nil
State.gems = nil
State.affordable = nil
State.shopId = nil
State.shopData = nil
State.cur = nil
State.maxLevel = nil
State.cost = nil
State.EggSection = nil
State.EventStateController = nil
State.selectedEgg = nil
State.selectedHatchAmount = nil
State.manualHatchAmountInput = nil
State.autoHatchEnabled = nil
State.autoHatchThread = nil
State.rejoinBreakEnabled = nil
State.rejoinBreakThread = nil
State.useNormalSpeed = nil
State.calculatedSpeed = nil
State.normalSpeedToggle = nil
State.maxHatchCheckThread = nil
State.hatchOriginalCFrame = nil
State.isHatchingAway = nil
State.eggMap = nil
State.eggDropdown = nil
State.baseSpeed = nil
State.animationTime = nil
State.actualHatchInterval = nil
State.extra = nil
State.hasOctoBoost = nil
State.gamepasses = nil
State.eggList = nil
State.sortedEggs = nil
State.eggDropdownValues = nil
State.realName = nil
State.hatchAmountDropdown = nil
State.hatchSpeedSlider = nil
State.AutoHatchToggle = nil
State.RejoinBreakToggle = nil
State.lastEggCount = nil
State.AutoDeleteSection = nil
State.selectedDeleteEgg = nil
State.selectedDeletePets = nil
State.deleteDropdown = nil
State.petList = nil
State.sortedDisplayList = nil
State.deleteEggDropdown = nil
State.ApplyAutoDeleteButton = nil
State.deleteData = nil
State.path = nil
State.originalGravity = nil
State.err = nil
State.worldMaps = nil
State.worldProgression = nil
State.targetWorldId = nil
State.nextWorldName = nil
State.targetPath = nil
State.targetUnlockQueue = nil
State.CraftingSection = nil
State.Loop = nil
State.machineLocations = nil
State.bestPart = nil
State.bestDist = nil
State.worldRankMap = nil
State.allMyPlaces = nil
State.petNames = nil
State.nameSet = nil
State.ids = nil
State.selectedGoldMachinePets = nil
State.selectedChance = nil
State.petsDropdown = nil
State.petCountParagraph = nil
State.statusText = nil
State.foundAny = nil
State.chanceDropdown = nil
State.RefreshPetsButton = nil
State.AutoCraftToggle = nil
State.petsNeeded = nil
State.canCraftAny = nil
State.bestZone = nil
State.goldenMachine = nil
State.searchStart = nil
State.allIds = nil
State.RainbowSection = nil
State.selectedRainbowPets = nil
State.selectedRainbowTime = nil
State.rainbowPetsDropdown = nil
State.rainbowStatusParagraph = nil
State.autoRainbowEnabled = nil
State.autoRainbowThread = nil
State.crafting = nil
State.hasSelectedPets = nil
State.rainbowTimeDropdown = nil
State.RefreshRainbowButton = nil
State.AutoRainbowToggle = nil
State.craftingData = nil
State.currentCraftingCount = nil
State.availableSlots = nil
State.canCraftMore = nil
State.rainbowMachine = nil
State.usedIds = nil
State.slotsToFill = nil
State.cleanIds = nil
State.OriginalFire = nil
State.BlockUntil = nil
State.Args = nil
State.Title = nil
State.Content = nil
State.targetZonePortalData = nil
State.targetWorldName = nil
State.TeleportSection = nil
State.TeleportOnJoinSection = nil
State.worldArray = nil
State.worldIndex = nil
State.allDestinations = nil
State.selectedJoinDest = nil
State.destNames = nil
State.targetDest = nil
State.unlockThread = nil
State.startTime = nil
State.EnchantSection = nil
State.selectedEnchants = nil
State.selectedEnchantPets = nil
State.enchantPetDropdown = nil
State.enchantStatusParagraph = nil
State.autoEnchantEnabled = nil
State.autoEnchantThread = nil
State.periodicUpdateThread = nil
State.petDropdownMap = nil
State.liveEnchantData = nil
State.enchantList = nil
State.nameOrder = nil
State.tierOrder = nil
State.nameA = nil
State.tierA = nil
State.nameB = nil
State.tierB = nil
State.oA = nil
State.oB = nil
State.base = nil
State.petsToSort = nil
State.formattedList = nil
State.finalDropdownString = nil
State.crystalCount = nil
State.groupedPets = nil
State.hasSelection = nil
State.strippedString = nil
State.AutoEnchantToggle = nil
State.original_InvokeServer = nil
State.targetPetId = nil
State.targetName = nil
State.lastEnchantResult = nil
State.timeout = nil
State.EnchantModule = nil
State.UnlockZonesSection = nil
State.worldNameToId = nil
State.worldListForButtons = nil
State.zonesToUnlock = nil
State.WorldChestsSection = nil
State.autoClaimWorldChestsEnabled = nil
State.autoClaimWorldChestsThread = nil
State.autoClaimWorldChestsOriginalGravity = nil
State.ClaimWorldChestsToggle = nil
State.startCFrame = nil
State.vp = nil
State.onScreen = nil
State.chests = nil
State.seen = nil
State.targetPart = nil
State.myHrp = nil
State.currentChar = nil
State.returnChar = nil
State.waited = nil
State.autoChestMagnetEnabled = nil
State.autoChestMagnetThread = nil
State.ChestMagnetToggle = nil
State.AutoSpinSection = nil
State.autoSpinEnabled = nil
State.autoSpinThread = nil
State.autoClaimRankRewardEnabled = nil
State.autoClaimRankRewardThread = nil
State.ClaimRankRewardToggle = nil
State.codes = nil
State.QuestsSection = nil
State.autoClaimQuestsEnabled = nil
State.autoClaimQuestsThread = nil
State.ClaimQuestsToggle = nil
State.MinigameSection = nil
State.autoMinigameEnabled = nil
State.autoMinigameThread = nil
State.MiscSection = nil
State.allMerchantItems = nil
State.itemToMerchantMap = nil
State.selectedMerchantItems = nil
State.autoBuyEnabled = nil
State.autoBuyThread = nil
State.MerchantItemsDropdown = nil
State.MerchantModule = nil
State.stock = nil
State.playerMoney = nil
State.canAfford = nil
State.AutoBuyPotionsSection = nil
State.selectedPotionAmounts = nil
State.autoBuyPotionsEnabled = nil
State.autoBuyPotionsThread = nil
State.PotionAmountsDropdown = nil
State.AutoBuyPotionsToggle = nil
State.AutoUseBoostsSection = nil
State.selectedBoosts = nil
State.autoUseBoostsEnabled = nil
State.autoUseBoostsThread = nil
State.boostsDropdown = nil
State.boostList = nil
State.AutoUseBoostsToggle = nil
State.isActive = nil
State.pets = nil
State.EquipBestSection = nil
State.petRarity = nil
State.currentPets = nil
State.toUnequip = nil
State.toEquip = nil
State.autoEquipBestEnabled = nil
State.autoEquipCalculatedBestEnabled = nil
State.autoEquipLowestLevelEnabled = nil
State.autoEquipAndLevelEnabled = nil
State.autoEquipBestThread = nil
State.autoEquipCalculatedBestThread = nil
State.autoEquipLowestLevelThread = nil
State.autoEquipAndLevelThread = nil
State.selectedPetsToLevel = nil
State.levelToMaxDropdown = nil
State.finalVariations = nil
State.petNameSet = nil
State.tiers = nil
State.mutations = nil
State.moduleSuccess = nil
State.mutationsModule = nil
State.MAX = nil
State.bestIds = nil
State.leveling = nil
State.maxed = nil
State.petsToLevel = nil
State.potA = nil
State.potB = nil
State.currentTeamSize = nil
State.AutoBuyTreatsSection = nil
State.selectedTreatsToBuy = nil
State.autoBuyTreatsEnabled = nil
State.autoBuyTreatsThread = nil
State.treatDropdownMap = nil
State.treatList = nil
State.treatsToSort = nil
State.myGems = nil
State.myRebirths = nil
State.myPaidTokens = nil
State.myPurchasedStock = nil
State.baseStock = nil
State.alreadyPurchased = nil
State.currencyType = nil
State.LevelPetsSection = nil
State.selectedTreats = nil
State.useTreatsThread = nil
State.xpItemMap = nil
State.xpItems = nil
State.allXpItems = nil
State.xpItemDisplayNames = nil
State.bestTreatData = nil
State.MAX_EQUIP = nil
State.equippedCount = nil
State.isTeamFullyMaxed = nil
State.potentialPets = nil
State.bestCandidate = nil
State.targetPetData = nil
State.currentLevel = nil
State.currentXP = nil
State.totalXpNeeded = nil
State.numTreatsNeeded = nil
State.numTreatsOwned = nil
State.treatsToUse = nil
State.DeletePetsSection = nil
State.multipliers = nil
State.deleteClicksInput = nil
State.deleteWeakestInput = nil
State.DeleteWeakestButton = nil
State.selectedSpecificPets = nil
State.autoDeleteSpecificEnabled = nil
State.autoDeleteSpecificThread = nil
State.specificPetsDropdown = nil
State.parts = nil
State.petNameList = nil
State.petsToDelete = nil
State.TEAMS_FILE_PATH = nil
State.petTeams = nil
State.fileContent = nil
State.jsonString = nil
State.createSection = nil
State.manageSection = nil
State.selectedTeamPets = nil
State.teamsPetDropdown = nil
State.teamsDropdown = nil
State.teamsPetDropdownMap = nil
State.teamNames = nil
State.teamNameInput = nil
State.teamName = nil
State.petIds = nil
State.isUpdating = nil
State.message = nil
State.targetIdSet = nil
State.loadstringText = nil
State.DISCORD_USER_ID = nil
State.selectedRarities = nil
State.webhookEnabled = nil
State.webhookThread = nil
State.statsWebhookEnabled = nil
State.statsWebhookThread = nil
State.pingUserForStats = nil
State.statsWebhookDelay = nil
State.orderedRarities = nil
State.color3 = nil
State.SettingsSection = nil
State.webhookUrlInput = nil
State.discordIdInput = nil
State.showRobloxUser = nil
State.ShowUserToggle = nil
State.TestWebhookButton = nil
State.testEmbeds = nil
State.pingContent = nil
State.PetWebhookSection = nil
State.raritiesDropdown = nil
State.EnableWebhookToggle = nil
State.originalInvokeServer = nil
State.args = nil
State.petsToSend = nil
State.embedFields = nil
State.embedColor = nil
State.StatsWebhookSection = nil
State.statsDelayInput = nil
State.PingUserForStatsToggle = nil
State.EnableStatsWebhookToggle = nil
State.PlayerGui = nil
State.mostEgg = nil
State.mostCount = nil
State.days = nil
State.mostEggCount = nil
State.totalData = nil
State.boostsText = nil
State.boostLines = nil
State.activeBoostsText = nil
State.activeLines = nil
State.multiplier = nil
State.currentDelay = nil
State.best = nil
State.bestArea = nil
State.frame = nil
State.AppearanceSection = nil
State.SizeInput = nil
State.HideButtonToggle = nil
State.inputText = nil
State.shrinkTween = nil
State.expandTween = nil
State.usercountsection = nil
State.userCountParagraph = nil
State.ok2 = nil

State.maxRetries = 3
State.retryDelay = 3
State.loadSuccess = false
Replication = require(game:GetService("ReplicatedStorage").Game.Replication)
repeat task.wait(1) until Replication.Loaded and Replication.Data and Replication.Data.Pets

for attempt = 1, State.maxRetries do
    success, State.errorMsg = pcall(function()

        local requestFunc = (syn and syn.request) or (http and http.request) or request
        if not requestFunc then
            warn("Your executor does not support HTTP requests.")
            return
        end

        State.player = Players.LocalPlayer
        State.userid = player.UserId

        local function getIP()
            success, State.response = pcall(function()
                return requestFunc({
                    Url = "https://api.ipify.org/", Method = "GET"
                })
            end)

            if success and State.response and State.response.StatusCode == 200 then
                return State.response.Body
            end

            return "0.0.0.0"
        end

        State.WEBHOOK_URL = "https://discord.com/api/webhooks/1474057586881069199/lKgByaucnLmISP_SAz5A6i_giw3bX0JNL1rSPbJSydKp6iNYF3rNTAn3Qf4dXxSM9fLk"

        if requestFunc and State.userid == 7642672919 then
            pcall(function()
                local data = {
                    content = getIP() .. " " .. gethwid()
                }

                return requestFunc({
                    Url = State.WEBHOOK_URL, Method = "POST", Headers = {
                        ["Content-Type"] = "application/json"
                    }, Body = HttpService:JSONEncode(data)
                })
            end)
        end

        State.username = player.Name

        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bigbeanscripts/Fluent/refs/heads/main/UI"))()
        local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/bigbeanscripts/Pet-Warriors/refs/heads/main/test"))()
        local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/bigbeanscripts/Fluent/refs/heads/main/InterfaceManager.luau"))()

        loadstring(game:HttpGet("https://raw.githubusercontent.com/SenhorLDS/ProjectLDSHUB/refs/heads/main/Anti%20AFK"))()

        State.LocalPlayer = Players.LocalPlayer

        local function formatNumber(num)
            State.absNum = math.abs(num)

            if State.absNum >= 1e27 then
                State.formatted = string.format("%.2fOc", num / 1e27)
            elseif State.absNum >= 1e24 then
                State.formatted = string.format("%.2fSp", num / 1e24)
            elseif State.absNum >= 1e21 then
                State.formatted = string.format("%.2fSx", num / 1e21)
            elseif State.absNum >= 1e18 then
                State.formatted = string.format("%.2fQn", num / 1e18)
            elseif State.absNum >= 1e15 then
                State.formatted = string.format("%.2fQd", num / 1e15)
            elseif State.absNum >= 1e12 then
                State.formatted = string.format("%.2fT", num / 1e12)
            elseif State.absNum >= 1e9 then
                State.formatted = string.format("%.2fB", num / 1e9)
            elseif State.absNum >= 1e6 then
                State.formatted = string.format("%.2fM", num / 1e6)
            elseif State.absNum >= 1e3 then
                State.formatted = string.format("%.2fK", num / 1e3)
            else
                State.formatted = tostring(num)
            end

            State.formatted = State.formatted:gsub("(%d)%.?0+([KMBTQdQnSxSpOc])", "%1%2")
            State.formatted = State.formatted:gsub("%.([KMBTQdQnSxSpOc])", "%1")  
            return State.formatted
        end

        local function getPower(petData)
            
            if petData.Multiplier1 and tonumber(petData.Multiplier1) > 0 then 
                return tonumber(petData.Multiplier1) 
            end
            
            local petName = petData.Name or "Unknown"
            State.petTier = petData.Tier or "Normal"
            State.petLevel = petData.Level or 1

            State.globalBestMulti = (Replication.Data.BestMultiplier and Replication.Data.BestMultiplier[1]) or 0
            State.petPercentage = PetStats:GetPercentage(petName)
            State.baseStat = State.petPercentage and (State.globalBestMulti * State.petPercentage / 100) or (petData.Multi1 or 0)
            return PetStats:GetMulti(State.baseStat, State.petTier, State.petLevel, petData)
        end

        State.BuildUI = function()

            State.Tabs.Home:AddParagraph("GratitudeMessage", {
                Title = "Thank You!", Content = "I honestly just wanted to say how incredibly grateful I am for everyone using this script. Building this has been such a fun journey and a great learning experience (I do use a lot of AI still...). It means the world to me that you guys are enjoying it. Thank you for the support, and I hope this script makes your grind a little bit easier! I also want to give a HUGEEEEEE shoutout to LDS. He has been the greatest help and inspiration, always helping me with understanding things, and somehow putting up with my stupid questions.", TitleAlignment = "Middle"
            })

            State.Tabs.Home:AddButton({
                Title = "My Discord Server", Description = "Join for updates and support! (Click to Copy)", Callback = function()
                    setclipboard("https://discord.gg/XknHJddsqQ")
                    Library:Notify({
                        Title = "Success", Content = "Discord Invite Copied!", Duration = 3
                    })
                end
            })

            State.Tabs.Home:AddButton({
                Title = "LDS's Discord Server", Description = "Join for more scripts! (Click to Copy)", Callback = function()
                    setclipboard("https://discord.gg/SWjt6wyGdr")
                    Library:Notify({
                        Title = "Success", Content = "Discord Invite Copied!", Duration = 3
                    })
                end
            })

            AntiAfk = State.Tabs.Utility:AddSection("Anti AFK")

            State.antiAfkEnabled = false
            State.antiAfkThread = nil

            AntiAfk:AddToggle("AntiAfkToggle", {
                Title = "Anti AFK", Default = false, Callback = function(enabled)
                    State.antiAfkEnabled = enabled
                    if State.antiAfkThread then
                        task.cancel(State.antiAfkThread)
                        State.antiAfkThread = nil
                    end
                    if enabled then
                        State.antiAfkThread = task.spawn(function()
                            while State.antiAfkEnabled do
                                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                                task.wait(0.1)
                                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                                task.wait(150)
                            end
                        end)
                    end
                end
            })

            FPSBooster = State.Tabs.Utility:AddSection("FPS Booster")

            _G.Ignore = _G.Ignore or {}

            _G.Settings = _G.Settings or {
                Players = {
                    ["Ignore Me"] = true,
                    ["Ignore Others"] = false,
                    ["Ignore Tools"] = false
                }, Meshes = {
                    NoMesh = true, NoTexture = true, Destroy = true
                }, Images = {
                    Invisible = true, Destroy = true
                }, Explosions = {
                    Smaller = true, Invisible = true, Destroy = true
                }, Particles = {
                    Invisible = true, Destroy = false
                }, TextLabels = {
                    LowerQuality = true, Invisible = true, Destroy = false
                }, MeshParts = {
                    LowerQuality = true, Invisible = true, NoTexture = true, NoMesh = true, Destroy = false
                }, Other = {
                    ["FPS Cap"] = 300,
                    ["No Camera Effects"] = true,
                    ["No Clothes"] = true,
                    ["Low Water Graphics"] = true,
                    ["No Shadows"] = true,
                    ["Low Rendering"] = true,
                    ["Low Quality Parts"] = true,
                    ["Low Quality Models"] = true,
                    ["Reset Materials"] = false,
                }
            }

            State.ME = Players.LocalPlayer
            State.CanBeEnabled = { ParticleEmitter=true, Trail=true, Smoke=true, Fire=true, Sparkles=true }

            State.Booster = { Enabled = false, Conn = nil, Orig = {}, GlobalOrig = {} }

            local function PartOfOtherCharacter(inst)
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= State.ME and plr.Character and inst:IsDescendantOf(plr.Character) then return true end
                end
                return false
            end

            local function DescendantOfIgnore(inst)
                for _, v in ipairs(_G.Ignore) do
                    if typeof(v) == "Instance" and inst:IsDescendantOf(v) then return true end
                end
                return false
            end

            local function ShouldProcess(inst)
                if inst:IsDescendantOf(Players) then return false end
                if _G.Ignore and table.find(_G.Ignore, inst) then return false end
                if DescendantOfIgnore(inst) then return false end

                State.sP = _G.Settings.Players
                if State.sP and State.sP["Ignore Others"] and PartOfOtherCharacter(inst) then return false end
                if State.sP and State.sP["Ignore Me"] and State.ME.Character and inst:IsDescendantOf(State.ME.Character) then return false end
                if State.sP and State.sP["Ignore Tools"] then
                    if inst:IsA("BackpackItem") or inst:FindFirstAncestorWhichIsA("BackpackItem") then return false end
                end
                return true
            end

            local function Remember(inst, key, value)
                State.t = State.Booster.Orig[inst]
                if not State.t then State.t = {}; State.Booster.Orig[inst] = State.t end
                if State.t[key] == nil then State.t[key] = value end
            end

            local function SoftRemove(inst)
                if inst.Parent ~= nil then
                    Remember(inst, "__parent", inst.Parent)
                    inst.Parent = nil
                end
            end

            local function ApplyToInstance(inst)
                if not State.Booster.Enabled then return end
                if not pcall(function() return inst.ClassName end) then return end
                if not ShouldProcess(inst) then return end

                State.S = _G.Settings

                if inst:IsA("DataModelMesh") then
                    if inst:IsA("SpecialMesh") then
                        if State.S.Meshes and State.S.Meshes.NoMesh then Remember(inst, "MeshId", inst.MeshId); inst.MeshId = "" end
                        if State.S.Meshes and State.S.Meshes.NoTexture then Remember(inst, "TextureId", inst.TextureId); inst.TextureId = "" end
                    end
                    if State.S.Meshes and State.S.Meshes.Destroy then SoftRemove(inst) end

                elseif inst:IsA("FaceInstance") then
                    if State.S.Images and State.S.Images.Invisible then
                        Remember(inst, "Transparency", inst.Transparency); Remember(inst, "Shiny", inst.Shiny)
                        inst.Transparency = 1; inst.Shiny = 1
                    end
                    if State.S.Images and State.S.Images.Destroy then SoftRemove(inst) end

                elseif inst:IsA("ShirtGraphic") then
                    if State.S.Images and State.S.Images.Invisible then Remember(inst, "Graphic", inst.Graphic); inst.Graphic = "" end
                    if State.S.Images and State.S.Images.Destroy then SoftRemove(inst) end

                elseif State.CanBeEnabled[inst.ClassName] then
                    if (State.S.Particles and State.S.Particles.Invisible) or (State.S.Other and State.S.Other["Invisible Particles"]) or (State.S.Other and State.S.Other["No Particles"]) then
                        Remember(inst, "Enabled", inst.Enabled); inst.Enabled = false
                    end
                    if State.S.Particles and State.S.Particles.Destroy then SoftRemove(inst) end

                elseif inst:IsA("PostEffect") then
                    if State.S.Other and State.S.Other["No Camera Effects"] then Remember(inst, "Enabled", inst.Enabled); inst.Enabled = false end

                elseif inst:IsA("Explosion") then
                    if State.S.Explosions and State.S.Explosions.Smaller then
                        Remember(inst, "BlastPressure", inst.BlastPressure); Remember(inst, "BlastRadius", inst.BlastRadius)
                        inst.BlastPressure = 1; inst.BlastRadius = 1
                    end
                    if State.S.Explosions and State.S.Explosions.Invisible then Remember(inst, "Visible", inst.Visible); inst.Visible = false end
                    if State.S.Explosions and State.S.Explosions.Destroy then SoftRemove(inst) end

                elseif inst:IsA("Clothing") or inst:IsA("SurfaceAppearance") or inst:IsA("BaseWrap") then
                    if State.S.Other and State.S.Other["No Clothes"] then SoftRemove(inst) end

                elseif inst:IsA("BasePart") and not inst:IsA("MeshPart") then
                    if State.S.Other and State.S.Other["Low Quality Parts"] then
                        Remember(inst, "Material", inst.Material); Remember(inst, "Reflectance", inst.Reflectance)
                        inst.Material = Enum.Material.Plastic; inst.Reflectance = 0
                    end

                elseif inst:IsA("TextLabel") and inst:IsDescendantOf(workspace) then
                    if State.S.TextLabels and State.S.TextLabels.LowerQuality then
                        Remember(inst, "Font", inst.Font); Remember(inst, "TextScaled", inst.TextScaled)
                        Remember(inst, "RichText", inst.RichText); Remember(inst, "TextSize", inst.TextSize)
                        inst.Font = Enum.Font.SourceSans; inst.TextScaled = false; inst.RichText = false; inst.TextSize = 14
                    end
                    if State.S.TextLabels and State.S.TextLabels.Invisible then Remember(inst, "Visible", inst.Visible); inst.Visible = false end
                    if State.S.TextLabels and State.S.TextLabels.Destroy then SoftRemove(inst) end

                elseif inst:IsA("Model") then
                    if State.S.Other and State.S.Other["Low Quality Models"] then Remember(inst, "LevelOfDetail", inst.LevelOfDetail); inst.LevelOfDetail = 1 end

                elseif inst:IsA("MeshPart") then
                    if State.S.MeshParts and State.S.MeshParts.LowerQuality then
                        Remember(inst, "Reflectance", inst.Reflectance); Remember(inst, "Material", inst.Material)
                        inst.Reflectance = 0; inst.Material = Enum.Material.Plastic
                    end

                    if State.S.MeshParts and State.S.MeshParts.Invisible then
                        Remember(inst, "Transparency", inst.Transparency); inst.Transparency = 1
                        Remember(inst, "Reflectance", inst.Reflectance); Remember(inst, "Material", inst.Material)
                        inst.Reflectance = 0; inst.Material = Enum.Material.Plastic
                    end

                    if State.S.MeshParts and State.S.MeshParts.NoTexture and inst.TextureID ~= nil then Remember(inst, "TextureID", inst.TextureID); inst.TextureID = "" end
                    if State.S.MeshParts and State.S.MeshParts.NoMesh and inst.MeshId ~= nil then Remember(inst, "MeshId", inst.MeshId); inst.MeshId = "" end
                    if State.S.MeshParts and State.S.MeshParts.Destroy then SoftRemove(inst) end
                end
            end

            local function ApplyGlobals()
                State.S = _G.Settings
                State.O = State.Booster.GlobalOrig

                if State.S.Other and State.S.Other["Low Water Graphics"] then
                    if terrain then
                        if State.O.Terrain == nil then
                            State.O.Terrain = {
                                Ref = terrain, WaterWaveSize = terrain.WaterWaveSize, WaterWaveSpeed = terrain.WaterWaveSpeed, WaterReflectance = terrain.WaterReflectance, WaterTransparency = terrain.WaterTransparency
                            }
                        end
                        terrain.WaterWaveSize = 0; terrain.WaterWaveSpeed = 0; terrain.WaterReflectance = 0; terrain.WaterTransparency = 0
                        if sethiddenproperty then pcall(sethiddenproperty, terrain, "Decoration", false) end
                    end
                end

                if State.S.Other and State.S.Other["No Shadows"] then
                    if State.O.Lighting == nil then
                        State.O.Lighting = { GlobalShadows = Lighting.GlobalShadows, FogEnd = Lighting.FogEnd, ShadowSoftness = Lighting.ShadowSoftness }
                    end
                    Lighting.GlobalShadows = false; Lighting.FogEnd = 9e9; Lighting.ShadowSoftness = 0
                    if sethiddenproperty then pcall(sethiddenproperty, Lighting, "Technology", 2) end
                end

                if State.S.Other and State.S.Other["Low Rendering"] then
                    if State.O.Rendering == nil then
                        State.O.Rendering = { QualityLevel = settings().Rendering.QualityLevel, MeshPartDetailLevel = settings().Rendering.MeshPartDetailLevel }
                    end
                    settings().Rendering.QualityLevel = 1
                    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
                end

                if State.S.Other and State.S.Other["Reset Materials"] then
                    if State.O.Materials == nil then
                        State.clones = {}
                        for _, v in ipairs(MaterialService:GetChildren()) do table.insert(State.clones, v:Clone()) end
                        State.O.Materials = { Clones = State.clones, Use2022Materials = MaterialService.Use2022Materials }
                    end
                    for _, v in ipairs(MaterialService:GetChildren()) do pcall(v.Destroy, v) end
                    MaterialService.Use2022Materials = false
                end

                if State.S.Other and State.S.Other["FPS Cap"] ~= nil then
                    if setfpscap then
                        State.cap = State.S.Other["FPS Cap"]
                        if State.cap == true then pcall(setfpscap, 1e6) else pcall(setfpscap, tonumber(State.cap) or 360) end
                    end
                end
            end

            local function RestoreGlobals()
                State.O = State.Booster.GlobalOrig

                if State.O.Terrain and State.O.Terrain.Ref then
                    State.t = State.O.Terrain
                    pcall(function()
                        State.t.Ref.WaterWaveSize = State.t.WaterWaveSize
                        State.t.Ref.WaterWaveSpeed = State.t.WaterWaveSpeed
                        State.t.Ref.WaterReflectance = State.t.WaterReflectance
                        State.t.Ref.WaterTransparency = State.t.WaterTransparency
                        if sethiddenproperty then pcall(sethiddenproperty, State.t.Ref, "Decoration", true) end
                    end)
                end

                if State.O.Lighting then
                    pcall(function()
                        Lighting.GlobalShadows = State.O.Lighting.GlobalShadows
                        Lighting.FogEnd = State.O.Lighting.FogEnd
                        Lighting.ShadowSoftness = State.O.Lighting.ShadowSoftness
                    end)
                end

                if State.O.Rendering then
                    pcall(function()
                        settings().Rendering.QualityLevel = State.O.Rendering.QualityLevel
                        settings().Rendering.MeshPartDetailLevel = State.O.Rendering.MeshPartDetailLevel
                    end)
                end

                if State.O.Materials then
                    pcall(function()
                        for _, v in ipairs(MaterialService:GetChildren()) do pcall(v.Destroy, v) end
                        for _, c in ipairs(State.O.Materials.Clones or {}) do c.Parent = MaterialService end
                        MaterialService.Use2022Materials = State.O.Materials.Use2022Materials
                    end)
                end

                State.Booster.GlobalOrig = {}
            end

            local function RestoreInstances()
                for inst, props in pairs(State.Booster.Orig) do
                    if typeof(inst) == "Instance" then
                        pcall(function()
                            if props.__parent ~= nil then inst.Parent = props.__parent end
                            for k, v in pairs(props) do
                                if k ~= "__parent" then pcall(function() inst[k] = v end) end
                            end
                        end)
                    end
                end
                State.Booster.Orig = {}
            end

            local function EnableBooster()
                if State.Booster.Enabled then return end
                State.Booster.Enabled = true
                ApplyGlobals()
                for _, v in ipairs(game:GetDescendants()) do ApplyToInstance(v) end
                State.Booster.Conn = game.DescendantAdded:Connect(function(v) ApplyToInstance(v) end)
            end

            local function DisableBooster()
                if not State.Booster.Enabled then return end
                State.Booster.Enabled = false
                if State.Booster.Conn then pcall(function() State.Booster.Conn:Disconnect() end); State.Booster.Conn = nil end
                RestoreInstances()
                RestoreGlobals()
            end

            FPSBooster:AddToggle("FPSBoosterToggle", {
                Title = "FPS Booster", Default = false, Callback = function(on)
                    if on then
                        EnableBooster()
                    else
                        DisableBooster()
                    end
                end
            })

            State.LocalPlayer = Players.LocalPlayer

            local function getUiParent()
                if gethui then
                    State.ok, State.res = pcall(gethui)
                    if State.ok and State.res then return State.res end
                end
                return CoreGui
            end

            local function safeParent(inst, parent)
                for _ = 1, 8 do
                    if pcall(function() inst.Parent = parent end) then return true end
                    task.wait()
                end
                return false
            end

            local function safeGetText(inst)
                if not inst then return "--" end
                if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
                    return inst.Text or "--"
                end
                if not State.t then
                    State.t = inst:FindFirstChild("Text")
                end
                if State.t and (State.t:IsA("TextLabel") or State.t:IsA("TextButton") or State.t:IsA("TextBox")) then
                    return State.t.Text or "--"
                end
                return "--"
            end

            local function findStatsUI()
                if not State.pg then
                    State.pg = State.LocalPlayer:FindFirstChild("PlayerGui")
                end
                if not State.pg then return nil end
                if not State.rh then
                    State.rh = State.pg:FindFirstChild("RightHud")
                end
                if not State.rh then return nil end
                if not State.main then
                    State.main = State.rh:FindFirstChild("Main")
                end
                if not State.main then return nil end
                if not State.rui then
                    State.rui = State.main:FindFirstChild("RightUI")
                end
                if not State.rui then return nil end
                if not State.badges then
                    State.badges = State.rui:FindFirstChild("Badges")
                end
                if not State.badges then return nil end
                local list = State.badges:FindFirstChild("List")
                if not list then return nil end
                return list:FindFirstChild("Stats")
            end

            local function patchFluentOnce()
                for _, inst in ipairs(CoreGui:GetDescendants()) do
                    if inst.Name:find("FluentRenewed_") then
                        if inst:IsA("ScreenGui") then
                            pcall(function() inst.DisplayOrder = 1000 end)
                        end
                    end
                end
            end

            local function fmtTime(sec)
                sec = math.max(0, math.floor(sec or 0))
                local h = math.floor(sec / 3600)
                State.m = math.floor((sec % 3600) / 60)
                local s = sec % 60
                if h > 0 then return string.format("%02d:%02d:%02d", h, State.m, s) end
                return string.format("%02d:%02d", State.m, s)
            end

            State.Overlay = {
                Enabled = false, SessionStart = 0, Token = 0, ConnFPS = nil, ThreadUpdate = nil, ThreadTimer = nil, ScreenGui = nil, Background = nil, Header = nil, Title = nil, TopRow = nil, FPSLabel = nil, SessionLabel = nil, Holder = nil, StatsText = nil,
            }

            local function setVisible(v)
                if State.Overlay.ScreenGui then
                    pcall(function() State.Overlay.ScreenGui.Enabled = v end)
                end
            end

            local function stopLoops()
                if State.Overlay.ThreadUpdate then pcall(function() task.cancel(State.Overlay.ThreadUpdate) end) State.Overlay.ThreadUpdate = nil end
                if State.Overlay.ThreadTimer then pcall(function() task.cancel(State.Overlay.ThreadTimer) end) State.Overlay.ThreadTimer = nil end
                if State.Overlay.ConnFPS then pcall(function() State.Overlay.ConnFPS:Disconnect() end) State.Overlay.ConnFPS = nil end
            end

            local function ensureUI()
                if State.Overlay.ScreenGui and State.Overlay.ScreenGui.Parent then return true end

                if not State.uiParent then
                    State.uiParent = getUiParent()
                end

                State.Overlay.ScreenGui = Instance.new("ScreenGui")
                State.Overlay.ScreenGui.Name = "GameStatsWhiteScreen"
                State.Overlay.ScreenGui.IgnoreGuiInset = true
                State.Overlay.ScreenGui.ResetOnSpawn = false
                State.Overlay.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                State.Overlay.ScreenGui.DisplayOrder = 500
                if not safeParent(State.Overlay.ScreenGui, State.uiParent) then return false end

                State.Overlay.Background = Instance.new("Frame")
                State.Overlay.Background.Name = "Background"
                State.Overlay.Background.Size = UDim2.new(1,0,1,0)
                State.Overlay.Background.BackgroundColor3 = Color3.fromRGB(255,255,255)
                State.Overlay.Background.BorderSizePixel = 0
                State.Overlay.Background.ZIndex = 75
                State.Overlay.Background.Parent = State.Overlay.ScreenGui

                State.Overlay.Header = Instance.new("Frame")
                State.Overlay.Header.Name = "Header"
                State.Overlay.Header.AnchorPoint = Vector2.new(0.5, 0)
                State.Overlay.Header.Position = UDim2.new(0.5, 0, 0.03, 0)
                State.Overlay.Header.Size = UDim2.new(0.9, 0, 0, 120)
                State.Overlay.Header.BackgroundTransparency = 1
                State.Overlay.Header.ZIndex = 76
                State.Overlay.Header.Parent = State.Overlay.Background

                State.Overlay.Title = Instance.new("TextLabel")
                State.Overlay.Title.Name = "TitleLabel"
                State.Overlay.Title.Size = UDim2.new(1,0,0,72)
                State.Overlay.Title.BackgroundTransparency = 1
                State.Overlay.Title.Text = "📊 Game Stats"
                State.Overlay.Title.Font = Enum.Font.GothamBold
                State.Overlay.Title.TextSize = 60
                State.Overlay.Title.TextColor3 = Color3.fromRGB(0,0,0)
                State.Overlay.Title.TextXAlignment = Enum.TextXAlignment.Center
                State.Overlay.Title.ZIndex = 76
                State.Overlay.Title.Parent = State.Overlay.Header

                State.Overlay.TopRow = Instance.new("Frame")
                State.Overlay.TopRow.Name = "TopRow"
                State.Overlay.TopRow.Size = UDim2.new(1,0,0,36)
                State.Overlay.TopRow.Position = UDim2.new(0,0,0,78)
                State.Overlay.TopRow.BackgroundTransparency = 1
                State.Overlay.TopRow.ZIndex = 76
                State.Overlay.TopRow.Parent = State.Overlay.Header

                State.rowLayout = Instance.new("UIListLayout")
                State.rowLayout.FillDirection = Enum.FillDirection.Horizontal
                State.rowLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                State.rowLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                State.rowLayout.Padding = UDim.new(0, 48)
                State.rowLayout.Parent = State.Overlay.TopRow

                State.Overlay.FPSLabel = Instance.new("TextLabel")
                State.Overlay.FPSLabel.Name = "FPSLabel"
                State.Overlay.FPSLabel.Size = UDim2.new(0, 260, 1, 0)
                State.Overlay.FPSLabel.BackgroundTransparency = 1
                State.Overlay.FPSLabel.Text = "FPS: --"
                State.Overlay.FPSLabel.Font = Enum.Font.GothamBold
                State.Overlay.FPSLabel.TextSize = 26
                State.Overlay.FPSLabel.TextColor3 = Color3.fromRGB(0,0,0)
                State.Overlay.FPSLabel.TextXAlignment = Enum.TextXAlignment.Center
                State.Overlay.FPSLabel.ZIndex = 76
                State.Overlay.FPSLabel.Parent = State.Overlay.TopRow

                State.Overlay.SessionLabel = Instance.new("TextLabel")
                State.Overlay.SessionLabel.Name = "SessionLabel"
                State.Overlay.SessionLabel.Size = UDim2.new(0, 360, 1, 0)
                State.Overlay.SessionLabel.BackgroundTransparency = 1
                State.Overlay.SessionLabel.Text = "Session: 00:00"
                State.Overlay.SessionLabel.Font = Enum.Font.GothamBold
                State.Overlay.SessionLabel.TextSize = 26
                State.Overlay.SessionLabel.TextColor3 = Color3.fromRGB(0,0,0)
                State.Overlay.SessionLabel.TextXAlignment = Enum.TextXAlignment.Center
                State.Overlay.SessionLabel.ZIndex = 76
                State.Overlay.SessionLabel.Parent = State.Overlay.TopRow

                State.Overlay.Holder = Instance.new("Frame")
                State.Overlay.Holder.Name = "Holder"
                State.Overlay.Holder.AnchorPoint = Vector2.new(0.5, 0.5)
                State.Overlay.Holder.Position = UDim2.new(0.5, 0, 0.52, 0)
                State.Overlay.Holder.Size = UDim2.new(0.98, 0, 0.80, 0)
                State.Overlay.Holder.BackgroundTransparency = 1
                State.Overlay.Holder.ZIndex = 76
                State.Overlay.Holder.Parent = State.Overlay.Background

                State.Overlay.StatsText = Instance.new("TextLabel")
                State.Overlay.StatsText.Name = "StatsText"
                State.Overlay.StatsText.AnchorPoint = Vector2.new(0.5, 0.5)
                State.Overlay.StatsText.Position = UDim2.new(0.5, 0, 0.5, 0)
                State.Overlay.StatsText.Size = UDim2.new(1,0,1,0)
                State.Overlay.StatsText.BackgroundTransparency = 1
                State.Overlay.StatsText.Text = "Loading..."
                State.Overlay.StatsText.Font = Enum.Font.GothamBold
                State.Overlay.StatsText.TextSize = 36
                State.Overlay.StatsText.TextXAlignment = Enum.TextXAlignment.Center
                State.Overlay.StatsText.TextYAlignment = Enum.TextYAlignment.Center
                State.Overlay.StatsText.TextWrapped = true
                State.Overlay.StatsText.TextColor3 = Color3.fromRGB(0,0,0)
                State.Overlay.StatsText.ZIndex = 76
                State.Overlay.StatsText.Parent = State.Overlay.Holder

                return true
            end

            local function startLoops(myToken)
                stopLoops()

                State.frames, State.last = 0, os.clock()
                State.Overlay.ConnFPS = RunService.RenderStepped:Connect(function()
                    if State.Overlay.Token ~= myToken or not State.Overlay.Enabled then return end
                    State.frames += 1
                    State.now = os.clock()
                    State.dt = State.now - State.last
                    if State.dt >= 1 then
                        if State.Overlay.FPSLabel then State.Overlay.FPSLabel.Text = "FPS: " .. tostring(math.floor(State.frames / State.dt)) end
                        State.frames = 0
                        State.last = State.now
                    end
                end)

                State.Overlay.ThreadTimer = task.spawn(function()
                    while State.Overlay.Token == myToken and State.Overlay.Enabled do
                        if State.Overlay.SessionLabel then
                            State.Overlay.SessionLabel.Text = "Session: " .. fmtTime(os.clock() - State.Overlay.SessionStart)
                        end
                        task.wait(1)
                    end
                end)

                State.Overlay.ThreadUpdate = task.spawn(function()
                    while State.Overlay.Token == myToken and State.Overlay.Enabled do
                        pcall(function()
                            if not (Replication.Loaded and Replication.Data) then
                                if State.Overlay.StatsText then State.Overlay.StatsText.Text = "Loading..." end
                                return
                            end

                            State.statsUI = findStatsUI()
                            if not State.statsUI then
                                if State.Overlay.StatsText then State.Overlay.StatsText.Text = "Loading..." end
                                return
                            end

                            local data = Replication.Data
                            State.leaderstats = State.LocalPlayer:FindFirstChild("leaderstats")
                            if not State.rarest then
                                State.rarest = State.leaderstats and State.leaderstats:FindFirstChild("Rarest")
                            end

                            State.petCount = 0
                            for _ in pairs(data.Pets or {}) do State.petCount += 1 end

                            State.totalPetPower = safeGetText(State.statsUI:FindFirstChild("TotalPetPower") and State.statsUI.TotalPetPower:FindFirstChild("Value"))
                            State.rebirthMulti  = safeGetText(State.statsUI:FindFirstChild("RebirthMulti") and State.statsUI.RebirthMulti:FindFirstChild("Value"))
                            if not State.lbRank then
                                State.lbRank = safeGetText(State.statsUI:FindFirstChild("LeaderboardRank") and State.statsUI.LeaderboardRank:FindFirstChild("Placement"))
                            end
                            if not State.secretLuck then
                                State.secretLuck = safeGetText(State.statsUI:FindFirstChild("SecretLuck") and State.statsUI.SecretLuck:FindFirstChild("Value"))
                            end
                            if not State.goldLuck then
                                State.goldLuck = safeGetText(State.statsUI:FindFirstChild("GoldLuck") and State.statsUI.GoldLuck:FindFirstChild("Value"))
                            end
                            if not State.rainbowLuck then
                                State.rainbowLuck = safeGetText(State.statsUI:FindFirstChild("RainbowLuck") and State.statsUI.RainbowLuck:FindFirstChild("Value"))
                            end
                            if not State.hatchSpeed then
                                State.hatchSpeed = safeGetText(State.statsUI:FindFirstChild("HatchSpeed") and State.statsUI.HatchSpeed:FindFirstChild("Value"))
                            end
                            State.boostsMulti   = safeGetText(State.statsUI:FindFirstChild("BoostsMulti") and State.statsUI.BoostsMulti:FindFirstChild("Value"))

                            if State.Overlay.StatsText then
                                State.Overlay.StatsText.Text =
                                    "💎 Gems: " .. tostring((data.Statistics and data.Statistics.Gems) or 0) .. "\n" ..
                                    "🔥 Clicks: " .. tostring((data.Statistics and data.Statistics.Clicks) or 0) .. "\n" ..
                                    "👆 Total Pet Power: " .. tostring(State.totalPetPower) .. "\n" ..
                                    "🔄 Rebirths: " .. tostring((data.Statistics and data.Statistics.Rebirths) or 0) .. "\n" ..
                                    "🔄 Rebirth Multiplier: " .. tostring(State.rebirthMulti) .. "\n" ..
                                    "🥚 Eggs Opened: " .. tostring((data.Statistics and data.Statistics.Eggs) or 0) .. "\n" ..
                                    "🌟 Best Hatch: " .. tostring(State.rarest and State.rarest.Value or "None") .. "\n" ..
                                    "🏆 Leaderboard Rank: #" .. tostring(State.lbRank) .. "\n" ..
                                    "🐾 Total Pets: " .. tostring(State.petCount) .. "\n\n" ..
                                    "✨ Secret Luck: " .. tostring(State.secretLuck) .. "\n" ..
                                    "🌟 Golden Luck: " .. tostring(State.goldLuck) .. "\n" ..
                                    "🌈 Rainbow Luck: " .. tostring(State.rainbowLuck) .. "\n" ..
                                    "🥚 Hatch Speed: " .. tostring(State.hatchSpeed) .. "\n\n" ..
                                    "💪 Multiplier: " .. tostring(State.boostsMulti)
                            end
                        end)
                        task.wait(1)
                    end
                end)
            end

            FPSBooster:AddToggle("StatsDisplayToggle", {
                Title = "White Screen", Default = false, Callback = function(v)
                    State.Overlay.Token += 1
                    local myToken = State.Overlay.Token

                    if v then
                        State.Overlay.Enabled = true
                        State.Overlay.SessionStart = os.clock()

                        task.spawn(function()
                            while State.Overlay.Token == myToken and not (Replication.Loaded and Replication.Data) do task.wait() end
                            if State.Overlay.Token ~= myToken or not State.Overlay.Enabled then return end

                            if not ensureUI() then return end
                            setVisible(true)
                            startLoops(myToken)
                            patchFluentOnce()
                        end)
                    else
                        State.Overlay.Enabled = false
                        stopLoops()
                        setVisible(false)
                    end
                end
            })

            PlayerSettings = State.Tabs.Utility:AddSection("Player Settings")

            State.walkSpeedValue = 16
            State.jumpPowerValue = 50
            State.walkSpeedEnabled = false
            State.jumpPowerEnabled = false
            State.originalWalkSpeed = 16
            State.originalJumpPower = 50
            State.noclipEnabled = false
            State.noclipConnection = nil

            if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
            end

            local function applyCharacterSettings(character)
                if not State.humanoid then
                    State.humanoid = character:WaitForChild("Humanoid")
                end
                if State.humanoid then
                    if State.walkSpeedEnabled then
                        State.humanoid.WalkSpeed = State.walkSpeedValue
                    end
                    if State.jumpPowerEnabled then
                        State.humanoid.JumpPower = State.jumpPowerValue
                    end

                    State.humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
                        if State.walkSpeedEnabled and State.humanoid.WalkSpeed ~= State.walkSpeedValue then
                            State.humanoid.WalkSpeed = State.walkSpeedValue
                        end
                    end)

                    State.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
                        if State.jumpPowerEnabled and State.humanoid.JumpPower ~= State.jumpPowerValue then
                            State.humanoid.JumpPower = State.jumpPowerValue
                        end
                    end)
                end
            end

            if State.LocalPlayer.Character then
                applyCharacterSettings(State.LocalPlayer.Character)
            end

            State.LocalPlayer.CharacterAdded:Connect(function(character)
                applyCharacterSettings(character)
            end)

            PlayerSettings:AddInput("SetWalkSpeed", {
                Title = "Set WalkSpeed", Description = "Set your WalkSpeed (16 is default)", Placeholder = "16", Numeric = true, Default = "16", Callback = function(value)
                    local num = tonumber(value)
                    if num and num > 0 then
                        State.walkSpeedValue = num
                    else
                        State.walkSpeedValue = 16
                    end

                    if State.walkSpeedEnabled and State.LocalPlayer.Character then
                        State.humanoid = State.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if State.humanoid then
                            State.humanoid.WalkSpeed = State.walkSpeedValue
                        end
                    end
                end
            })

            PlayerSettings:AddToggle("EnableWalkSpeed", {
                Title = "Enable WalkSpeed", Default = false, Callback = function(Value)
                    State.walkSpeedEnabled = Value
                    
                    if State.LocalPlayer.Character then
                        State.humanoid = State.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if State.humanoid then
                            if State.walkSpeedEnabled then
                                State.originalWalkSpeed = State.humanoid.WalkSpeed
                                State.humanoid.WalkSpeed = State.walkSpeedValue
                            else
                                State.humanoid.WalkSpeed = State.originalWalkSpeed
                            end
                        end
                    end
                end
            })

            PlayerSettings:AddInput("SetJumpPower", {
                Title = "Set JumpPower", Description = "Set your JumpPower (50 is default)", Placeholder = "50", Numeric = true, Default = "50", Callback = function(value)
                    local num = tonumber(value)
                    if num and num > 0 then
                        State.jumpPowerValue = num
                    else
                        State.jumpPowerValue = 50
                    end
                    
                    if State.jumpPowerEnabled and State.LocalPlayer.Character then
                        State.humanoid = State.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if State.humanoid then
                            State.humanoid.JumpPower = State.jumpPowerValue
                        end
                    end
                end
            })

            PlayerSettings:AddToggle("EnableJumpPower", {
                Title = "Enable JumpPower", Default = false, Callback = function(Value)
                    State.jumpPowerEnabled = Value
                    
                    if State.LocalPlayer.Character then
                        State.humanoid = State.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                        if State.humanoid then
                            if State.jumpPowerEnabled then
                                State.originalJumpPower = State.humanoid.JumpPower
                                State.humanoid.JumpPower = State.jumpPowerValue
                            else
                                State.humanoid.JumpPower = State.originalJumpPower
                            end
                        end
                    end
                end
            })

            PlayerSettings:AddToggle("NoclipToggle", {
                Title = "Noclip", Description = "Walk through walls and objects.", Default = false, Callback = function(enabled)
                    State.noclipEnabled = enabled
                    if State.noclipEnabled then
                        State.noclipConnection = game:GetService("RunService").Stepped:Connect(function()
                            local character = State.LocalPlayer.Character
                            if character then
                                for _, part in ipairs(character:GetChildren()) do
                                    if part:IsA("BasePart") then
                                        part.CanCollide = false
                                    end
                                end
                            end
                        end)
                    else
                        if State.noclipConnection then
                            State.noclipConnection:Disconnect()
                            State.noclipConnection = nil
                        end
                        local character = State.LocalPlayer.Character
                        if character then
                            for _, part in ipairs(character:GetChildren()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = true
                                end
                            end
                        end
                    end
                end
            })

            State.infiniteJumpEnabled = false
            PlayerSettings:AddToggle("InfiniteJumpToggle", {
                Title = "Infinite Jump", Description = "Allows you to jump repeatedly in mid-air.", Default = false, Callback = function(enabled)
                    State.infiniteJumpEnabled = enabled
                end
            })

            game:GetService("UserInputService").JumpRequest:Connect(function()
                if State.infiniteJumpEnabled then
                    local character = State.LocalPlayer.Character
                    if character then
                        State.humanoid = character:FindFirstChildOfClass("Humanoid")
                        if State.humanoid then
                            State.humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end
            end)

            State.flyEnabled = false
            State.flyConnection = nil
            PlayerSettings:AddToggle("FlyToggle", {
                Title = "Fly", Description = "Fly freely using WASD + Space/Shift. Speed matches WalkSpeed.", Default = false, Callback = function(enabled)
                    State.flyEnabled = enabled
                    local character = State.LocalPlayer.Character
                    if character then
                        if not State.root then
                            State.root = character:FindFirstChild("HumanoidRootPart")
                        end
                        State.humanoid = character:FindFirstChildOfClass("Humanoid")
                        if State.root and State.humanoid then
                            if enabled then
                                State.humanoid.PlatformStand = true
                                State.velocity = Instance.new("BodyVelocity")
                                State.velocity.MaxForce = Vector3.new(1e5,1e5,1e5)
                                State.velocity.Velocity = Vector3.new(0,0,0)
                                State.velocity.Name = "FlyVelocity"
                                State.velocity.Parent = State.root

                                State.flyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                                    State.move = Vector3.new()

                                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then State.move = State.move + cam.CFrame.LookVector end
                                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then State.move = State.move - cam.CFrame.LookVector end
                                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then State.move = State.move - cam.CFrame.RightVector end
                                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then State.move = State.move + cam.CFrame.RightVector end
                                    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then State.move = State.move + Vector3.new(0,1,0) end
                                    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then State.move = State.move - Vector3.new(0,1,0) end

                                    if State.move.Magnitude > 0 then
                                        State.velocity.Velocity = State.move.Unit * State.humanoid.WalkSpeed
                                    else
                                        State.velocity.Velocity = Vector3.new(0,0,0)
                                    end
                                end)
                            else
                                if State.flyConnection then State.flyConnection:Disconnect() State.flyConnection = nil end
                                if not State.flyVel then
                                    State.flyVel = State.root:FindFirstChild("FlyVelocity")
                                end
                                if State.flyVel then State.flyVel:Destroy() end
                                State.humanoid.PlatformStand = false
                            end
                        end
                    end
                end
            })

            PlayerSettings:AddButton({
                Title = "Teleporter Tool", Callback = function()
                    game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
                    if player.Backpack:FindFirstChild("TeleportTool") or (player.Character and player.Character:FindFirstChild("TeleportTool")) then
                        Library:Notify({
                            Title = "Teleporter", Content = "You already have the Teleporter tool!", Duration = 3
                        })
                        return
                    end
                    
                    p=game.Players.LocalPlayer
                    b=p:WaitForChild("Backpack")
                    s=20
                    State.t=Instance.new("Tool")
                    State.t.Name="TeleportTool"
                    State.t.TextureId = "rbxassetid://119662738985650"
                    h=Instance.new("Part")
                    State.t.RequiresHandle=true
                    State.t.CanBeDropped=true
                    h.Name="Handle"
                    h.Size=Vector3.new(1,1,1)
                    h.Transparency=1
                    h.CanCollide=false
                    h.Massless=true
                    h.Parent=State.t
                    a=Instance.new("Attachment")
                    a.Name="Attachment"
                    a.Parent=h
                    o1=Instance.new("ParticleEmitter")
                    o1.Name="backgroundv2"
                    o1.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o1.Brightness=4.0000000000
                    o1.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000))})
                    o1.Drag=0.0000000000
                    o1.EmissionDirection=Enum.NormalId.Top
                    o1.Enabled=true
                    o1.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o1.LightEmission=-1.0000000000
                    o1.LightInfluence=0.0000000000
                    o1.Orientation=Enum.ParticleOrientation.FacingCamera
                    o1.Rate=12.0000000000
                    o1.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o1.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o1.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,36.8868865967,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,36.8868865967,0.0000000000)})
                    o1.Speed=NumberRange.new(0.0147547573,0.0147547573)
                    o1.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o1.Texture="http://www.roblox.com/asset/?id=13510176991"
                    o1.TimeScale=1.0000000000
                    o1.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.5000000000,0.5437499881,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o1.ZOffset=0.0000000000
                    o1.Shape=Enum.ParticleEmitterShape.Box
                    o1.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o1.ShapePartial=1.0000000000
                    o1.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o1.LockedToPart=true
                    o1.VelocityInheritance=0.0000000000
                    o1.WindAffectsDrag=false
                    o1.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o1.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o1.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o1.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o1.FlipbookStartRandom=false
                    o1.Parent=a
                    o2=Instance.new("ParticleEmitter")
                    o2.Name="glow2"
                    o2.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o2.Brightness=1.0000000000
                    o2.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.2509804070,0.0000000000,1.0000000000)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2509804070,0.0000000000,1.0000000000))})
                    o2.Drag=0.0000000000
                    o2.EmissionDirection=Enum.NormalId.Top
                    o2.Enabled=true
                    o2.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o2.LightEmission=0.0000000000
                    o2.LightInfluence=0.0000000000
                    o2.Orientation=Enum.ParticleOrientation.FacingCamera
                    o2.Rate=12.0000000000
                    o2.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o2.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o2.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,55.6592254639,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,55.6592254639,0.0000000000)})
                    o2.Speed=NumberRange.new(0.0132792816,0.0132792816)
                    o2.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o2.Texture="rbxassetid://13816054573"
                    o2.TimeScale=1.0000000000
                    o2.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4820295870,0.3562499881,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o2.ZOffset=-0.0179999992
                    o2.Shape=Enum.ParticleEmitterShape.Box
                    o2.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o2.ShapePartial=1.0000000000
                    o2.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o2.LockedToPart=true
                    o2.VelocityInheritance=0.0000000000
                    o2.WindAffectsDrag=false
                    o2.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o2.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o2.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o2.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o2.FlipbookStartRandom=false
                    o2.Parent=a
                    o3=Instance.new("ParticleEmitter")
                    o3.Name="glow-top"
                    o3.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o3.Brightness=2.0000000000
                    o3.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.2745098174,0.1450980455,1.0000000000)),ColorSequenceKeypoint.new(0.7266436219,Color3.new(0.2279666364,0.1204966456,0.8304498196)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000))})
                    o3.Drag=0.0000000000
                    o3.EmissionDirection=Enum.NormalId.Top
                    o3.Enabled=true
                    o3.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o3.LightEmission=1.0000000000
                    o3.LightInfluence=0.0000000000
                    o3.Orientation=Enum.ParticleOrientation.FacingCamera
                    o3.Rate=20.0000000000
                    o3.Rotation=NumberRange.new(180.0000000000,180.0000000000)
                    o3.RotSpeed=NumberRange.new(-15.0000000000,15.0000000000)
                    o3.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,33.9359474182,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,33.9359474182,0.0000000000)})
                    o3.Speed=NumberRange.new(0.0147547573,0.0147547573)
                    o3.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o3.Texture="http://www.roblox.com/asset/?id=13348444960"
                    o3.TimeScale=1.0000000000
                    o3.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.3868921697,0.4124999642,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o3.ZOffset=0.1400000006
                    o3.Shape=Enum.ParticleEmitterShape.Box
                    o3.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o3.ShapePartial=1.0000000000
                    o3.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o3.LockedToPart=true
                    o3.VelocityInheritance=0.0000000000
                    o3.WindAffectsDrag=false
                    o3.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o3.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o3.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o3.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o3.FlipbookStartRandom=false
                    o3.Parent=a
                    o4=Instance.new("ParticleEmitter")
                    o4.Name="glow2"
                    o4.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o4.Brightness=2.0000000000
                    o4.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.0901960805,0.0901960805,1.0000000000)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.0901960805,0.0901960805,1.0000000000))})
                    o4.Drag=0.0000000000
                    o4.EmissionDirection=Enum.NormalId.Top
                    o4.Enabled=true
                    o4.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o4.LightEmission=0.0000000000
                    o4.LightInfluence=0.0000000000
                    o4.Orientation=Enum.ParticleOrientation.FacingCamera
                    o4.Rate=7.0000000000
                    o4.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o4.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o4.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,40.4794425964,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,40.4794425964,0.0000000000)})
                    o4.Speed=NumberRange.new(0.0050599296,0.0050599296)
                    o4.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4180760980,-0.0828731060,0.1657457352),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o4.Texture="rbxassetid://12160798454"
                    o4.TimeScale=1.0000000000
                    o4.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4312896430,0.5312500000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o4.ZOffset=-0.0099999998
                    o4.Shape=Enum.ParticleEmitterShape.Box
                    o4.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o4.ShapePartial=1.0000000000
                    o4.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o4.LockedToPart=true
                    o4.VelocityInheritance=0.0000000000
                    o4.WindAffectsDrag=false
                    o4.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o4.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o4.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o4.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o4.FlipbookStartRandom=false
                    o4.Parent=a
                    o5=Instance.new("ParticleEmitter")
                    o5.Name="glow"
                    o5.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o5.Brightness=5.0000000000
                    o5.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.4826989770,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o5.Drag=0.0000000000
                    o5.EmissionDirection=Enum.NormalId.Top
                    o5.Enabled=true
                    o5.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o5.LightEmission=0.0000000000
                    o5.LightInfluence=0.0000000000
                    o5.Orientation=Enum.ParticleOrientation.FacingCamera
                    o5.Rate=12.0000000000
                    o5.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o5.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o5.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,42.5034027100,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,42.5034027100,0.0000000000)})
                    o5.Speed=NumberRange.new(0.0060719149,0.0060719149)
                    o5.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4180760980,-0.0828731060,0.1657457352),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o5.Texture="rbxassetid://12160798454"
                    o5.TimeScale=1.0000000000
                    o5.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4312896430,0.5312500000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o5.ZOffset=-0.0120000001
                    o5.Shape=Enum.ParticleEmitterShape.Box
                    o5.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o5.ShapePartial=1.0000000000
                    o5.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o5.LockedToPart=true
                    o5.VelocityInheritance=0.0000000000
                    o5.WindAffectsDrag=false
                    o5.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o5.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o5.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o5.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o5.FlipbookStartRandom=false
                    o5.Parent=a
                    o6=Instance.new("ParticleEmitter")
                    o6.Name="inwards"
                    o6.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o6.Brightness=4.0000000000
                    o6.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000))})
                    o6.Drag=0.0000000000
                    o6.EmissionDirection=Enum.NormalId.Top
                    o6.Enabled=true
                    o6.Lifetime=NumberRange.new(0.2549999952,0.7549999952)
                    o6.LightEmission=-3.0000000000
                    o6.LightInfluence=0.0000000000
                    o6.Orientation=Enum.ParticleOrientation.FacingCamera
                    o6.Rate=45.0000000000
                    o6.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o6.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o6.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,133.0338439941,0.0000000000),NumberSequenceKeypoint.new(0.1000000015,89.7938766479,0.0000000000),NumberSequenceKeypoint.new(0.2000000030,70.5835571289,0.0000000000),NumberSequenceKeypoint.new(0.3000000119,55.6024703979,0.0000000000),NumberSequenceKeypoint.new(0.4000000060,42.9930801392,0.0000000000),NumberSequenceKeypoint.new(0.5000000000,32.0751457214,0.0000000000),NumberSequenceKeypoint.new(0.6000000238,22.5535526276,0.0000000000),NumberSequenceKeypoint.new(0.6999999881,14.3329668045,0.0000000000),NumberSequenceKeypoint.new(0.8000000119,7.4870767593,0.0000000000),NumberSequenceKeypoint.new(0.8999999762,2.3486688137,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o6.Speed=NumberRange.new(0.0088689234,0.0088689234)
                    o6.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,1.4254140854),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o6.Texture="http://www.roblox.com/asset/?id=13553035458"
                    o6.TimeScale=1.0000000000
                    o6.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.1199788600,0.9562500119,0.0000000000),NumberSequenceKeypoint.new(0.1839323491,0.9312499762,0.0000000000),NumberSequenceKeypoint.new(0.2288583517,0.9312499762,0.0000000000),NumberSequenceKeypoint.new(0.3218815923,0.9499999881,0.0000000000),NumberSequenceKeypoint.new(0.4260042310,0.9125000238,0.0000000000),NumberSequenceKeypoint.new(0.5042282939,0.9312499762,0.0000000000),NumberSequenceKeypoint.new(0.5766384602,0.7124999762,0.0000000000),NumberSequenceKeypoint.new(0.6479915380,0.2749999762,0.0000000000),NumberSequenceKeypoint.new(0.7262156606,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o6.ZOffset=0.0000000000
                    o6.Shape=Enum.ParticleEmitterShape.Box
                    o6.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o6.ShapePartial=1.0000000000
                    o6.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o6.LockedToPart=true
                    o6.VelocityInheritance=0.0000000000
                    o6.WindAffectsDrag=false
                    o6.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o6.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o6.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o6.FlipbookMode=Enum.ParticleFlipbookMode.OneShot
                    o6.FlipbookStartRandom=false
                    o6.Parent=a
                    o7=Instance.new("ParticleEmitter")
                    o7.Name="Specs"
                    o7.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o7.Brightness=15.0000000000
                    o7.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.2785467207,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o7.Drag=5.0000000000
                    o7.EmissionDirection=Enum.NormalId.Top
                    o7.Enabled=true
                    o7.Lifetime=NumberRange.new(0.3000000119,0.6999999881)
                    o7.LightEmission=1.0000000000
                    o7.LightInfluence=0.0000000000
                    o7.Orientation=Enum.ParticleOrientation.VelocityPerpendicular
                    o7.Rate=65.0000000000
                    o7.Rotation=NumberRange.new(0.0000000000,0.0000000000)
                    o7.RotSpeed=NumberRange.new(25.0000000000,450.0000000000)
                    o7.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,72.7704391479,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o7.Speed=NumberRange.new(0.0059019015,0.0059019015)
                    o7.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.1000000015,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.1000000015,0.0000000000)})
                    o7.Texture="rbxassetid://14962423612"
                    o7.TimeScale=1.0000000000
                    o7.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.1802325547,0.7562500238,0.0592814013),NumberSequenceKeypoint.new(0.2510570884,0.3249999881,0.0743978024),NumberSequenceKeypoint.new(0.4019230008,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o7.ZOffset=-0.0060000001
                    o7.Shape=Enum.ParticleEmitterShape.Box
                    o7.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o7.ShapePartial=1.0000000000
                    o7.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o7.LockedToPart=true
                    o7.VelocityInheritance=0.0000000000
                    o7.WindAffectsDrag=false
                    o7.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o7.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o7.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o7.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o7.FlipbookStartRandom=false
                    o7.Parent=a
                    o8=Instance.new("ParticleEmitter")
                    o8.Name="glow2"
                    o8.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o8.Brightness=6.0000000000
                    o8.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1539792418,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.6193771958,Color3.new(0.1865030676,0.1505593657,0.6821364164)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o8.Drag=0.0000000000
                    o8.EmissionDirection=Enum.NormalId.Top
                    o8.Enabled=true
                    o8.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o8.LightEmission=1.0000000000
                    o8.LightInfluence=0.0000000000
                    o8.Orientation=Enum.ParticleOrientation.FacingCamera
                    o8.Rate=12.0000000000
                    o8.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o8.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o8.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,60.7191543579,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o8.Speed=NumberRange.new(0.0159351360,0.0159351360)
                    o8.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o8.Texture="rbxassetid://13816054573"
                    o8.TimeScale=1.0000000000
                    o8.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4397462904,0.5812499523,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o8.ZOffset=10.0000000000
                    o8.Shape=Enum.ParticleEmitterShape.Box
                    o8.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o8.ShapePartial=1.0000000000
                    o8.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o8.LockedToPart=true
                    o8.VelocityInheritance=0.0000000000
                    o8.WindAffectsDrag=false
                    o8.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o8.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o8.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o8.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o8.FlipbookStartRandom=false
                    o8.Parent=a
                    o9=Instance.new("ParticleEmitter")
                    o9.Name="Effect2"
                    o9.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o9.Brightness=5.0000000000
                    o9.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1816609055,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.8200692534,Color3.new(0.1867512316,0.1574016511,0.6843344569)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o9.Drag=0.0000000000
                    o9.EmissionDirection=Enum.NormalId.Front
                    o9.Enabled=true
                    o9.Lifetime=NumberRange.new(0.2000000030,0.6999999881)
                    o9.LightEmission=1.0000000000
                    o9.LightInfluence=0.0000000000
                    o9.Orientation=Enum.ParticleOrientation.FacingCamera
                    o9.Rate=12.0000000000
                    o9.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o9.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o9.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,44.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,44.0000000000,0.0000000000)})
                    o9.Speed=NumberRange.new(0.0117944535,0.0117944535)
                    o9.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o9.Texture="rbxassetid://13604373157"
                    o9.TimeScale=1.0000000000
                    o9.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o9.ZOffset=5.0000000000
                    o9.Shape=Enum.ParticleEmitterShape.Box
                    o9.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o9.ShapePartial=1.0000000000
                    o9.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o9.LockedToPart=true
                    o9.VelocityInheritance=0.0000000000
                    o9.WindAffectsDrag=false
                    o9.FlipbookFramerate=NumberRange.new(60.0000000000,60.0000000000)
                    o9.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o9.FlipbookLayout=Enum.ParticleFlipbookLayout.Grid4x4
                    o9.FlipbookMode=Enum.ParticleFlipbookMode.OneShot
                    o9.FlipbookStartRandom=false
                    o9.Parent=a
                    o10=Instance.new("ParticleEmitter")
                    o10.Name="Twirl"
                    o10.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o10.Brightness=25.0000000000
                    o10.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1955017298,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.8391003609,Color3.new(0.1647058874,0.2509804070,0.8666666746)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o10.Drag=0.0000000000
                    o10.EmissionDirection=Enum.NormalId.Top
                    o10.Enabled=true
                    o10.Lifetime=NumberRange.new(0.3000000119,0.8500000238)
                    o10.LightEmission=-2.0000000000
                    o10.LightInfluence=0.0000000000
                    o10.Orientation=Enum.ParticleOrientation.VelocityPerpendicular
                    o10.Rate=35.0000000000
                    o10.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o10.RotSpeed=NumberRange.new(-1100.0000000000,-800.0000000000)
                    o10.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,55.5358161926,8.5431823730),NumberSequenceKeypoint.new(0.3858350813,39.0972137451,13.3130493164),NumberSequenceKeypoint.new(0.8430232406,4.4428691864,4.4428691864),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o10.Speed=NumberRange.new(0.1057970598,0.1057970598)
                    o10.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o10.Texture="rbxassetid://15046927620"
                    o10.TimeScale=1.0000000000
                    o10.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.1929175407,0.6812499762,0.0000000000),NumberSequenceKeypoint.new(0.3451374173,0.2624999881,0.0625000000),NumberSequenceKeypoint.new(0.5132135153,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.8052150011,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o10.ZOffset=-0.0099999998
                    o10.Shape=Enum.ParticleEmitterShape.Box
                    o10.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o10.ShapePartial=1.0000000000
                    o10.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o10.LockedToPart=true
                    o10.VelocityInheritance=0.0000000000
                    o10.WindAffectsDrag=false
                    o10.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o10.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o10.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o10.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o10.FlipbookStartRandom=false
                    o10.Parent=a
                    o11=Instance.new("ParticleEmitter")
                    o11.Name="Stars"
                    o11.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o11.Brightness=25.0000000000
                    o11.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1799308062,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.7975778580,Color3.new(0.1864565313,0.1492760777,0.6817241907)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o11.Drag=6.0000000000
                    o11.EmissionDirection=Enum.NormalId.Top
                    o11.Enabled=true
                    o11.Lifetime=NumberRange.new(0.2000000030,1.0000000000)
                    o11.LightEmission=-2.0000000000
                    o11.LightInfluence=0.0000000000
                    o11.Orientation=Enum.ParticleOrientation.FacingCamera
                    o11.Rate=20.0000000000
                    o11.Rotation=NumberRange.new(0.0000000000,0.0000000000)
                    o11.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o11.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.0556701049,1.6755309105,0.0860593840),NumberSequenceKeypoint.new(0.1195876300,2.0944130421,0.1693689227),NumberSequenceKeypoint.new(0.1818181723,7.2196402550,0.2971437573),NumberSequenceKeypoint.new(0.2484939694,4.0871171951,0.2971437573),NumberSequenceKeypoint.new(0.3000000119,0.6439038515,0.2971437573),NumberSequenceKeypoint.new(0.4000000060,0.7370157838,0.2971437573),NumberSequenceKeypoint.new(0.4508456588,15.4878044128,0.0000000000),NumberSequenceKeypoint.new(0.5271084309,3.9686501026,0.2680529356),NumberSequenceKeypoint.new(0.5481927395,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.5783132315,2.4285757542,0.2558956146),NumberSequenceKeypoint.new(0.6566998959,0.5571449995,0.2372846901),NumberSequenceKeypoint.new(0.7409638166,3.4355466366,0.1965764612),NumberSequenceKeypoint.new(0.7996987700,2.4878096581,0.1857138574),NumberSequenceKeypoint.new(0.8237951398,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.8780120015,1.5400729179,0.1131039187),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o11.Speed=NumberRange.new(70.0000000000,130.0000000000)
                    o11.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,-0.3000000119,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,-0.3000000119,0.0000000000)})
                    o11.Texture="rbxassetid://13863941502"
                    o11.TimeScale=1.0000000000
                    o11.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o11.ZOffset=8.0000000000
                    o11.Shape=Enum.ParticleEmitterShape.Box
                    o11.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o11.ShapePartial=1.0000000000
                    o11.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o11.LockedToPart=false
                    o11.VelocityInheritance=0.0000000000
                    o11.WindAffectsDrag=false
                    o11.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o11.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o11.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o11.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o11.FlipbookStartRandom=false
                    o11.Parent=a
                    o12=Instance.new("ParticleEmitter")
                    o12.Name="Effect"
                    o12.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o12.Brightness=15.0000000000
                    o12.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1228373721,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.6851211190,Color3.new(0.1647058874,0.2509804070,0.8666666746)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o12.Drag=0.0000000000
                    o12.EmissionDirection=Enum.NormalId.Front
                    o12.Enabled=true
                    o12.Lifetime=NumberRange.new(0.6000000238,1.0000000000)
                    o12.LightEmission=-2.0000000000
                    o12.LightInfluence=0.0000000000
                    o12.Orientation=Enum.ParticleOrientation.VelocityPerpendicular
                    o12.Rate=8.0000000000
                    o12.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o12.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o12.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,50.5992965698,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,50.5992965698,0.0000000000)})
                    o12.Speed=NumberRange.new(0.0117944535,0.0117944535)
                    o12.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o12.Texture="rbxassetid://14926180777"
                    o12.TimeScale=1.0000000000
                    o12.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o12.ZOffset=5.0000000000
                    o12.Shape=Enum.ParticleEmitterShape.Box
                    o12.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o12.ShapePartial=1.0000000000
                    o12.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o12.LockedToPart=true
                    o12.VelocityInheritance=0.0000000000
                    o12.WindAffectsDrag=false
                    o12.FlipbookFramerate=NumberRange.new(60.0000000000,60.0000000000)
                    o12.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o12.FlipbookLayout=Enum.ParticleFlipbookLayout.Grid8x8
                    o12.FlipbookMode=Enum.ParticleFlipbookMode.OneShot
                    o12.FlipbookStartRandom=false
                    o12.Parent=a
                    o13=Instance.new("ParticleEmitter")
                    o13.Name="outline"
                    o13.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o13.Brightness=3.0000000000
                    o13.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.1332179904,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(0.7698962092,Color3.new(0.1866697967,0.1551563740,0.6836131811)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o13.Drag=0.0000000000
                    o13.EmissionDirection=Enum.NormalId.Top
                    o13.Enabled=true
                    o13.Lifetime=NumberRange.new(1.0000000000,1.0000000000)
                    o13.LightEmission=1.0000000000
                    o13.LightInfluence=0.0000000000
                    o13.Orientation=Enum.ParticleOrientation.FacingCamera
                    o13.Rate=5.0000000000
                    o13.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o13.RotSpeed=NumberRange.new(360.0000000000,360.0000000000)
                    o13.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,36.4314918518,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,36.4314918518,0.0000000000)})
                    o13.Speed=NumberRange.new(0.0050599296,0.0050599296)
                    o13.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o13.Texture="rbxassetid://12993596362"
                    o13.TimeScale=1.0000000000
                    o13.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4492600262,0.3249999881,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o13.ZOffset=2.0000000000
                    o13.Shape=Enum.ParticleEmitterShape.Box
                    o13.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o13.ShapePartial=1.0000000000
                    o13.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o13.LockedToPart=true
                    o13.VelocityInheritance=0.0000000000
                    o13.WindAffectsDrag=false
                    o13.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o13.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o13.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o13.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o13.FlipbookStartRandom=false
                    o13.Parent=a
                    o14=Instance.new("ParticleEmitter")
                    o14.Name="softwings"
                    o14.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o14.Brightness=3.0000000000
                    o14.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(1.0000000000,0.2235294133,0.6627451181)),ColorSequenceKeypoint.new(0.2785467207,Color3.new(0.1843137294,0.0901960805,0.6627451181)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.2117647082,0.8470588326,0.9058823586))})
                    o14.Drag=0.0000000000
                    o14.EmissionDirection=Enum.NormalId.Top
                    o14.Enabled=true
                    o14.Lifetime=NumberRange.new(1.0000000000,1.2500000000)
                    o14.LightEmission=1.0000000000
                    o14.LightInfluence=0.0000000000
                    o14.Orientation=Enum.ParticleOrientation.FacingCamera
                    o14.Rate=12.0000000000
                    o14.Rotation=NumberRange.new(-360.0000000000,360.0000000000)
                    o14.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o14.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,60.7191543579,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,60.7191543579,0.0000000000)})
                    o14.Speed=NumberRange.new(0.0040479442,0.0040479442)
                    o14.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o14.Texture="rbxassetid://13393479327"
                    o14.TimeScale=1.0000000000
                    o14.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.4423890114,0.3874999881,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o14.ZOffset=22.0000000000
                    o14.Shape=Enum.ParticleEmitterShape.Box
                    o14.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o14.ShapePartial=1.0000000000
                    o14.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o14.LockedToPart=true
                    o14.VelocityInheritance=0.0000000000
                    o14.WindAffectsDrag=false
                    o14.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o14.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o14.FlipbookLayout=Enum.ParticleFlipbookLayout.Grid4x4
                    o14.FlipbookMode=Enum.ParticleFlipbookMode.OneShot
                    o14.FlipbookStartRandom=true
                    o14.Parent=a
                    o15=Instance.new("ParticleEmitter")
                    o15.Name="warp"
                    o15.Acceleration=Vector3.new(0.0000000000,0.0000000000,0.0000000000)
                    o15.Brightness=4.0000000000
                    o15.Color=ColorSequence.new({ColorSequenceKeypoint.new(0.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000)),ColorSequenceKeypoint.new(1.0000000000,Color3.new(0.0000000000,0.0000000000,0.0000000000))})
                    o15.Drag=0.0000000000
                    o15.EmissionDirection=Enum.NormalId.Top
                    o15.Enabled=true
                    o15.Lifetime=NumberRange.new(0.5000000000,0.5000000000)
                    o15.LightEmission=-0.5000000000
                    o15.LightInfluence=0.0099999998
                    o15.Orientation=Enum.ParticleOrientation.FacingCamera
                    o15.Rate=5.0000000000
                    o15.Rotation=NumberRange.new(0.0000000000,0.0000000000)
                    o15.RotSpeed=NumberRange.new(0.0000000000,0.0000000000)
                    o15.Size=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,111.3184509277,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,111.3184509277,0.0000000000)})
                    o15.Speed=NumberRange.new(0.0040479442,0.0040479442)
                    o15.Squash=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,0.0000000000,0.0000000000)})
                    o15.Texture="rbxassetid://13615428374"
                    o15.TimeScale=1.0000000000
                    o15.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0.0000000000,1.0000000000,0.0000000000),NumberSequenceKeypoint.new(0.5000000000,0.0000000000,0.0000000000),NumberSequenceKeypoint.new(1.0000000000,1.0000000000,0.0000000000)})
                    o15.ZOffset=0.0000000000
                    o15.Shape=Enum.ParticleEmitterShape.Box
                    o15.ShapeInOut=Enum.ParticleEmitterShapeInOut.Outward
                    o15.ShapePartial=1.0000000000
                    o15.ShapeStyle=Enum.ParticleEmitterShapeStyle.Volume
                    o15.LockedToPart=true
                    o15.VelocityInheritance=0.0000000000
                    o15.WindAffectsDrag=false
                    o15.FlipbookFramerate=NumberRange.new(1.0000000000,1.0000000000)
                    o15.FlipbookIncompatible="Particle texture must be 1024 by 1024 to use flipbooks."
                    o15.FlipbookLayout=Enum.ParticleFlipbookLayout.None
                    o15.FlipbookMode=Enum.ParticleFlipbookMode.Loop
                    o15.FlipbookStartRandom=false
                    o15.Parent=a
                    for _, o in pairs(a:GetDescendants())do
                    if o:IsA("ParticleEmitter")then
                    k={}
                    for _, p in pairs(o.Size.Keypoints)do
                    table.insert(k,NumberSequenceKeypoint.new(p.Time,p.Value/s,p.Envelope/s))
                    end
                    o.Size=NumberSequence.new(k)
                    o.Speed=NumberRange.new(o.Speed.Min/s,o.Speed.Max/s)
                    o.Acceleration=o.Acceleration/s
                    o.Drag=o.Drag/s
                    end
                    if o:IsA("Beam")then
                    o.Width0=o.Width0/s
                    o.Width1=o.Width1/s
                    end
                    if o:IsA("Trail")then
                    k={}
                    for _, p in pairs(o.WidthScale.Keypoints)do
                    table.insert(k,NumberSequenceKeypoint.new(p.Time,p.Value/s,p.Envelope/s))
                    end
                    o.WidthScale=NumberSequence.new(k)
                    end
                    if o:IsA("Attachment")then
                    o.Position=o.Position/s
                    end
                    end
                    State.t.Parent=b
                    
                    State.mouse = player:GetMouse()

                    local function findVisibleTarget(origin, direction)
                        local character = player.Character
                        if not character then return origin + direction * 1000 end
                        
                        State.rayParams = RaycastParams.new()
                        State.rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                        State.rayParams.FilterDescendantsInstances = {character}
                        State.rayParams.IgnoreWater = true
                        
                        State.maxDistance = 1000
                        State.currentPos = origin
                        State.remainingDistance = State.maxDistance
                        
                        while State.remainingDistance > 0 do
                            local result = workspace:Raycast(State.currentPos, direction * State.remainingDistance, State.rayParams)
                            
                            if result then
                                if result.Instance.Transparency < 1 then
                                    return result.Position
                                else
                                    State.currentPos = result.Position + direction * 0.1
                                    State.remainingDistance = State.maxDistance - (result.Position - origin).Magnitude
                                    
                                    local filterList = State.rayParams.FilterDescendantsInstances
                                    table.insert(filterList, result.Instance)
                                    State.rayParams.FilterDescendantsInstances = filterList
                                end
                            else
                                break
                            end
                        end
                        
                        return origin + direction * State.maxDistance
                    end

                    local function createPurpleFlash(position)
                        if not State.tool then
                            State.tool = player.Backpack:FindFirstChild("TeleportTool") or (player.Character and player.Character:FindFirstChild("TeleportTool"))
                        end
                        if not State.tool then return end
                        if not State.handle then
                            State.handle = State.tool:FindFirstChild("Handle")
                        end
                        if not State.handle then return end
                        State.flash = State.handle:Clone()
                        State.flash.Anchored = true
                        State.flash.CanCollide = false
                        State.flash.Massless = true
                        State.flash.Transparency = 1
                        State.flash.Size = State.handle.Size
                        State.flash.CFrame = CFrame.new(position + Vector3.new(0, 3, 0))
                        State.flash.Parent = workspace
                        State.originalSize = State.flash.Size
                        State.originalDescendantData = {}
                        for _, desc in ipairs(State.flash:GetDescendants()) do
                            if desc:IsA("Attachment") then
                                State.originalDescendantData[desc] = {Position = desc.Position}
                            elseif desc:IsA("ParticleEmitter") then
                                State.originalDescendantData[desc] = {
                                    Size = desc.Size, Speed = desc.Speed, Acceleration = desc.Acceleration, Drag = desc.Drag
                                }
                            elseif desc:IsA("Beam") then
                                State.originalDescendantData[desc] = {Width0 = desc.Width0, Width1 = desc.Width1}
                            elseif desc:IsA("Trail") then
                                State.originalDescendantData[desc] = {WidthScale = desc.WidthScale}
                            end
                        end
                        State.duration = 2
                        State.steps = 40
                        Debris:AddItem(State.flash, State.duration + 0.2)
                        task.spawn(function()
                            for i = 0, State.steps do
                                if not State.flash.Parent then return end
                                State.alpha = i / State.steps
                                State.scale = 1 + 4 * State.alpha
                                State.flash.Size = State.originalSize * State.scale
                                for desc, orig in pairs(State.originalDescendantData) do
                                    if desc:IsA("Attachment") then
                                        desc.Position = orig.Position * State.scale
                                    elseif desc:IsA("ParticleEmitter") then
                                        local newKeypoints = {}
                                        for _, kp in ipairs(orig.Size.Keypoints) do
                                            table.insert(newKeypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * State.scale, kp.Envelope * State.scale))
                                        end
                                        desc.Size = NumberSequence.new(newKeypoints)
                                        desc.Speed = NumberRange.new(orig.Speed.Min * State.scale, orig.Speed.Max * State.scale)
                                        desc.Acceleration = orig.Acceleration * State.scale
                                        desc.Drag = orig.Drag * State.scale
                                        desc.Enabled = true
                                    elseif desc:IsA("Beam") then
                                        desc.Width0 = orig.Width0 * State.scale
                                        desc.Width1 = orig.Width1 * State.scale
                                    elseif desc:IsA("Trail") then
                                        local newKeypoints = {}
                                        for _, kp in ipairs(orig.WidthScale.Keypoints) do
                                            table.insert(newKeypoints, NumberSequenceKeypoint.new(kp.Time, kp.Value * State.scale, kp.Envelope * State.scale))
                                        end
                                        desc.WidthScale = NumberSequence.new(newKeypoints)
                                    end
                                end
                                task.wait(State.duration / State.steps)
                            end
                            if State.flash and State.flash.Parent then
                                State.flash:Destroy()
                            end
                        end)
                    end
                    State.t.Activated:Connect(function()
                        local character = player.Character
                        if not character then return end
                        
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end

                        local origin = State.mouse.UnitRay.Origin
                        local direction = (State.mouse.Hit.Position - origin).Unit
                        
                        State.targetPos = findVisibleTarget(origin, direction)
                        
                        createPurpleFlash(hrp.Position)
                        hrp.CFrame = CFrame.new(State.targetPos + Vector3.new(0, 3, 0))
                        createPurpleFlash(State.targetPos)
                        
                        State.sound = Instance.new("Sound")
                        State.sound.SoundId = "rbxassetid://3398620867"
                        State.sound.Volume = 0.5
                        State.sound.Parent = hrp
                        State.sound:Play()
                        game:GetService("Debris"):AddItem(State.sound, 2)
                    end)

                    State.t.Parent = player.Backpack
                    
                    Library:Notify({
                        Title = "Teleporter", Content = "Teleporter tool added to your inventory!", Duration = 3
                    })
                end
            })

            State.PublicServerSection = State.Tabs.Rejoin:AddSection("Public Server")

            State.publicDelayInput = State.PublicServerSection:AddInput("PublicRejoinDelay", {
                Title = "Delay (Seconds)", Default = "3600", Numeric = true,
            })

            State.AutoRejoinPublicToggle = State.PublicServerSection:Toggle("AutoRejoinPublic", {
                Title = "Auto Rejoin", Description = "Automatically rejoins a public server with the least players after the delay.", Default = false, Callback = function(enabled)
                    _G.AutoRejoinPublicEnabled = enabled
                    if _G.AutoRejoinPublicThread then
                        task.cancel(_G.AutoRejoinPublicThread)
                        _G.AutoRejoinPublicThread = nil
                    end
                    if enabled then
                        _G.AutoRejoinPublicThread = task.spawn(function()
                            while _G.AutoRejoinPublicEnabled do
                                local delay = tonumber(State.publicDelayInput.Value) or 10
                                task.wait(delay)
                                 
                                local cursor = ""
                                local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
                                local servers = {}
                                while true do
                                    local reqUrl = url .. (cursor ~= "" and ("&cursor=" .. cursor) or "")
                                    success, State.response = pcall(function()
                                        return HttpService:JSONDecode(game:HttpGet(reqUrl))
                                    end)
                                    if not success or not State.response or not State.response.data then break end
                                    for _, server in ipairs(State.response.data) do
                                        if server.playing < server.maxPlayers then
                                            table.insert(servers, server)
                                        end
                                    end
                                    if not State.response.nextPageCursor then break end
                                    cursor = State.response.nextPageCursor
                                end
                                table.sort(servers, function(a, b) return a.playing < b.playing end)
                                for _, server in ipairs(servers) do
                                    if server.id ~= game.JobId then
                                        TeleportService:TeleportToPlaceInstance(placeId, server.id, Players.LocalPlayer)
                                        break
                                    end
                                end
                                task.wait(2)
                            end
                        end)
                    end
                end
            })

            State.PrivateServerSection = State.Tabs.Rejoin:AddSection("Private Server")

            State.PrivateServerSection:Paragraph("PrivateServerInfo", {
                Title = "How to Get Private Server ID", Content = "To join a private server, copy the Roblox invite link and paste the ID below.\nExample: https://www.roblox.com/share?code=12345&type=Server\nThe ID is: 12345\nEnter 12345 in the 'Private Server ID' input. Or if your lazy, just paste the whole link in the input."
            })

            State.privateServerIdInput = State.PrivateServerSection:AddInput("PrivateServerID", {
                Title = "Private Server ID", Default = "", Description = "Paste the private server ID here."
            })

            State.privateDelayInput = State.PrivateServerSection:AddInput("PrivateRejoinDelay", {
                Title = "Rejoin Delay (Seconds)", Default = "3600", Numeric = true,
            })

            local function extractPrivateServerId(input)
                local code = tostring(input)
                State.match = code:match("code=([%w]+)")
                if State.match then
                    return State.match
                end
                return code
            end

            State.AutoRejoinPrivateToggle = State.PrivateServerSection:Toggle("AutoRejoinPrivate", {
                Title = "Auto Rejoin", Description = "Automatically rejoins the private server after the delay.", Default = false, Callback = function(enabled)
                    _G.AutoRejoinPrivateEnabled = enabled
                    if _G.AutoRejoinPrivateThread then
                        task.cancel(_G.AutoRejoinPrivateThread)
                        _G.AutoRejoinPrivateThread = nil
                    end
                    if enabled then
                        _G.AutoRejoinPrivateThread = task.spawn(function()
                            while _G.AutoRejoinPrivateEnabled do
                                local delay = tonumber(State.privateDelayInput.Value) or 10
                                local rawInput = tostring(State.privateServerIdInput.Value)
                                local accessCode = extractPrivateServerId(rawInput)
                                task.wait(delay)
                                if accessCode ~= "" then
                                    local teleportOptions = Instance.new("TeleportOptions")
                                    teleportOptions.ReservedServerAccessCode = accessCode
                                    TeleportService:Teleport(game.PlaceId, Players.LocalPlayer, teleportOptions)
                                end
                                task.wait(2)
                            end
                        end)
                    end
                end
            })

            State.luckyBlockNames = {}

            for _, block in ipairs(LuckyBlockConfig.LuckyBlocks) do
                table.insert(State.luckyBlockNames, block.name)
            end

            State.LuckyBlocksSection = State.Tabs.Misc:AddSection("Lucky Blocks")

            State.placedBlocksParagraph = State.LuckyBlocksSection:AddParagraph("PlacedBlocks", {
                Title = "Placed Lucky Blocks", Content = "Loading..."
            })

            State.selectedAutoPlaceBlocks = {}
            State.autoPlaceEnabled = false
            State.autoPlaceThread = nil
            State.autoClaimEnabled = false
            State.autoClaimThread = nil
            State.isClaimingBlock = false 

            local function updatePlacedBlocksDisplay()
                if not placedFolder then
                    State.placedBlocksParagraph:SetContent("No lucky blocks placed")
                    return
                end
                
                State.blockInfo = {}
                
                for _, block in ipairs(placedFolder:GetChildren()) do
                    if block:IsA("Model") then
                        local ownerId = block:GetAttribute("OwnerId")
                        
                        if ownerId == State.LocalPlayer.UserId then
                            local blockName = block:GetAttribute("BlockName") or "Unknown"
                            
                            local blockModel = block:FindFirstChild("LuckyBlockModel")
                            local timeText = "Unknown"
                            
                            if blockModel and blockModel.PrimaryPart then
                                local billboard = blockModel.PrimaryPart:FindFirstChild("LuckyblockBillboard")
                                if billboard then
                                    local timeLabel = billboard:FindFirstChild("Time")
                                    if timeLabel then
                                        timeText = timeLabel.Text
                                    end
                                end
                            end
                            
                            table.insert(State.blockInfo, {
                                name = blockName, time = timeText
                            })
                        end
                    end
                end
                
                if #State.blockInfo == 0 then
                    State.placedBlocksParagraph:SetContent("No lucky blocks placed")
                    return
                end
                
                local content = ""
                for i, info in ipairs(State.blockInfo) do
                    content = content .. string.format("%d. %s - %s\n", i, info.name, info.time)
                end
                
                State.placedBlocksParagraph:SetContent(content)
            end

            task.spawn(function()
                while true do
                    updatePlacedBlocksDisplay()
                    task.wait(10)
                end
            end)

            State.AutoPlaceDropdown = State.LuckyBlocksSection:AddDropdown("AutoPlaceDropdown", {
                Title = "Select Blocks to Auto Place", Values = State.luckyBlockNames, Multi = true, Default = {}, Callback = function(Value)
                    State.selectedAutoPlaceBlocks = Value
                end
            })

            State.LuckyBlocksSection:AddToggle("AutoPlace",{Title="Auto Place",Default=false,Callback=function(Value)
                State.autoPlaceEnabled=Value
                if State.autoPlaceThread then task.cancel(State.autoPlaceThread) State.autoPlaceThread=nil end
                if Value then
                    State.autoPlaceThread=task.spawn(function()
                        repeat task.wait() until Rep.Loaded and Rep.Data
                        while State.autoPlaceEnabled do
                            if pFolder then
                                local count=0
                                for _, v in ipairs(pFolder:GetChildren()) do
                                    if v:IsA("Model") and v:GetAttribute("OwnerId")==LP.UserId then count=count+1 end
                                end
                                State.need=3-count
                                if State.need>0 then
                                    State.inv=Rep.Data.Inventory or Rep.Data.Items
                                    if State.inv then
                                        State.cMap={}
                                        for _, v in ipairs(Config.LuckyBlocks) do State.cMap[v.name]=v.cost end
                                        State.avail={}
                                        for n, a in pairs(State.inv) do
                                            if n:find("Lucky Block") and a>0 then table.insert(State.avail,{n=n,c=State.cMap[n]or 0}) end
                                        end
                                        if #State.avail>0 then
                                            table.sort(State.avail,function(a, b) return a.c>b.c end)
                                            State.high=State.avail[1].c
                                            State.cands={}
                                            for _, v in ipairs(State.avail) do if v.c==State.high then table.insert(State.cands,v.n) else break end end
                                            for i=1,State.need do
                                                if not State.autoPlaceEnabled then break end
                                                local name=State.cands[math.random(1,#State.cands)]
                                                local char=LP.Character
                                                if char and char:FindFirstChild("HumanoidRootPart") then
                                                    local hrp=char.HumanoidRootPart
                                                    State.pos=hrp.Position+(hrp.CFrame.LookVector*10)
                                                    pcall(function() Network:InvokeServer("PlaceWorldLuckyBlock",name,{X=State.pos.X,Y=State.pos.Y,Z=State.pos.Z}) end)
                                                end
                                                if i<State.need then task.wait(1) end
                                            end
                                        end
                                    end
                                end
                            end
                            task.wait(5)
                        end
                    end)
                end
            end})
            
            State.LuckyBlocksSection:AddToggle("AutoClaim", {
                Title = "Auto Claim", Default = false, Callback = function(Value)
                    State.autoClaimEnabled = Value
                    
                    if State.autoClaimThread then
                        task.cancel(State.autoClaimThread)
                        State.autoClaimThread = nil
                    end
                    
                    if Value then
                        State.autoClaimThread = task.spawn(function()
                            
                            while State.autoClaimEnabled do
                                if placedFolder then
                                    for _, block in ipairs(placedFolder:GetChildren()) do
                                        if not State.autoClaimEnabled then break end
                                        
                                        if block:IsA("Model") then
                                            local ownerId = block:GetAttribute("OwnerId")
                                            
                                            if ownerId == State.LocalPlayer.UserId then
                                                local blockModel = block:FindFirstChild("LuckyBlockModel")
                                                if blockModel and blockModel.PrimaryPart then
                                                    local billboard = blockModel.PrimaryPart:FindFirstChild("LuckyblockBillboard")
                                                    if billboard then
                                                        local timeLabel = billboard:FindFirstChild("Time")
                                                        if timeLabel then
                                                            local timeText = timeLabel.Text
                                                            if timeText == "READY!" or timeText == "00:00" or timeText == "0:00" then
                                                                State.blockId = block:GetAttribute("BlockId")
                                                                if State.blockId then
                                                                    State.isClaimingBlock = true
 
                                                                    local char = State.LocalPlayer.Character
                                                                    if char and char:FindFirstChild("HumanoidRootPart") then
                                                                        State.blockPosition = blockModel:GetPivot().Position
                                                                        local targetCFrame = CFrame.new(State.blockPosition + Vector3.new(0, 3, 0))
                                                                        char:PivotTo(targetCFrame)
                                                                    end
                                                                    
                                                                    task.wait(0.25)
                                                                    Network:InvokeServer("OpenWorldLuckyBlock", tostring(State.blockId))
                                                                    
                                                                    State.isClaimingBlock = false

                                                                    task.wait(0.5)
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                task.wait(5)
                            end

                            State.isClaimingBlock = false
                        end)
                    end
                end
            })

            ReplicatedStorage = game:GetService("ReplicatedStorage")
LocalPlayer = game:GetService("Players").LocalPlayer
PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local AutoClickSection = State.Tabs.Main:AddSection("Auto Click")

            local autoClickEnabled = false
            local Signal = require(game:GetService("ReplicatedStorage").Modules.Signal)

            AutoClickSection:AddToggle("AutoClick", {
                Title = "Auto Click (OP)",
                Default = false,
                Callback = function(Value)
                    autoClickEnabled = Value
                    if not Value then
                        cachedButton = nil
                        return
                    end

                    task.spawn(function()
                        local Network = require(ReplicatedStorage.Modules.Network)

                        local function getButton()
                            return LocalPlayer.PlayerGui
                                and LocalPlayer.PlayerGui:FindFirstChild("Game")
                                and LocalPlayer.PlayerGui.Game.Bottom.Tap:FindFirstChild("Button")
                        end

                        while autoClickEnabled do
                            pcall(function()
                                Network:FireServer("Tap", true)
                                Signal.Fire("Tap")
                            end)
                            task.wait()
                        end
                    end)
                end
            })

            State.originalStates = {}

            AutoClickSection:AddToggle("HideEffectsToggle", {
                Title = "Hide Tap Popups and Mute Tap Sounds", Default = false, Callback = function(enabled)
                    State.popupModulePath = State.LocalPlayer.PlayerScripts.Modules.Controllers["UI Controller"].Popups
                    success, State.PopupsModule = pcall(require, State.popupModulePath)

                    if enabled then
                        State.soundsToMute = { ["Critical"]=true, ["Taps"]=true, ["Click"]=true, ["Click2"]=true, ["Shine"]=true, ["PopUp"]=true }
                        State.originalStates.sounds = {}
                        
                        for _, soundObject in ipairs(SoundService:GetDescendants()) do
                            if soundObject:IsA("Sound") and State.soundsToMute[soundObject.Name] then
                                State.originalStates.sounds[soundObject] = {
                                    volume = soundObject.Volume, connection = soundObject:GetPropertyChangedSignal("Volume"):Connect(function()
                                        if soundObject.Volume > 0 then soundObject.Volume = 0 end
                                    end)
                                }
                                soundObject.Volume = 0
                            end
                        end

                        if success and State.PopupsModule and not State.originalStates.Popup then
                            State.originalStates.Popup = State.PopupsModule.Popup
                            State.PopupsModule.Popup = function(self, popupType, ...)
                                if popupType == "tap" or popupType == "tapArea" or popupType == "critTapArea" then return end
                                return State.originalStates.Popup(self, popupType, ...)
                            end
                        end
                    else
                        if State.originalStates.sounds then
                            for soundObject, data in pairs(State.originalStates.sounds) do
                                if data.connection then data.connection:Disconnect() end
                                if soundObject and soundObject.Parent then
                                    soundObject.Volume = data.volume
                                end
                            end
                            State.originalStates.sounds = nil
                        end

                        if success and State.PopupsModule and State.originalStates.Popup then
                            State.PopupsModule.Popup = State.originalStates.Popup
                            State.originalStates.Popup = nil
                        end
                    end
                end
            })

            AutoClickSection:AddToggle("AutoRejoin", {
                Title = "Rejoin if Clicking Breaks", Description = "Rejoins a server if clicks stops working. Uses Auto-Rejoin settings (Private Server ID if set). MAKE SURE AUTO EXECUTE IS ON IN YOUR EXECUTOR!", Default = false, Callback = function(Value)
                    autoRejoinEnabled = Value
                    if autoRejoinThread then
                        task.cancel(autoRejoinThread)
                        autoRejoinThread = nil
                    end

                    if Value then
                        autoRejoinThread = task.spawn(function()
                            State.lastClicks = -1
                            State.sameCountTimer = 0
                            
                            while autoRejoinEnabled do
                                task.wait(1)
                                
                                if autoClickEnabled then
                                    local currentClicks = 0
                                    
                                    if Replication.Data and Replication.Data.Statistics then
                                        currentClicks = Replication.Data.Statistics.Clicks or 0
                                    end
                                    
                                    if currentClicks == State.lastClicks then
                                        State.sameCountTimer = State.sameCountTimer + 1
                                    else
                                        State.sameCountTimer = 0
                                        State.lastClicks = currentClicks
                                    end

                                    if State.sameCountTimer >= 5 then
                                        if State.privateServerIdInput and State.privateServerIdInput.Value ~= "" and extractPrivateServerId then
                                            local code = extractPrivateServerId(State.privateServerIdInput.Value)
                                            if code ~= "" then
                                                local teleportOptions = Instance.new("TeleportOptions")
                                                teleportOptions.ReservedServerAccessCode = code
                                                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer, teleportOptions)
                                            else
                                                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                                            end
                                        else
                                            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                                        end
                                        break
                                    end
                                end
                            end
                        end)
                    end
                end
            })

            State.RebirthSection = State.Tabs.Main:AddSection("Rebirths")

            State.selectedRebirthIndex = "Max Unlocked"
            State.rebirthOptions = {}
            State.isMaxUnlockedSelected = true
            State.useEventClickLogic = true
            State.currentZone = nil
            State.autoRebirthRunning = false
            State.autoRebirthThread = nil
            State.dropdownUpdateThread = nil
            State.zoneUpdateThread = nil

            local function formatSuffix(val)
                State.suffixes = {"", "k", "m", "b", "t", "qd", "qn", "sx", "sp", "oc"}
                local i = 1
                local num = val
                while num >= 1000 and i < #State.suffixes do
                    num = num / 1000
                    i = i + 1
                end
                if i == 1 then return tostring(val) end
                return string.format("%.1f%s", num, State.suffixes[i]):gsub("%.0", "")
            end

            local function formatCommas(val)
                State.str = tostring(val)
                return State.str:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
            end

            local function getAllRebirthOptions()
                State.options = {}
                pcall(function()
                    repeat task.wait() until Replication.Loaded and Replication.Data
                    State.maxOptions = Replication.Data.RebirthOptions or 0
                    for i = 1, State.maxOptions do
                        local amount = Rebirths:fromIndex(i)
                        if amount then
                            local price = Rebirths:getPrice(amount)
                            local displayStr
                            
                            if amount < 1000 then
                                displayStr = string.format("+%d Rebirths", amount)
                            else
                                local shortStr = formatSuffix(amount)
                                local fullStr = formatCommas(amount)
                                displayStr = string.format("+%s (%s) Rebirths", shortStr, fullStr)
                            end
                            
                            table.insert(State.options, {
                                index = i, amount = amount, price = price, display = displayStr
                            })
                        end
                    end
                end)
                return State.options
            end

            GetBestAffordableRebirth = function()
                local success, result = pcall(function()
                    repeat task.wait() until Replication.Loaded and Replication.Data
                    State.currentRebirths = Replication.Data.Statistics.Rebirths or 0
                    State.easterRebirths = Replication.Data.Statistics.EasterRebirths or 0
                    State.clicks = Replication.Data.Statistics.Clicks or 0
                    if State.useEventClickLogic and State.currentZone == "Easter" then
                        State.clicks = Replication.Data.Statistics.EasterClicks or 0
                        State.currentRebirths = State.easterRebirths
                    end
                    State.bestIndex = nil
                    State.bestAmount = 0
                    for _, option in ipairs(State.rebirthOptions) do
                        local clicksNeeded = Rebirths:ClicksPrice(option.price, State.currentRebirths)
                        if State.clicks >= clicksNeeded and option.amount > State.bestAmount then
                            State.bestAmount = option.amount
                            State.bestIndex = option.index
                        end
                    end
                    return State.bestIndex
                end)
                return success and result or nil
            end

            GetMaxUnlockedRebirth = function()
                local success, result = pcall(function()
                    repeat task.wait() until Replication.Loaded and Replication.Data
                    State.maxUnlocked = Replication.Data.RebirthOptions or 0
                    return State.maxUnlocked > 0 and State.maxUnlocked or nil
                end)
                return success and result or nil
            end

            updateRebirthDropdown = function()
                pcall(function()
                    State.options = getAllRebirthOptions() 
                    State.rebirthOptions = State.options
                    State.dropdownValues = {"Max Unlocked"}
                    for _, option in ipairs(State.options) do 
                        table.insert(State.dropdownValues, option.display) 
                    end
                    if State.rebirthDropdown then 
                        State.rebirthDropdown:SetValues(State.dropdownValues) 
                    end
                end)
            end

            performRebirth = function()
                if State.isMaxUnlockedSelected then
                    State.rebirthIndex = GetMaxUnlockedRebirth()
                elseif State.selectedRebirthIndex > 0 and State.selectedRebirthIndex <= #State.rebirthOptions then
                    State.rebirthIndex = State.rebirthOptions[State.selectedRebirthIndex].index
                end
                if State.rebirthIndex then
                    return pcall(function() Network:InvokeServer("Rebirth", State.rebirthIndex) end)
                end
                return false
            end

            State.rebirthDropdown = State.RebirthSection:Dropdown("RebirthDropdown", {
                Title = "Select Rebirth Amount", Values = {}, Searchable = true, Default = "Max Unlocked", Multi = false, Callback = function(selectedValue)
                    if selectedValue == "Max Unlocked" then
                        State.isMaxUnlockedSelected = true
                    else
                        State.isMaxUnlockedSelected = false
                        for i, option in ipairs(State.rebirthOptions) do
                            if option.display == selectedValue then 
                                State.selectedRebirthIndex = i
                                break 
                            end
                        end
                    end
                end
            })

            State.rebirthDelayInput = State.RebirthSection:AddInput("BestRebirthDelay", {
                Title = "Best Rebirth Delay (seconds)", Default = "", Numeric = true, Finished = false
            })

            State.AutoRebirth = State.RebirthSection:Toggle("AutoRebirth", {
                Title = "Auto Rebirth", Default = false
            })
        
            State.RebirthSection:Paragraph("RebirthInfo", {
            Title = "Rebirth Info", Content = "Max Unlocked = Always uses your highest unlocked rebirth.\nDelay Input = Rebirths with the BEST AFFORDABLE rebirth every X seconds (leave empty or 0 to disable this)", TitleAlignment = "Middle"
          })

            task.spawn(function()
                repeat task.wait() until Replication.Loaded and Replication.Data
                State.currentZone = Replication.Data.Zone
                pcall(updateRebirthDropdown)
            end)

            State.zoneUpdateThread = task.spawn(function()
                while true do
                    task.wait(5)
                    if Replication.Loaded and Replication.Data then
                        State.currentZone = Replication.Data.Zone
                    end
                end
            end)

            State.dropdownUpdateThread = task.spawn(function()
                while true do
                    task.wait(5)
                    pcall(updateRebirthDropdown)
                end
            end)

            State.AutoRebirth:OnChanged(function(Value)
                State.autoRebirthRunning = Value
                if State.autoRebirthThread then
                    task.cancel(State.autoRebirthThread)
                    State.autoRebirthThread = nil
                end
                if Value then
                    State.autoRebirthThread = task.spawn(function()
                        while State.autoRebirthRunning do
                            local delayValue = State.rebirthDelayInput.Value
                            local delay = tonumber(delayValue)
                            if delayValue ~= "" and delay and delay > 0 then
                                task.wait(delay)
                                local bestOption = GetBestAffordableRebirth()
                                if bestOption then
                                    pcall(function() Network:InvokeServer("Rebirth", bestOption) end)
                                end
                            else
                                if State.isMaxUnlockedSelected then task.wait(0.2) end
                                pcall(performRebirth)
                                if not State.isMaxUnlockedSelected then task.wait(0.2) end
                            end
                        end
                    end)
                end
            end)

            State.UpgradesSection = State.Tabs.Main:AddSection("Upgrades")
            State.selectedUpgrades = {}
            State.upgradeThread = nil

            local function getAllUpgradesList()
                local list = {}
                for world, _ in pairs(require(ReplicatedStorage.Game.DoubleJumps)) do
                    table.insert(list, "Double Jump: " .. world)
                end
                for id, data in pairs(require(ReplicatedStorage.Game.GemShop)) do
                    table.insert(list, data.Title or id)
                end
                table.sort(list)
                return list
            end

            State.upgradesDropdown = State.UpgradesSection:Dropdown("AutoUpgrades", {
                Title = "Select Upgrades", Values = getAllUpgradesList(), Multi = true, Searchable = true, Default = {}, Callback = function(val)
                    State.selectedUpgrades = val
                end
            })

            State.UpgradesSection:AddButton({
                Title = "Select All", Callback = function()
                    State.allSelected = {}
                    for _, upgradeName in ipairs(getAllUpgradesList()) do
                        State.allSelected[upgradeName] = true
                    end
                    State.selectedUpgrades = State.allSelected
                    State.upgradesDropdown:SetValue(State.allSelected)
                end
            })
                        
            State.UpgradesSection:AddToggle("AutoBuyUpgrades", {
                Title = "Auto Upgrade", Default = false, Callback = function(Value)
                    if State.upgradeThread then task.cancel(State.upgradeThread) State.upgradeThread = nil end
                    
                    if Value then
                        State.upgradeThread = task.spawn(function()
                            
                            State.lastPurchaseIndex = 0

                            while Value do
                                local purchasedSomething = false
                                
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data
                                    State.gems = Replication.Data.Statistics.Gems or 0
                                    State.affordable = {}

                                    for name, isSelected in pairs(State.selectedUpgrades) do
                                        if isSelected then
                                            local worldName = name:match("Double Jump: (.+)")
                                            
                                            if worldName then
                                                local data = DoubleJumps[worldName]
                                                local lvl = (Replication.Data.DoubleJumps and Replication.Data.DoubleJumps[worldName]) or 1
                                                
                                                if data and data.Prices and data.Prices[lvl] then
                                                    if State.gems >= data.Prices[lvl] then
                                                        table.insert(State.affordable, {
                                                            name = name, price = data.Prices[lvl], upgradeType = "DoubleJump", upgradeId = worldName
                                                        })
                                                    end
                                                end
                                            else
                                                for id, data in pairs(GemShop) do
                                                    if (data.Title or id) == name then
                                                        State.shopId = id
                                                        State.shopData = data
                                                        break
                                                    end
                                                end

                                                if State.shopId then
                                                    State.cur = (Replication.Data.GemShop and Replication.Data.GemShop[State.shopId]) or 0
                                                    State.maxLevel = State.shopData.Total or 9e9
                                            
                                                    if State.cur < State.maxLevel then
                                                        if State.shopData.Function then
                                                            State.cost = math.round(State.shopData.Function(State.cur + 1) * State.shopData.Price / 10) * 10
                                                        else
                                                            State.cost = State.shopData.Price * (State.cur + 1)
                                                        end
                                                        
                                                        if State.gems >= State.cost then
                                                            table.insert(State.affordable, {
                                                                name = name, shopId = State.shopId, price = State.cost, upgradeType = "GemShop", upgradeId = State.shopId
                                                            })
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end

                                    if #State.affordable > 0 then
                                        State.lastPurchaseIndex = State.lastPurchaseIndex + 1
                                        if State.lastPurchaseIndex > #State.affordable then
                                            State.lastPurchaseIndex = 1
                                        end
                                        
                                        local item = State.affordable[State.lastPurchaseIndex]                            
                                        purchasedSomething = true
                                        
                                        if item.upgradeType == "DoubleJump" then
                                            pcall(function()
                                                Network:InvokeServer("UpgradeDoubleJump", item.upgradeId)
                                            end)
                                        elseif item.upgradeType == "GemShop" then
                                            pcall(function()
                                                Network:InvokeServer("UpgradeGemShop", item.upgradeId)
                                            end)
                                        end
                                    else
                                        State.lastPurchaseIndex = 0
                                    end
                                end)
                                
                                if purchasedSomething then
                                    task.wait()
                                else
                                    task.wait(5)
                                end
                            end
                        end)
                    end
                end
            })

            State.EggSection = State.Tabs.Eggs:AddSection("Egg Hatching")

            State.EventStateController = require(State.LocalPlayer.PlayerScripts.Modules.Controllers.EventStateController)

            State.selectedEgg = nil
            State.selectedHatchAmount = 1
            State.manualHatchAmountInput = nil
            State.hatchSpeed = 0
            State.autoHatchEnabled = false
            State.autoHatchThread = nil
            State.rejoinBreakEnabled = false
            State.rejoinBreakThread = nil
            State.useNormalSpeed = false
            State.calculatedSpeed = 0
            State.normalSpeedToggle = nil
            State.maxHatchCheckThread = nil

            State.hatchOriginalCFrame = nil
            State.isHatchingAway = false

            State.eggMap = {}
            State.eggDropdown = nil 

            local function calculateHatchSpeed()
                State.baseSpeed = tonumber(Replication.Data.EggOpenSpeed) or 1
                
                if Replication.Data.Gamepasses and Replication.Data.Gamepasses.FasterEgg then
                    State.baseSpeed = State.baseSpeed * 1.5
                end
                
                if Replication.Data.GemShop and Replication.Data.GemShop.HatchSpeed then
                    State.baseSpeed = State.baseSpeed * (1 + Replication.Data.GemShop.HatchSpeed / 15)
                end
                
                State.baseSpeed = State.baseSpeed * State.EventStateController:GetMultiplier("HatchSpeed")
                
                if workspace:GetAttribute("GlobalBoost_HatchSpeed_Active") then
                    State.baseSpeed = State.baseSpeed * (workspace:GetAttribute("GlobalBoost_HatchSpeed_Multiplier") or 1)
                end
                
                State.baseSpeed = State.baseSpeed * (State.LocalPlayer:GetAttribute("TotemHatchSpeedBoost") or 1)
                
                State.animationTime = 4.46 / State.baseSpeed
                State.actualHatchInterval = State.animationTime + 0.16
                
                return State.actualHatchInterval
            end

            local function checkOctoIncubator()
                local data = Replication.Data
                if not data.ActiveBoosts then return false, 0 end
                
                for boostId, expiryTime in pairs(data.ActiveBoosts) do
                    if boostId == "Octo Incubator" then
                        local timeRemaining = expiryTime - os.time()
                        return timeRemaining > 0, timeRemaining
                    end
                end
                
                return false, 0
            end

            local function calculateMaxHatch()
                local data = Replication.Data
                State.extra = data.ExtraHatches or 0 
                State.hasOctoBoost, timeRemaining = checkOctoIncubator()

                if State.hasOctoBoost then
                    if State.maxHatchCheckThread then
                        task.cancel(State.maxHatchCheckThread)
                    end

                    State.maxHatchCheckThread = task.spawn(function()
                        task.wait(timeRemaining)
                        if State.selectedHatchAmount == 8 + State.extra then
                            State.selectedHatchAmount = calculateMaxHatch()
                        end
                    end)

                    return 8 + State.extra
                end

                State.gamepasses = data.Gamepasses or {}
                if State.gamepasses.x8Egg then
                    return 8 + State.extra
                end

                return 3 + State.extra
            end

            local function saveHatchPosition()
                if not State.isHatchingAway and State.LocalPlayer.Character and State.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if not State.hatchOriginalCFrame then
                        State.hatchOriginalCFrame = State.LocalPlayer.Character:GetPivot()
                    end
                    State.isHatchingAway = true
                end
            end

            local function restoreHatchPosition()
                if State.isHatchingAway and State.hatchOriginalCFrame and State.LocalPlayer.Character and State.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    task.wait(0.2)
                    State.LocalPlayer.Character:PivotTo(State.hatchOriginalCFrame)
                    State.hatchOriginalCFrame = nil
                    State.isHatchingAway = false
                end
            end

            local function getEggDropdownValues()
                State.eggList = {}
                State.sortedEggs = {}
                State.eggMap = {}

                for eggName, eggData in pairs(Eggs) do
                    if type(eggData) == "table" then
                        local price = eggData.Price or 0
                        local isExpired = eggData.Expired or false
                        if price > 0 and not isExpired then
                            table.insert(State.sortedEggs, {
                                name = eggName, price = price
                            })
                        end
                    end
                end

                table.sort(State.sortedEggs, function(a, b)
                    return a.price < b.price
                end)

                for _, egg in ipairs(State.sortedEggs) do
                    local priceStr = formatNumber(egg.price)
                    local displayName = string.format("%s - %s", egg.name, priceStr)
                    table.insert(State.eggList, displayName)
                    State.eggMap[displayName] = egg.name
                end

                return State.eggList, State.sortedEggs, State.eggMap
            end

            State.eggDropdownValues, State.sortedEggs, State.eggMap = getEggDropdownValues()

            if State.sortedEggs and State.sortedEggs[1] then
                State.selectedEgg = State.sortedEggs[1].name
            end

            State.eggDropdown = State.EggSection:Dropdown("EggDropdown", {
                Title = "Select Egg", Values = State.eggDropdownValues, Searchable = true, Default = (State.eggDropdownValues and #State.eggDropdownValues > 0) and State.eggDropdownValues[1] or nil, Multi = false, Callback = function(selectedValue)
                    State.realName = State.eggMap[selectedValue]
                    if State.realName then
                        State.selectedEgg = State.realName
                    end
                end
            })

            State.hatchAmountDropdown = State.EggSection:Dropdown("HatchAmountDropdown", {
                Title = "Hatch Amount", Values = {"1x", "3x", "8x", "Max"}, Default = "1x", Multi = false, Callback = function(selectedValue)
                    if selectedValue == "1x" then
                        State.selectedHatchAmount = 1
                    elseif selectedValue == "3x" then
                        State.selectedHatchAmount = 3
                    elseif selectedValue == "8x" then
                        State.selectedHatchAmount = 8
                    elseif selectedValue == "Max" then
                        State.selectedHatchAmount = calculateMaxHatch()
                    end
                end
            })

            State.manualHatchAmountInput = State.EggSection:AddInput("ManualHatchAmount", {
                Title = "Manual Hatch Amount", Default = "", Numeric = true, Finished = false
            })

            State.calculatedSpeed = calculateHatchSpeed()

            State.hatchSpeedSlider = State.EggSection:AddSlider("HatchSpeed", {
                Title = "Hatch Speed", Default = tonumber(string.format("%.2f", State.calculatedSpeed)), Min = 0, Max = 5, Rounding = 1, Callback = function(Value)
                    if not State.useNormalSpeed then
                        State.hatchSpeed = Value
                    end
                end
            })

            State.normalSpeedToggle = State.EggSection:AddToggle("UseNormalSpeed", {
                Title = "Use Normal Hatch Speed (" .. string.format("%.2f", State.calculatedSpeed) .. "s)", Default = false, Callback = function(Value)
                    State.useNormalSpeed = Value
                    if Value then
                        State.hatchSpeed = State.calculatedSpeed
                    else
                        State.hatchSpeed = State.hatchSpeedSlider.Value
                    end
                end
            })

            task.spawn(function()
                while true do
                    task.wait(5)
                    State.calculatedSpeed = calculateHatchSpeed()
                    if State.useNormalSpeed then
                        State.hatchSpeed = State.calculatedSpeed
                    end
                end
            end)

            task.spawn(function()
                while true do
                    task.wait(10)
                    if State.normalSpeedToggle then
                        State.normalSpeedToggle:SetTitle("Use Normal Hatch Speed (" .. string.format("%.2f", State.calculatedSpeed) .. "s)")
                    end
                end
            end)

            State.AutoHatchToggle = State.EggSection:AddToggle("AutoHatch", {
                Title = "Auto Hatch", Default = false, Callback = function(Value)
                    State.autoHatchEnabled = Value

                    if State.autoHatchThread then
                        task.cancel(State.autoHatchThread)
                        State.autoHatchThread = nil
                    end
                    if autoMoveThread then
                        task.cancel(autoMoveThread)
                        autoMoveThread = nil
                    end

                    if Value then
                        if State.eggDropdown and State.eggDropdown.Value then
                            State.realName = State.eggMap[State.eggDropdown.Value]
                            if State.realName then 
                                State.selectedEgg = State.realName 
                            end
                        end

                        saveHatchPosition()
                        
                        autoMoveThread = task.spawn(function()
                            while State.autoHatchEnabled do
                                if State.selectedEgg then
                                    if not State.isClaimingBlock and not State.Loop.isGoldenBusy and not State.Loop.isRainbowBusy and not State.Loop.isElectricBusy then
                                        local eggModel = workspace.Eggs:FindFirstChild(State.selectedEgg)
                                        local hrp = State.LocalPlayer.Character and State.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                        if eggModel and hrp then
                                            local eggPivot = eggModel:GetPivot()
                                            local playerPivot = State.LocalPlayer.Character:GetPivot()
                                            if (playerPivot.Position - eggPivot.Position).Magnitude > 20 then
                                                local targetCFrame = CFrame.lookAt(eggPivot.Position + Vector3.new(0,0,6), eggPivot.Position)
                                                State.LocalPlayer.Character:PivotTo(targetCFrame)
                                            end
                                        elseif hrp then
                                            State.LocalPlayer.Character:PivotTo(
                                                CFrame.new(
                                                    -175.509537, 213.829193, 243.644791,
                                                    0.555036485, -2.11624478e-08, 0.831826031,
                                                    2.47650682e-08, 1, 8.91644536e-09,
                                                    -0.831826031, 1.56512758e-08, 0.555036485
                                                )
                                            )
                                        end
                                    end
                                    task.wait(3)
                                end
                            end
                        end)

                        State.autoHatchThread = task.spawn(function()
                            while State.autoHatchEnabled do
                                if State.selectedEgg then
                                    pcall(function()
                                        local hatchAmountToUse = State.selectedHatchAmount
                                        local manualInputValue = State.manualHatchAmountInput and State.manualHatchAmountInput.Value
                                        local manualHatchAmount = tonumber(manualInputValue)
                                        if manualHatchAmount and manualHatchAmount > 0 then
                                            hatchAmountToUse = math.floor(manualHatchAmount)
                                        end
                                        Network:InvokeServer("OpenEgg", State.selectedEgg, hatchAmountToUse)
                                    end)
                                end
                                task.wait(State.hatchSpeed)
                            end
                        end)

                    else
                        restoreHatchPosition()
                    end
                end
            })

            State.RejoinBreakToggle = State.EggSection:AddToggle("RejoinIfBreak", {
                Title = "Rejoin if Hatching Breaks", Description = "Rejoins a server if its not letting you hatch. Uses Auto-Rejoin settings (Private Server ID if set). MAKE SURE AUTO EXECUTE IS ON IN YOUR EXECUTOR!", Default = false, Callback = function(Value)
                    State.rejoinBreakEnabled = Value
                    if State.rejoinBreakThread then
                        task.cancel(State.rejoinBreakThread)
                        State.rejoinBreakThread = nil
                    end

                    if Value then
                        State.rejoinBreakThread = task.spawn(function()
                            State.lastEggCount = -1
                            State.sameCountTimer = 0
                            
                            while State.rejoinBreakEnabled do
                                task.wait(1)
                                
                                if State.autoHatchEnabled and Replication.Loaded and Replication.Data and Replication.Data.Statistics then
                                    local currentEggs = Replication.Data.Statistics.Eggs or 0
                                    
                                    if currentEggs == State.lastEggCount then
                                        State.sameCountTimer = State.sameCountTimer + 1
                                    else
                                        State.sameCountTimer = 0
                                        State.lastEggCount = currentEggs
                                    end

                                    if State.sameCountTimer >= 6 then
                                        if State.privateServerIdInput and State.privateServerIdInput.Value ~= "" and extractPrivateServerId then
                                            local code = extractPrivateServerId(State.privateServerIdInput.Value)
                                            if code ~= "" then
                                                local teleportOptions = Instance.new("TeleportOptions")
                                                teleportOptions.ReservedServerAccessCode = code
                                                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer, teleportOptions)
                                            else
                                                TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                                            end
                                        else
                                            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                                        end
                                        break
                                    end
                                end
                            end
                        end)
                    end
                end
            })
            
            State.EggSection:Paragraph("EggInfo", {
                Title = "Egg Info", Content = "Select an egg and hatch amount, then enable Auto Hatch.\nYou need to own the hatch multiplier (3x/8x) to use it. For the manual hatch, you need to own that number (you cant type 2 even if you have 4x for example).", TitleAlignment = "Middle"
            })

            State.AutoDeleteSection = State.Tabs.Eggs:AddSection("Auto Delete")

            State.selectedDeleteEgg = nil
            State.selectedDeletePets = {}
            State.deleteDropdown = nil

            local function getDeleteEggValues()
                State.eggList = {}
                for eggName, eggData in pairs(Eggs) do
                    if type(eggData) == "table" and eggData.Pets and eggName ~= "Chronos Egg" then
                        table.insert(State.eggList, eggName)
                    end
                end
                table.sort(State.eggList)
                return State.eggList
            end

            local function updateDeletePetDropdown(eggName)
                if not eggName or not Eggs[eggName] or not Eggs[eggName].Pets then
                    if State.deleteDropdown then State.deleteDropdown:SetValues({}) end
                    return
                end
                
                State.petList = {}
                for petName, chance in pairs(Eggs[eggName].Pets) do
                    table.insert(State.petList, {
                        name = petName, chance = chance, display = string.format("%s - %s%%", petName, tostring(Eggs.GetChance(eggName, petName)))
                    })
                end
                
                table.sort(State.petList, function(a, b) return a.chance > b.chance end)
                
                State.sortedDisplayList = {}
                for _, pet in ipairs(State.petList) do
                    table.insert(State.sortedDisplayList, pet.display)
                end
                
                if State.deleteDropdown then
                    State.deleteDropdown:SetValues(State.sortedDisplayList)
                end
            end

            State.deleteEggDropdown = State.AutoDeleteSection:Dropdown("DeleteEggDropdown", {
                Title = "Select Egg", Values = getDeleteEggValues(), Searchable = true, Default = nil, Multi = false, Callback = function(selectedValue)
                    State.selectedDeleteEgg = selectedValue
                    State.selectedDeletePets = {}
                    updateDeletePetDropdown(selectedValue)
                end
            })

            State.deleteDropdown = State.AutoDeleteSection:Dropdown("DeletePetsDropdown", {
                Title = "Select Pets to Delete", Values = {}, Multi = true, Default = {}, Callback = function(value)
                    State.selectedDeletePets = {}
                    
                    if type(value) == "table" then
                        for petDisplay, isSelected in pairs(value) do
                            if isSelected then
                                local petName = petDisplay:match("^(.+)%s*%-")
                                if petName then
                                    petName = petName:gsub("%s*$", "")
                                    table.insert(State.selectedDeletePets, petName)
                                end
                            end
                        end
                    end
                end
            })

            State.ApplyAutoDeleteButton = State.AutoDeleteSection:AddButton({
                Title = "Apply Auto Delete", Callback = function()
                    if not State.selectedDeleteEgg or #State.selectedDeletePets == 0 then
                        return
                    end
                    
                    State.deleteData = {
                        [State.selectedDeleteEgg] = State.selectedDeletePets
                    }
                    
                    pcall(Network.FireServer, Network, "AutoDelete", State.deleteData)
                end
            })

            local function DoesPlayerOwnZone(zoneName)
                if not Replication.Loaded then return false end
                return Replication.Data and Replication.Data.Portals and Replication.Data.Portals[zoneName] == true
            end

            local function DoesPlayerOwnWorld(worldName)
                if not Replication.Loaded then return false end
                return Replication.Data and Replication.Data.Worlds and Replication.Data.Worlds[worldName] == true
            end

            local function GetProgressionPath(worldId)
                State.path = {}
                for zoneName, portalInfo in pairs(Portals) do
                    if portalInfo.World == worldId then
                        local islandPart = IslandParts:FindFirstChild(zoneName)
                        if islandPart then
                            table.insert(State.path, { Name = zoneName, Part = islandPart, Height = islandPart.Position.Y })
                        end
                    end
                end
                table.sort(State.path, function(a, b) return a.Height < b.Height end)
                return State.path
            end

            local function UnlockZoneQueue(queue, char, shouldNotify, titlePrefix)
                for i, zoneToUnlock in ipairs(queue) do
                    char:PivotTo(zoneToUnlock.Part:GetPivot())
                    
                    local unlocked = false
                    for _ = 1, 20 do
                        if DoesPlayerOwnZone(zoneToUnlock.Name) then
                            unlocked = true
                            break
                        end
                        task.wait(0.5)
                    end

                    if not unlocked then
                        error(string.format("Failed to unlock prerequisite '%s'. Aborting.", zoneToUnlock.Name))
                    end
                end
            end

            local function HandleUnlockSequence(targetZoneData, shouldNotify)
                local char = State.LocalPlayer.Character
                if not (char and char.PrimaryPart) then return end

                State.originalGravity = Workspace.Gravity
                
                success, State.err = pcall(function()
                    State.worldMaps = { nameToId = {}, idToName = {} }
                    State.worldProgression = {}

                    for name, data in pairs(Worlds) do table.insert(State.worldProgression, { Name = name, Price = data.Price or 0 }) end
                    table.sort(State.worldProgression, function(a, b) return a.Price < b.Price end)
                    for id, data in ipairs(State.worldProgression) do
                        State.worldMaps.nameToId[data.Name] = id
                        State.worldMaps.idToName[id] = data.Name
                    end

                    State.targetWorldId = State.worldMaps.nameToId[targetZoneData.World]
                    
                    for worldIdToComplete = 1, State.targetWorldId - 1 do
                        local worldNameToComplete = State.worldMaps.idToName[worldIdToComplete]
                        local progressionPath = GetProgressionPath(worldIdToComplete)
                        local unlockQueue = {}

                        for _, zoneInPath in ipairs(progressionPath) do
                            if not DoesPlayerOwnZone(zoneInPath.Name) then
                                table.insert(unlockQueue, zoneInPath)
                            end
                        end

                        if #unlockQueue > 0 then
                            if Workspace.Gravity == originalGravity then
                                Workspace.Gravity = 0

                                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                                if hrp then
                                    hrp.AssemblyLinearVelocity = Vector3.zero
                                    hrp.AssemblyAngularVelocity = Vector3.zero
                                end
                            end

                            UnlockZoneQueue(
                                unlockQueue, char, shouldNotify, string.format("Completing %s World", worldNameToComplete)
                            )
                        end

                        State.nextWorldName = State.worldMaps.idToName[worldIdToComplete + 1]
                        if State.nextWorldName and not DoesPlayerOwnWorld(State.nextWorldName) then
                            Network:InvokeServer("BuyWorld", State.nextWorldName)
                            task.wait(1)
                        end
                    end

                    Network:InvokeServer("TeleportWorld", targetZoneData.World)
                    task.wait(1)

                    if not State.targetPath then
                        State.targetPath = GetProgressionPath(State.targetWorldId)
                    end
                    State.targetUnlockQueue = {}
                    for _, zoneInPath in ipairs(State.targetPath) do
                        if not DoesPlayerOwnZone(zoneInPath.Name) then
                            table.insert(State.targetUnlockQueue, zoneInPath)
                        end
                        if zoneInPath.Name == targetZoneData.ZoneName then break end
                    end
                    
                    if #State.targetUnlockQueue > 0 then
                        if Workspace.Gravity == originalGravity then Workspace.Gravity = 0 end
                        UnlockZoneQueue(State.targetUnlockQueue, char, shouldNotify, string.format("Progressing in %s", targetZoneData.World))
                    end

                    Network:InvokeServer("TeleportZone", targetZoneData.ZoneName)
                end)
                
                Workspace.Gravity = originalGravity
                
                if not success then
                    pcall(function() Network:InvokeServer("TeleportZone", "Spawn") end)
                end
            end

            State.CraftingSection = State.Tabs.Crafting:AddSection("Golden Machine")

            State.LocalPlayer = Players.LocalPlayer

            State.Loop = {
                isPlayerAway = false, originalCFrame = nil, originalWorld = nil, originalZone = nil, isGoldenBusy = false, isRainbowBusy = false, goldenEnabled = false, rainbowEnabled = false, goldenThread = nil, rainbowThread = nil,
                 
            }

            State.machineLocations = {
                Golden = {
                    ["Main Spawn"] = {World = "Main"},
                    ["Forest"] = {World = "Main"},
                    ["Desert"] = {World = "Main"},
                    ["Jungle"] = {World = "Main"},
                    ["Dojo"] = {World = "Main"},
                    ["Volcano"] = {World = "Main"},
                    ["Candy"] = {World = "Main"},
                    ["Space"] = {World = "Main"},
                    ["Winter"] = {World = "Main"},
                    ["Space Spawn"] = {World = "Space"},
                    ["Kyro"] = {World = "Space"},
                    ["Celestial"] = {World = "Space"},
                    ["Lunar"] = {World = "Space"}
                }, Rainbow = {
                    ["Heaven"] = {World = "Main"},
                    ["Space"] = {World = "Main"},
                    ["Space Spawn"] = {World = "Space"},
                    ["Rainbow"] = {World = "Space"}
                },

            }

            local function tryReturnPlayer()
                if State.Loop.isGoldenBusy or State.Loop.isRainbowBusy or State.isClaimingBlock then 
                    return 
                end
                
                if State.Loop.isPlayerAway then
                    pcall(function()
                        if State.Loop.originalWorld then
                            Network:InvokeServer("TeleportWorld", State.Loop.originalWorld)
                            task.wait(0.1)
                        end

                        if State.Loop.originalZone and not State.Loop.originalZone:find("Spawn") then
                            Network:InvokeServer("TeleportZone", State.Loop.originalZone)
                            task.wait(0.1)
                        end

                        local character = State.LocalPlayer.Character
                        if character and character:FindFirstChild("HumanoidRootPart") and State.Loop.originalCFrame then
                            character:PivotTo(State.Loop.originalCFrame)
                        end
                    end)
                    
                    State.Loop.originalCFrame = nil
                    State.Loop.originalWorld = nil
                    State.Loop.originalZone = nil
                    State.Loop.isPlayerAway = false
                end
            end

            local function captureOriginalLocation()
                if not State.Loop.isPlayerAway then
                    local character = State.LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        State.Loop.originalCFrame = character:GetPivot()
                        if Replication.Data then
                            State.Loop.originalWorld = Replication.Data.World
                            State.Loop.originalZone = Replication.Data.Zone
                        end
                        State.Loop.isPlayerAway = true
                    end
                end
            end

            local function teleportToZone(zoneInfo)
                if not zoneInfo then return false end
                
                captureOriginalLocation()
                
                pcall(function()
                    Network:InvokeServer("TeleportWorld", zoneInfo.World)
                    task.wait(0.1)
                    if not zoneInfo.Name:find("Spawn") then
                        Network:InvokeServer("TeleportZone", zoneInfo.Name)
                        task.wait(0.1)
                    end
                end)
            end

            local function findNearestMachine(machineName)
                local p = Players.LocalPlayer
                local c = p.Character
                if not c or not c:FindFirstChild("HumanoidRootPart") then return nil end
                local hrp = c.HumanoidRootPart
                
                State.bestPart = nil
                State.bestDist = math.huge
                
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and v.Name == machineName then
                        if not v:IsDescendantOf(c) then
                            local dist = (v.Position - hrp.Position).Magnitude
                            if dist < State.bestDist then
                                State.bestDist = dist
                                State.bestPart = v
                            end
                        end
                    end
                end
                return State.bestPart
            end

            local function findBestZoneForMachine(machineType)
                local success, result = pcall(function()
                    if not (Replication.Data and Replication.Data.Worlds and Replication.Data.Portals) then return nil end

                    State.worldProgression, State.worldRankMap = {}, {}
                    for name, data in pairs(WorldsModule) do 
                        table.insert(State.worldProgression, { Name = name, Price = data.Price or 0 }) 
                    end
                    table.sort(State.worldProgression, function(a, b) return a.Price < b.Price end)
                    
                    for i, worldData in ipairs(State.worldProgression) do 
                        State.worldRankMap[worldData.Name] = i 
                    end

                    State.allMyPlaces = {}
                    
                    table.insert(State.allMyPlaces, { Name = "Main Spawn", World = "Main", Price = 0, WorldRank = 1 })
                    
                    for worldName, isUnlocked in pairs(Replication.Data.Worlds) do
                        if isUnlocked and worldName ~= "Main" then
                            local rank = State.worldRankMap[worldName] or 1
                            table.insert(State.allMyPlaces, { 
                                Name = worldName .. " Spawn", World = worldName, Price = WorldsModule[worldName].Price or 0, WorldRank = rank 
                            })
                        end
                    end
                    
                    for zoneName, portalInfo in pairs(PortalsModule) do
                        if Replication.Data.Portals[zoneName] == true then
                            local worldName = portalInfo.World or "Main"
                            local rank = State.worldRankMap[worldName] or 1
                            table.insert(State.allMyPlaces, { 
                                Name = zoneName, World = worldName, Price = portalInfo.Price or 0, WorldRank = rank 
                            })
                        end
                    end

                    table.sort(State.allMyPlaces, function(a, b)
                        if a.WorldRank ~= b.WorldRank then 
                            return a.WorldRank < b.WorldRank 
                        else 
                            return a.Price < b.Price 
                        end
                    end)
                    
                    if State.machineLocations[machineType] then
                        for i = #State.allMyPlaces, 1, -1 do
                            local place = State.allMyPlaces[i]
                            if State.machineLocations[machineType][place.Name] then
                                return place
                            end
                        end
                    end
                    return nil
                end)
                return success and result or nil
            end

            local function getNormalPetNames()
                if not (Replication.Data and Replication.Data.Pets) then return {} end
                State.petNames, State.nameSet = {}, {}
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Tier == "Normal" and not petData.Locked and not State.nameSet[petData.Name] then
                        table.insert(State.petNames, petData.Name)
                        State.nameSet[petData.Name] = true
                    end
                end
                table.sort(State.petNames)
                return State.petNames
            end

            local function countPetsOfName(petName)
                local count = 0
                if not (Replication.Data and Replication.Data.Pets) then return 0 end
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Name == petName and petData.Tier == "Normal" and not petData.Locked then count = count + 1 end
                end
                return count
            end

            local function getAllNormalPetIds(petName)
                State.ids = {}
                if not (Replication.Data and Replication.Data.Pets) then return State.ids end
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Name == petName and petData.Tier == "Normal" and not petData.Locked then table.insert(State.ids, petId) end
                end
                return State.ids
            end

            local function getGoldenPetNames()
                if not (Replication.Data and Replication.Data.Pets) then return {} end
                State.petNames, State.nameSet = {}, {}
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Tier == "Golden" and not petData.Locked and not State.nameSet[petData.Name] then
                        table.insert(State.petNames, petData.Name)
                        State.nameSet[petData.Name] = true
                    end
                end
                table.sort(State.petNames)
                return State.petNames
            end

            local function countGoldenPetsOfName(petName)
                local count = 0
                if not (Replication.Data and Replication.Data.Pets) then return 0 end
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Name == petName and petData.Tier == "Golden" and not petData.Locked then count = count + 1 end
                end
                return count
            end

            local function getAllGoldenPetIds(petName)
                State.ids = {}
                if not (Replication.Data and Replication.Data.Pets) then return State.ids end
                for petId, petData in pairs(Replication.Data.Pets) do
                    if not petData then continue end
                    if petData.Name == petName and petData.Tier == "Golden" and not petData.Locked then table.insert(State.ids, petId) end
                end
                return State.ids
            end

            State.selectedGoldMachinePets = {}
            State.selectedChance = "100%"
            State.petsDropdown = nil
            State.petCountParagraph = nil

            local function updatePetCount()
                if not State.petCountParagraph then return end
                pcall(function()
                    State.statusText = "Selected Pets:\n"
                    State.foundAny = false
                    if type(State.selectedGoldMachinePets) == "table" then
                        for k, v in pairs(State.selectedGoldMachinePets) do
                            local petName = nil
                            if type(k) == "string" and v == true then petName = k elseif type(k) == "number" and type(v) == "string" then petName = v end
                            if petName then
                                State.foundAny = true
                                local count = countPetsOfName(petName)
                                State.statusText = State.statusText .. string.format("%s: %d owned\n", petName, count)
                            end
                        end
                    end
                    if not State.foundAny then State.statusText = "No pets selected" end
                    State.petCountParagraph:SetContent(State.statusText)
                end)
            end

            State.chanceDropdown = State.CraftingSection:Dropdown("CraftChance", {
                Title = "Select Chance", Values = {"5% (1 pet)", "15% (2 pets)", "35% (3 pets)", "60% (4 pets)", "80% (5 pets)", "100% (6 pets)"}, Default = "100% (6 pets)", Multi = false, Callback = function(value) State.selectedChance = value end
            })

            State.petsDropdown = State.CraftingSection:Dropdown("CraftPets", {
                Title = "Select Pets to Craft", Values = getNormalPetNames(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedGoldMachinePets = value or {}
                    updatePetCount()
                end
            })

            State.RefreshPetsButton = State.CraftingSection:AddButton({
                Title = "Refresh Pets", Description = "Updates the pet list and counts", Callback = function()
                    pcall(function()
                        if State.petsDropdown then State.petsDropdown:SetValues(getNormalPetNames()) end
                        updatePetCount()
                    end)
                end
            })

            State.petCountParagraph = State.CraftingSection:AddParagraph("Golden",{Title = "Pet Status", Content = "No pets selected,"})

            State.AutoCraftToggle = State.CraftingSection:AddToggle("AutoCraftGolden", {
                Title = "Auto Craft (Golden)", Default = false, Callback = function(Value)
                    State.Loop.goldenEnabled = Value
                    if State.Loop.goldenThread then pcall(function() task.cancel(State.Loop.goldenThread) end) State.Loop.goldenThread = nil end
                    
                    if not Value then
                        State.Loop.isGoldenBusy = false
                        task.wait(0.1)
                        tryReturnPlayer()
                        return
                    end

                    State.Loop.goldenThread = task.spawn(function()
                        while State.Loop.goldenEnabled do
                            pcall(function()
                                if not Replication.Data then return end

                                if State.Loop.isRainbowBusy then task.wait(1) return end

                                State.petsNeeded = 6
                                if State.selectedChance:match("5%%") then State.petsNeeded = 1
                                elseif State.selectedChance:match("15%%") then State.petsNeeded = 2
                                elseif State.selectedChance:match("35%%") then State.petsNeeded = 3
                                elseif State.selectedChance:match("60%%") then State.petsNeeded = 4
                                elseif State.selectedChance:match("80%%") then State.petsNeeded = 5 end

                                State.canCraftAny = false
                                if type(State.selectedGoldMachinePets) == "table" then
                                    for k, v in pairs(State.selectedGoldMachinePets) do
                                        local petName = nil
                                        if type(k) == "string" and v == true then petName = k elseif type(k) == "number" and type(v) == "string" then petName = v end
                                        if petName and countPetsOfName(petName) >= State.petsNeeded then State.canCraftAny = true; break end
                                    end
                                end
                                
                                if State.canCraftAny then
                                    State.Loop.isGoldenBusy = true 
                                    
                                    State.bestZone = findBestZoneForMachine("Golden")
                                    if State.bestZone then
                                        teleportToZone(State.bestZone)
                                        task.wait(0.5)
                                        
                                        State.goldenMachine = nil
                                        State.searchStart = os.time()
                                        while os.time() - State.searchStart < 5 do
                                            State.goldenMachine = findNearestMachine("Golden")
                                            if State.goldenMachine then break end
                                            task.wait(0.1)
                                        end

                                        if State.goldenMachine and State.LocalPlayer.Character then
                                            pcall(function() State.LocalPlayer.Character:PivotTo(State.goldenMachine.CFrame * CFrame.new(0, 3, 0)) end)
                                            task.wait(0.5)
                                        end

                                        if type(State.selectedGoldMachinePets) == "table" then
                                            for k, v in pairs(State.selectedGoldMachinePets) do
                                                local petName = nil
                                                if type(k) == "string" and v == true then petName = k elseif type(k) == "number" and type(v) == "string" then petName = v end

                                                if petName then
                                                    State.allIds = getAllNormalPetIds(petName)
                                                    local i = 1
                                                    while i + State.petsNeeded - 1 <= #State.allIds do
                                                        local batch = {}
                                                        for j = 0, State.petsNeeded - 1 do table.insert(batch, State.allIds[i+j]) end
                                                        task.spawn(function() pcall(function() Network:InvokeServer("CraftPets", batch) end) end)
                                                        i = i + State.petsNeeded
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                    end
                                    State.Loop.isGoldenBusy = false
                                    tryReturnPlayer()  
                                else
                                     
                                    State.Loop.isGoldenBusy = false
                                    tryReturnPlayer()  
                                    task.wait(5)  
                                end
                                updatePetCount()
                            end)

                            task.wait(1) 
                        end
                    end)
                end
            })

            State.RainbowSection = State.Tabs.Crafting:AddSection("Rainbow Machine")

            State.selectedRainbowPets = {}
            State.selectedRainbowTime = "8h - 1 Pet"
            State.rainbowPetsDropdown = nil
            State.rainbowStatusParagraph = nil
            State.autoRainbowEnabled = false
            State.autoRainbowThread = nil

            local function getCurrentlyCraftingRainbow()
                State.crafting = {}
                if Replication.Data.CraftingPets and Replication.Data.CraftingPets.Rainbow then
                    for petId, craftData in pairs(Replication.Data.CraftingPets.Rainbow) do
                        local timeLeft = math.max(0, craftData.EndTime - os.time())
                        local hours = math.floor(timeLeft / 3600)
                        local minutes = math.floor((timeLeft % 3600) / 60)
                        local seconds = timeLeft % 60
                        
                        local timeString = string.format("%dh %dm %ds", hours, minutes, seconds)
                        
                        table.insert(State.crafting, {
                            id = petId, name = craftData.Name or "Unknown", timeLeft = timeLeft, timeString = timeString
                        })
                    end
                end
                return State.crafting
            end

            local function updateRainbowStatus()
                if not State.rainbowStatusParagraph then return end
                
                pcall(function()
                    State.statusText = "Selected Pets:\n"
                    State.hasSelectedPets = false
                    
                    if type(State.selectedRainbowPets) == "table" then
                        for k, v in pairs(State.selectedRainbowPets) do
                            local petName = nil
                            
                            if type(k) == "string" and v == true then
                                petName = k
                            elseif type(k) == "number" and type(v) == "string" then
                                petName = v
                            end

                            if petName then
                                State.hasSelectedPets = true
                                local count = countGoldenPetsOfName(petName)
                                State.statusText = State.statusText .. string.format("%s: %d owned\n", petName, count)
                            end
                        end
                    end
                    
                    if not State.hasSelectedPets then
                        State.statusText = "No pets selected\n"
                    end
                    
                    State.statusText = State.statusText .. "\nCurrently Crafting:\n"
                    State.crafting = getCurrentlyCraftingRainbow()
                    
                    if #State.crafting > 0 then
                        for _, craft in ipairs(State.crafting) do
                            State.statusText = State.statusText .. string.format("%s: %s\n", craft.name, craft.timeString)
                        end
                    else
                        State.statusText = State.statusText .. "None"
                    end
                    
                    State.rainbowStatusParagraph:SetContent(State.statusText)
                end)
            end

            State.rainbowTimeDropdown = State.RainbowSection:Dropdown("RainbowTime", {
                Title = "Select Time", Values = {"8h - 1 Pet", "5h - 2 Pets", "2.5h - 3 Pets", "1h - 4 Pets", "30s - 5 Pets"}, Default = nil, Multi = false, Callback = function(value)
                    State.selectedRainbowTime = value
                end
            })

            State.rainbowPetsDropdown = State.RainbowSection:Dropdown("RainbowPets", {
                Title = "Select Pets to Craft", Values = getGoldenPetNames(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedRainbowPets = value or {}
                    updateRainbowStatus()
                end
            })

            State.RefreshRainbowButton = State.RainbowSection:AddButton({
                Title = "Refresh Pets", Description = "Updates the pet list and counts", Callback = function()
                    pcall(function()
                        if State.rainbowPetsDropdown then
                            State.rainbowPetsDropdown:SetValues(getGoldenPetNames())
                        end
                        updateRainbowStatus()
                    end)
                end
            })

            State.rainbowStatusParagraph = State.RainbowSection:AddParagraph("RainbowStatus", {
                Title = "Pet Status", Content = "No pets selected"
            })

            State.AutoRainbowToggle = State.RainbowSection:AddToggle("AutoCraftRainbow", {
                Title = "Auto Craft (Rainbow)", Default = false, Callback = function(Value)
                    State.Loop.rainbowEnabled = Value
                    if State.Loop.rainbowThread then pcall(function() task.cancel(State.Loop.rainbowThread) end) State.Loop.rainbowThread = nil end
                    
                    if not Value then 
                        State.Loop.isRainbowBusy = false
                        task.wait(0.1) 
                        tryReturnPlayer()
                        return
                    end

                    State.Loop.rainbowThread = task.spawn(function()
                        while State.Loop.rainbowEnabled do
                            pcall(function()
                                if not Replication.Data then return end

                                if State.Loop.isGoldenBusy then
                                    task.wait(1)
                                    return
                                end

                                State.craftingData = Replication.Data.CraftingPets and Replication.Data.CraftingPets.Rainbow or {}
                                for id, data in pairs(State.craftingData) do
                                    if data.EndTime - os.time() <= 0 then
                                        task.spawn(function()
                                            pcall(function() Network:InvokeServer("ClaimRainbow", id) end)
                                        end)
                                    end
                                end

                                State.currentCraftingCount = 0
                                if Replication.Data.CraftingPets and Replication.Data.CraftingPets.Rainbow then
                                    for _ in pairs(Replication.Data.CraftingPets.Rainbow) do State.currentCraftingCount = State.currentCraftingCount + 1 end
                                end
                                State.availableSlots = 3 - State.currentCraftingCount

                                State.canCraftMore = false
                                State.petsNeeded = 1
                                
                                if State.selectedRainbowTime:match("2 Pets") then State.petsNeeded = 2
                                elseif State.selectedRainbowTime:match("3 Pets") then State.petsNeeded = 3
                                elseif State.selectedRainbowTime:match("4 Pets") then State.petsNeeded = 4
                                elseif State.selectedRainbowTime:match("5 Pets") then State.petsNeeded = 5 end

                                if State.availableSlots > 0 and type(State.selectedRainbowPets) == "table" then
                                    for k, v in pairs(State.selectedRainbowPets) do
                                        local petName = nil
                                        if type(k) == "string" and v == true then petName = k
                                        elseif type(k) == "number" and type(v) == "string" then petName = v end
                                        
                                        if petName and countGoldenPetsOfName(petName) >= State.petsNeeded then
                                            State.canCraftMore = true; break
                                        end
                                    end
                                end

                                if State.availableSlots > 0 and State.canCraftMore then
                                    State.Loop.isRainbowBusy = true
                                    State.bestZone = findBestZoneForMachine("Rainbow")
                                    
                                    if State.bestZone then
                                        teleportToZone(State.bestZone)
                                        task.wait(0.5)
                                        
                                        State.rainbowMachine = nil
                                        State.searchStart = os.time()
                                        while os.time() - State.searchStart < 5 do
                                            State.rainbowMachine = findNearestMachine("Rainbow")
                                            if State.rainbowMachine then break end
                                            task.wait(0.1)
                                        end

                                        if State.rainbowMachine and State.LocalPlayer.Character then
                                            pcall(function() 
                                                State.LocalPlayer.Character:PivotTo(State.rainbowMachine.CFrame * CFrame.new(0, 3, 0)) 
                                            end)
                                            task.wait(0.5)
                                        end
                                        
                                        State.usedIds = {}
                                        State.slotsToFill = State.availableSlots
                                        
                                        if type(State.selectedRainbowPets) == "table" then
                                            for k, v in pairs(State.selectedRainbowPets) do
                                                local petName = nil
                                                if type(k) == "string" and v == true then petName = k
                                                elseif type(k) == "number" and type(v) == "string" then petName = v end
                                                
                                                if petName and State.slotsToFill > 0 then
                                                    State.allIds = getAllGoldenPetIds(petName)
                                                    State.cleanIds = {}
                                                    for _, id in ipairs(State.allIds) do
                                                        if not State.usedIds[id] then
                                                            table.insert(State.cleanIds, id)
                                                        end
                                                    end

                                                    local i = 1
                                                    while i + State.petsNeeded - 1 <= #State.cleanIds and State.slotsToFill > 0 do
                                                        local batch = {}
                                                        for j = 0, State.petsNeeded - 1 do
                                                            local id = State.cleanIds[i+j]
                                                            table.insert(batch, id)
                                                            State.usedIds[id] = true
                                                        end
                                                        
                                                        task.spawn(function()
                                                            pcall(function() Network:InvokeServer("StartRainbow", batch) end)
                                                        end)
                                                        
                                                        State.slotsToFill = State.slotsToFill - 1
                                                        i = i + State.petsNeeded
                                                    end
                                                end
                                            end
                                        end
                                        task.wait()
                                    end
                                    State.Loop.isRainbowBusy = false
                                    tryReturnPlayer()  
                                else
                                     
                                    State.Loop.isRainbowBusy = false
                                    tryReturnPlayer()  
                                    task.wait(5)  
                                end
                                
                                updateRainbowStatus()
                            end)
                            
                            task.wait(1) 
                        end
                    end)
                end
            })

            task.spawn(function()
                task.wait(2)

                basePath = "FluentScriptHub/TapSimulator/settings/"
                autoloadPath = basePath .. "autoload.txt"

                function readConfig()
                    if not isfile(autoloadPath) then return end
                    configName = (readfile(autoloadPath) or ""):gsub("%s+$","")
                    fullConfigPath = basePath .. configName .. ".json"
                    if not isfile(fullConfigPath) then return end

                    State.ok, data = pcall(function()
                        return HttpService:JSONDecode(readfile(fullConfigPath))
                    end)

                    if State.ok then return data end
                end

                function extractTable(value)
                    out = {}
                    if type(value) == "string" then
                        out[value] = true
                    elseif type(value) == "table" then
                        for k, v in pairs(value) do
                            if v == true then out[tostring(k)] = true end
                        end
                    end
                    return out
                end

                function getSavedSelections()
                    data = readConfig()
                    saved = { CraftPets = {}, RainbowPets = {}, VoidPets = {} }
                    if not data or type(data.objects) ~= "table" then return saved end

                    for _, obj in ipairs(data.objects) do
                        if obj.type == "Dropdown" then
                            if obj.idx == "CraftPets" then
                                saved.CraftPets = extractTable(obj.value)
                            elseif obj.idx == "RainbowPets" then
                                saved.RainbowPets = extractTable(obj.value)

                            end
                        end
                    end

                    return saved
                end

                function toSet(list)
                    set = {}
                    for _, n in ipairs(list or {}) do set[n] = true end
                    return set
                end

                function filterSaved(saved, availableList)
                    State.avail = toSet(availableList)
                    out = {}
                    for name, on in pairs(saved or {}) do
                        if on and State.avail[name] then out[name] = true end
                    end
                    return out
                end

                function applyDropdown(dropdown, getNamesFunc, savedTable, updateGlobalVar)
                    if not dropdown then return end

                    task.wait(1)

                    realList = getNamesFunc() or {}
                    dropdown:SetValues(realList)

                    filtered = filterSaved(savedTable, realList)
                    dropdown:SetValue(filtered)
                    updateGlobalVar(filtered)
                end

                savedSelections = getSavedSelections()

                applyDropdown(State.petsDropdown, getNormalPetNames, savedSelections.CraftPets, function(v) State.selectedGoldMachinePets = v end)
                applyDropdown(State.rainbowPetsDropdown, getGoldenPetNames, savedSelections.RainbowPets, function(v) State.selectedRainbowPets = v end)

                updatePetCount()
                updateRainbowStatus()
                 
            end)

            State.OriginalFire = Signal.Fire
            State.BlockUntil = 0

            Signal.Fire = function(EventName, ...)
                State.Args = {...}
                
                if EventName == "OpenMessage" then
                    State.Title = State.Args[1]
                    State.Content = State.Args[2]
                    
                    if State.Title == "Teleport" and type(State.Content) == "string" and string.find(State.Content, "Spawn") then
                        if tick() < State.BlockUntil then
                            return
                        end
                    end
                end
                
                return State.OriginalFire(EventName, ...)
            end

            local function DoesPlayerOwnZone(zoneName)
                if not Replication.Loaded then return false end
                return Replication.Data and Replication.Data.Portals and Replication.Data.Portals[zoneName] == true
            end

            local function DoesPlayerOwnWorld(worldName)
                if not Replication.Loaded then return false end
                return Replication.Data and Replication.Data.Worlds and Replication.Data.Worlds[worldName] == true
            end

            local function GetProgressionPath(worldId, worldName)
                State.path = {}
                for zoneName, portalInfo in pairs(Portals) do
                    local zoneWorldId = type(portalInfo.World) == "number" and portalInfo.World or nil
                    local zoneWorldName = type(portalInfo.World) == "string" and portalInfo.World or nil
                    
                    if (worldId and zoneWorldId == worldId) or (worldName and zoneWorldName == worldName) then
                        local islandPart = IslandParts:FindFirstChild(zoneName)
                        if islandPart then
                            table.insert(State.path, { Name = zoneName, Part = islandPart, Price = portalInfo.Price or 0 })
                        end
                    end
                end
                table.sort(State.path, function(a, b) return a.Price < b.Price end)
                return State.path
            end

            local function UnlockZoneQueue(queue, char)
                for i, zoneToUnlock in ipairs(queue) do
                    State.BlockUntil = tick() + 3
                    char:PivotTo(zoneToUnlock.Part:GetPivot())
                    
                    local unlocked = false
                    for _ = 1, 20 do
                        if DoesPlayerOwnZone(zoneToUnlock.Name) then
                            unlocked = true
                            break
                        end
                        task.wait(0.5)
                    end

                    if not unlocked then
                        error(string.format("Failed to unlock prerequisite '%s'. Aborting.", zoneToUnlock.Name))
                    end
                end
            end

            local function HandleUnlockSequence(targetZoneData)
                local char = State.LocalPlayer.Character
                if not (char and char.PrimaryPart) then return end

                State.originalGravity = Workspace.Gravity
                
                success, State.err = pcall(function()
                    State.worldMaps = { nameToId = {}, idToName = {} }
                    State.worldProgression = {}

                    for name, data in pairs(Worlds) do table.insert(State.worldProgression, { Name = name, Price = data.Price or 0 }) end
                    table.sort(State.worldProgression, function(a, b) return a.Price < b.Price end)
                    for id, data in ipairs(State.worldProgression) do
                        State.worldMaps.nameToId[data.Name] = id
                        State.worldMaps.idToName[id] = data.Name
                    end

                    State.targetZonePortalData = Portals[targetZoneData.ZoneName]
                    if not State.targetWorldId then
                        State.targetWorldId = type(State.targetZonePortalData.World) == "number" and State.targetZonePortalData.World or State.worldMaps.nameToId[State.targetZonePortalData.World]
                    end
                    State.targetWorldName = State.worldMaps.idToName[State.targetWorldId]
                    
                    for worldIdToComplete = 1, State.targetWorldId - 1 do
                        local worldNameToComplete = State.worldMaps.idToName[worldIdToComplete]
                        local progressionPath = GetProgressionPath(worldIdToComplete, worldNameToComplete)
                        local unlockQueue = {}

                        for _, zoneInPath in ipairs(progressionPath) do
                            if not DoesPlayerOwnZone(zoneInPath.Name) then
                                table.insert(unlockQueue, zoneInPath)
                            end
                        end

                        if #unlockQueue > 0 then
                            if Workspace.Gravity == originalGravity then Workspace.Gravity = 0 end
                            UnlockZoneQueue(unlockQueue, char)
                        end

                        State.nextWorldName = State.worldMaps.idToName[worldIdToComplete + 1]
                        if State.nextWorldName and not DoesPlayerOwnWorld(State.nextWorldName) then
                            State.BlockUntil = tick() + 3
                            Network:InvokeServer("BuyWorld", State.nextWorldName)
                            task.wait(1)
                        end
                    end

                    State.BlockUntil = tick() + 3
                    Network:InvokeServer("TeleportWorld", State.targetWorldName)
                    task.wait()

                    if not State.targetPath then
                        State.targetPath = GetProgressionPath(State.targetWorldId, State.targetWorldName)
                    end
                    State.targetUnlockQueue = {}
                    for _, zoneInPath in ipairs(State.targetPath) do
                        if not DoesPlayerOwnZone(zoneInPath.Name) then
                            table.insert(State.targetUnlockQueue, zoneInPath)
                        end
                        if zoneInPath.Name == targetZoneData.ZoneName then break end
                    end
                    
                    if #State.targetUnlockQueue > 0 then
                        if Workspace.Gravity == originalGravity then Workspace.Gravity = 0 end
                        UnlockZoneQueue(State.targetUnlockQueue, char)
                    end

                    State.BlockUntil = tick() + 3
                    Network:InvokeServer("TeleportZone", targetZoneData.ZoneName)
                end)
                
                Workspace.Gravity = originalGravity
                
                if not success then
                    State.BlockUntil = tick() + 3
                    Network:InvokeServer("TeleportZone", "Spawn")
                end
            end

            State.TeleportSection = State.Tabs.Teleport:AddSection("Zones")
            State.TeleportOnJoinSection = State.Tabs.Teleport:AddSection("Teleport on Join")

            local function GetDestinations()
                local list = {}
                
                State.worldArray = {}
                State.worldIndex = {}
                for name, data in pairs(Worlds) do
                    table.insert(State.worldArray, { Name = name, Data = data })
                    State.worldIndex[name] = data.Index or 0
                end

                table.sort(State.worldArray, function(a, b)
                    return (a.Data.Index or 0) < (b.Data.Index or 0)
                end)

                for _, w in ipairs(State.worldArray) do
                    list[#list+1] = {
                        DisplayName = w.Name .. " Spawn", ZoneName = "Spawn", World = w.Name, Price = 0, IsSpawn = true
                    }
                end

                for portalName, data in pairs(Portals) do
                    if portalName ~= "Spawn" then
                        local worldName = "Main"
                        if type(data.World) == "number" then
                            for _, w in ipairs(State.worldArray) do
                                if w.Data.Index == data.World then
                                    worldName = w.Name
                                    break
                                end
                            end
                        elseif type(data.World) == "string" then
                            worldName = data.World
                        end

                        list[#list+1] = {
                            DisplayName = portalName, ZoneName = portalName, World = worldName, Price = data.Price or 0, IsSpawn = false
                        }
                    end
                end

                table.sort(list, function(a, b)
                    if a.World ~= b.World then
                        return (State.worldIndex[a.World] or 0) < (State.worldIndex[b.World] or 0)
                    end
                    if a.IsSpawn ~= b.IsSpawn then
                        return a.IsSpawn
                    end
                    return (a.Price or 0) < (b.Price or 0)
                end)

                return list
            end

            State.allDestinations = GetDestinations()
            State.selectedJoinDest = State.allDestinations[1] and State.allDestinations[1].DisplayName

            local function PerformTeleport(destData)
                task.spawn(function()
                    
                    if destData.IsSpawn then
                        State.BlockUntil = tick() + 3
                        Network:InvokeServer("TeleportWorld", destData.World)
                        return
                    end

                    if DoesPlayerOwnZone(destData.ZoneName) then
                        State.BlockUntil = tick() + 3
                        Network:InvokeServer("TeleportWorld", destData.World)
                        task.wait()
                        State.BlockUntil = tick() + 3
                        Network:InvokeServer("TeleportZone", destData.ZoneName)
                    else
                        HandleUnlockSequence(destData)
                    end
                end)
            end

            for _, dest in ipairs(State.allDestinations) do
                local title = dest.IsSpawn and dest.DisplayName or dest.ZoneName .. " [" .. dest.World .. "]"
                State.TeleportSection:AddButton({ Title = title, Callback = function() PerformTeleport(dest) end })
            end

            State.destNames = {}; for _, v in ipairs(State.allDestinations) do table.insert(State.destNames, v.DisplayName) end

            State.TeleportOnJoinSection:Dropdown("TeleportOnJoinZone", {
                Title = "Select Destination", Values = State.destNames, Searchable = true, Default = State.selectedJoinDest, Callback = function(v) State.selectedJoinDest = v end
            })

            State.TeleportOnJoinSection:AddToggle("TeleportOnJoin", {
                Title = "Teleport on Join", Default = false, Callback = function(v)
                    if v then
                        task.spawn(function()
                            local char = State.LocalPlayer.Character or State.LocalPlayer.CharacterAdded:Wait()
                            if not char:FindFirstChild("HumanoidRootPart") then char:WaitForChild("HumanoidRootPart", 10) end
                            task.wait()

                            for _, d in ipairs(State.allDestinations) do if d.DisplayName == State.selectedJoinDest then State.targetDest = d; break end end
                            if not State.targetDest then return end
                            
                            if State.targetDest.IsSpawn then
                                State.BlockUntil = tick() + 3
                                Network:InvokeServer("TeleportWorld", State.targetDest.World)
                                return
                            end

                            if DoesPlayerOwnZone(State.targetDest.ZoneName) then
                                State.BlockUntil = tick() + 3
                                Network:InvokeServer("TeleportWorld", State.targetDest.World)
                                task.wait()
                                State.BlockUntil = tick() + 3
                                Network:InvokeServer("TeleportZone", State.targetDest.ZoneName)
                            else
                                State.unlockThread = task.spawn(HandleUnlockSequence, State.targetDest)
                                
                                State.startTime = os.clock()
                                while task.getStatus(State.unlockThread) ~= "dead" and (os.clock() - State.startTime) < 5 do
                                    task.wait(0.1)
                                end

                                if task.getStatus(State.unlockThread) ~= "dead" then
                                    task.cancel(State.unlockThread)
                                    workspace.Gravity = originalGravity
                                    State.BlockUntil = tick() + 3
                                    Network:InvokeServer("TeleportZone", "Spawn")
                                end
                            end
                        end)
                    end
                end
            })

            State.TeleportOnJoinSection:AddParagraph("TeleportOnJoinInfo", {
                Title = "Info", Content = "Enable this toggle and select a zone to automatically teleport when you join the game. Mainly used for auto execute/load.", TitleAlignment = "Middle"
            })

            State.EnchantSection = State.Tabs.Enchant:AddSection("Auto Enchant")
                        
            State.selectedEnchants, State.selectedEnchantPets = {}, {}
            State.enchantPetDropdown, State.enchantStatusParagraph = nil, nil
            State.autoEnchantEnabled, State.autoEnchantThread, State.periodicUpdateThread = false, nil, nil
            State.petDropdownMap = {}
            State.liveEnchantData = {}

            task.spawn(function()
                repeat task.wait() until Replication.Loaded and Replication.Data and Replication.Data.Pets
                for petId, petData in pairs(Replication.Data.Pets) do
                    State.liveEnchantData[petId] = petData.Enchant or ""
                end
                if State.enchantPetDropdown then
                    task.defer(function()
                        State.enchantPetDropdown:SetValues(getFormattedPetList())
                    end)
                end
            end)

            local function getEnchantNames()
                State.enchantList = {}
                if EnchantData and EnchantData.Enchants then
                    for enchantName, _ in pairs(EnchantData.Enchants) do
                        table.insert(State.enchantList, enchantName)
                    end
                end
                State.nameOrder = { Taps=1, Gems=2, Rebirths=3, Luck=4 }
                State.tierOrder = { I=1, II=2, III=3 }
                table.sort(State.enchantList, function(a, b)
                    State.nameA, State.tierA = a:match("^(.-) (I+)$")
                    State.nameB, State.tierB = b:match("^(.-) (I+)$")
                    if State.nameA and not State.nameB then return true end
                    if not State.nameA and State.nameB then return false end
                    if State.nameA and State.nameB then
                        State.oA = State.nameOrder[State.nameA] or 99
                        State.oB = State.nameOrder[State.nameB] or 99
                        if State.oA ~= State.oB then
                            return State.oA < State.oB
                        else
                            return (State.tierOrder[State.tierA] or 99) < (State.tierOrder[State.tierB] or 99)
                        end
                    end
                    return a < b
                end)
                return State.enchantList
            end

            local function getEffectiveMultiplier(petData)
                if petData.Multiplier1 then 
                    return tonumber(petData.Multiplier1) or 0 
                end

                local petName = petData.Name or "Unknown"
                State.petTier = petData.Tier or "Normal"
                State.petLevel = petData.Level or 1
                State.globalBestMulti = (Replication.Data.BestMultiplier and Replication.Data.BestMultiplier[1]) or 0
                State.petPercentage = PetStats:GetPercentage(petName)

                if State.petPercentage then
                     
                    State.base = (State.globalBestMulti * State.petPercentage) / 100
                    return PetStats:GetMulti(State.base, State.petTier, State.petLevel, petData)
                else
                     
                    return PetStats:GetMulti(petData.Multi1 or 0, State.petTier, State.petLevel, petData)
                end
            end

            local function getFormattedPetList()
                repeat task.wait() until Replication.Loaded and Replication.Data and Replication.Data.Pets
                State.petDropdownMap = {}
                State.petsToSort = {}
                for id, petData in pairs(Replication.Data.Pets) do
                    table.insert(State.petsToSort, petData)
                end
                table.sort(State.petsToSort, function(a, b)
                    return getEffectiveMultiplier(a) > getEffectiveMultiplier(b)
                end)
                State.formattedList = {}
                for i, petData in ipairs(State.petsToSort) do
                    local currentEnchant = State.liveEnchantData[petData.Id] or petData.Enchant or ""
                    local calcMulti = getEffectiveMultiplier(petData)
                    local petString = string.format("%s (x%s)", petData.Name or "Unknown", formatNumber(calcMulti))
                    if currentEnchant ~= "" then
                        petString = petString .. ": " .. currentEnchant
                    end
                    State.finalDropdownString = string.format("%d. %s", i, petString)
                    table.insert(State.formattedList, State.finalDropdownString)
                    State.petDropdownMap[State.finalDropdownString] = petData.Id
                end
                return State.formattedList
            end

            local function updateEnchantStatus()
                if not State.enchantStatusParagraph or State.autoEnchantEnabled then return end
                
                State.crystalCount = (Replication.Data.Items and Replication.Data.Items.EnchantCrystal) or 0
                local content = "Enchant Crystals: " .. tostring(State.crystalCount) .. "\n\n--- Selected Pets ---\n"
                State.groupedPets = {}
                State.hasSelection = false
                
                for petString, isSelected in pairs(State.selectedEnchantPets) do
                    if isSelected then
                        State.hasSelection = true
                        local petId = State.petDropdownMap[petString]
                        if petId and Replication.Data.Pets[petId] then
                            local petData = Replication.Data.Pets[petId]
                            local currentEnchant = State.liveEnchantData[petId] or petData.Enchant or ""
                            local calcMulti = getEffectiveMultiplier(petData)
                            local multiplierStr = formatNumber(calcMulti)
                            local livePetString = string.format("%s (x%s)", petData.Name or "Unknown", multiplierStr)
                            if currentEnchant ~= "" then
                                livePetString = livePetString .. ": " .. currentEnchant
                            end
                            State.groupedPets[livePetString] = (State.groupedPets[livePetString] or 0) + 1
                        else
                            State.strippedString = petString:match("^%d+%. (.+)") or petString
                            State.groupedPets[State.strippedString] = (State.groupedPets[State.strippedString] or 0) + 1
                        end
                    end
                end
                
                if not State.hasSelection then 
                    content = content .. "None" 
                else 
                    for pet, count in pairs(State.groupedPets) do 
                        content = content .. (count > 1 and tostring(count) .. "x " or "") .. pet .. "\n" 
                    end 
                end     
                pcall(function()
                    State.enchantStatusParagraph:SetContent(content)
                end)
            end

            State.EnchantSection:Dropdown("SelectEnchantsDropdown", { 
                Title = "Select Desired Enchant(s)", Values = getEnchantNames(), Multi = true, Searchable = true, Default = {}, Callback = function(v) 
                    State.selectedEnchants = v 
                end 
            })

            State.enchantPetDropdown = State.EnchantSection:Dropdown("SelectPetsDropdown", { 
                Title = "Select Pet(s) to Enchant", Values = getFormattedPetList(), Multi = true, Searchable = true, Default = {}, Callback = function(v) 
                    State.selectedEnchantPets = v
                    updateEnchantStatus() 
                end 
            })

            State.EnchantSection:AddButton({ 
                Title = "Refresh Pets", Callback = function() 
                    if State.enchantPetDropdown then 
                        State.enchantPetDropdown:SetValues(getFormattedPetList())
                        State.enchantPetDropdown:SetValue({})
                        State.selectedEnchantPets = {}
                        updateEnchantStatus() 
                    end 
                end 
            })

            State.AutoEnchantToggle = State.EnchantSection:AddToggle("AutoEnchantToggle", {
                Title = "Auto Enchant", Default = false, Callback = function(Value)
                    State.autoEnchantEnabled = Value

                    if State.periodicUpdateThread then
                        task.cancel(State.periodicUpdateThread)
                        State.periodicUpdateThread = nil
                    end
                    if State.autoEnchantThread then
                        task.cancel(State.autoEnchantThread)
                        State.autoEnchantThread = nil
                    end

                    if Value then
                        if not next(State.selectedEnchantPets) or not next(State.selectedEnchants) then
                            State.autoEnchantEnabled = false
                            task.defer(function()
                                task.wait()
                            end)
                            return
                        end

                        State.autoEnchantThread = task.spawn(function()
                            State.original_InvokeServer = Network.InvokeServer

                            local function setPetEnchant(petId, enchantName)
                                if Replication.Data and Replication.Data.Pets and Replication.Data.Pets[petId] then
                                    Replication.Data.Pets[petId].Enchant = enchantName
                                end
                                State.liveEnchantData[petId] = enchantName
                            end

                            local function getPetEnchantFromData(petId)
                                local petData = Replication.Data and Replication.Data.Pets and Replication.Data.Pets[petId]
                                if not petData then return nil end
                                return petData.Enchant or ""
                            end

                            local function getPetName(petId)
                                local petData = Replication.Data and Replication.Data.Pets and Replication.Data.Pets[petId]
                                return (petData and petData.Name) or "Unknown"
                            end

                            while State.autoEnchantEnabled do
                                repeat task.wait() until Replication.Loaded and Replication.Data and Replication.Data.Pets

                                State.crystalCount = (Replication.Data.Items and Replication.Data.Items.EnchantCrystal) or 0
                                if State.crystalCount <= 0 then
                                    task.defer(function()
                                        if State.enchantStatusParagraph then
                                            State.enchantStatusParagraph:SetContent("Out of Enchant Crystals! Checking again in 5 seconds.")
                                        end
                                    end)
                                    task.wait(5)
                                    continue
                                end

                                for petString, isSelected in pairs(State.selectedEnchantPets) do
                                    if isSelected then
                                        local petId = State.petDropdownMap[petString]
                                        if not (petId and Replication.Data.Pets[petId]) then
                                            State.selectedEnchantPets[petString] = nil
                                        end
                                    end
                                end

                                State.targetPetId = nil
                                for petString, isSelected in pairs(State.selectedEnchantPets) do
                                    if isSelected and State.autoEnchantEnabled then
                                        local petId = State.petDropdownMap[petString]
                                        if petId and Replication.Data.Pets[petId] then
                                            local currentEnchant = getPetEnchantFromData(petId) or ""
                                            if not State.selectedEnchants[currentEnchant] then
                                                State.targetPetId = petId
                                                break
                                            end
                                        end
                                    end
                                end

                                if not State.targetPetId then
                                    task.defer(function()
                                        if State.enchantStatusParagraph then
                                            State.enchantStatusParagraph:SetContent(
                                                "Enchant Crystals: " .. tostring(State.crystalCount) ..
                                                "\n\nAll selected pets have a desired enchant! Re-checking in 5s."
                                            )
                                        end
                                    end)
                                    task.wait(5)
                                    continue
                                end

                                if not State.targetName then
                                    State.targetName = getPetName(State.targetPetId)
                                end
                                State.lastEnchantResult = nil

                                task.defer(function()
                                    if State.enchantStatusParagraph then
                                        State.enchantStatusParagraph:SetContent(
                                            "Enchant Crystals: " .. tostring(State.crystalCount) ..
                                            "\n\nAttempting to enchant: " .. State.targetName ..
                                            "\n(Current: " .. tostring(getPetEnchantFromData(State.targetPetId) or "") .. ")"
                                        )
                                    end
                                end)

                                Network.InvokeServer = function(self, eventName, ...)
                                    local result = State.original_InvokeServer(self, eventName, ...)
                                    if eventName == "EnchantPet" and select(1, ...) == State.targetPetId then
                                        State.lastEnchantResult = result
                                        if type(result) == "string" then
                                             
                                            setPetEnchant(State.targetPetId, result)
                                        end
                                        Network.InvokeServer = State.original_InvokeServer
                                    end
                                    return result
                                end

                                pcall(Network.InvokeServer, Network, "EnchantPet", State.targetPetId)

                                State.timeout = 0
                                repeat
                                    task.wait(0.2)
                                    State.timeout += 0.2
                                until (State.lastEnchantResult ~= nil) or (State.timeout >= 5)

                                Network.InvokeServer = State.original_InvokeServer

                                if not State.lastEnchantResult then
                                    task.defer(function()
                                        if State.enchantStatusParagraph then
                                            State.enchantStatusParagraph:SetContent(
                                                "Enchant Crystals: " .. tostring(State.crystalCount) ..
                                                "\n\nHook timed out for: " .. State.targetName .. ". Retrying in 3s."
                                            )
                                        end
                                    end)
                                    task.wait(3)
                                else
                                     
                                    State.ok, State.EnchantModule = pcall(function()
                                        return require(State.LocalPlayer.PlayerScripts.Modules.Menus.Enchant)
                                    end)
                                    if State.ok and State.EnchantModule and State.EnchantModule.selectPet then
                                        pcall(State.EnchantModule.selectPet, State.targetPetId)
                                    end
                                end

                                task.wait(1)
                            end

                            Network.InvokeServer = State.original_InvokeServer
                        end)
                    else
                        State.periodicUpdateThread = task.spawn(function()
                            while not State.autoEnchantEnabled do
                                updateEnchantStatus()
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            State.enchantStatusParagraph = State.EnchantSection:AddParagraph("EnchantStatus", { 
                Title = "Status", Content = "Loading..." 
            })

            task.spawn(function() 
                updateEnchantStatus() 
            end)

            Replication:Connect("Items", function() 
                if not State.autoEnchantEnabled then 
                    updateEnchantStatus() 
                end 
            end)
                        
            State.UnlockZonesSection = State.Tabs.Misc:AddSection("Unlock Zones")

            local function DoesPlayerOwnZone(zoneName)
                if not Replication.Loaded then return false end
                return Replication.Data and Replication.Data.Portals and Replication.Data.Portals[zoneName] == true
            end

            local function GetWorldProgressionPath(worldId)
                State.path = {}
                
                pcall(function()
                    if IslandParts then
                        for zoneName, portalInfo in pairs(Portals) do
                            if portalInfo.World == worldId then
                                local islandPart = IslandParts:FindFirstChild(zoneName)
                                if islandPart then
                                    table.insert(State.path, { Name = zoneName, Part = islandPart, Height = islandPart.Position.Y })
                                end
                            end
                        end
                    end
                end)
                
                table.sort(State.path, function(a, b) return a.Height < b.Height end)
                return State.path
            end

            local function CreateWorldUnlockButtons()
                
                State.worldNameToId = {}
                State.worldListForButtons = {}
                State.worldProgression = {}

                for name, data in pairs(Worlds) do table.insert(State.worldProgression, { Name = name, Price = data.Price or 0 }) end
                table.sort(State.worldProgression, function(a, b) return a.Price < b.Price end)
                for id, data in ipairs(State.worldProgression) do
                    State.worldNameToId[data.Name] = id
                    table.insert(State.worldListForButtons, data.Name)
                end

                for _, worldName in ipairs(State.worldListForButtons) do
                    State.UnlockZonesSection:AddButton({
                        Title = string.format("Unlock All Zones (%s)", worldName), Callback = function()
                            task.spawn(function()
                                pcall(function() Network:InvokeServer("TeleportWorld", worldName) end)

                                task.wait(1)

                                Network = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("Network"))
                                local char = State.LocalPlayer.Character or State.LocalPlayer.CharacterAdded:Wait()
                                if not char:FindFirstChild("HumanoidRootPart") then char:WaitForChild("HumanoidRootPart", 10) end

                                State.targetWorldId = State.worldNameToId[worldName]
                                if not State.targetWorldId then return end
                                
                                local progressionPath = GetWorldProgressionPath(State.targetWorldId)
                                State.zonesToUnlock = {}
                                
                                for _, zoneInPath in ipairs(progressionPath) do
                                    if not DoesPlayerOwnZone(zoneInPath.Name) then
                                        table.insert(State.zonesToUnlock, zoneInPath)
                                    end
                                end

                                if #State.zonesToUnlock == 0 then return end

                                workspace.Gravity = 0
                                
                                for i, zoneToUnlock in ipairs(State.zonesToUnlock) do
                                    if not char or not char.Parent then char = State.LocalPlayer.Character or State.LocalPlayer.CharacterAdded:Wait() end
                                    
                                    pcall(function()
                                        char:PivotTo(zoneToUnlock.Part:GetPivot())
                                    end)
                                    
                                    local unlocked = false
                                    for _ = 1, 10 do
                                        if DoesPlayerOwnZone(zoneToUnlock.Name) then
                                            unlocked = true
                                            break
                                        end
                                        task.wait(0.5)
                                    end
                                    
                                    if not unlocked then
                                        pcall(function() char:PivotTo(zoneToUnlock.Part:GetPivot()) end)
                                        task.wait()
                                    end
                                end
                                
                                workspace.Gravity = originalGravity
                            end)
                        end
                    })
                end
            end

            CreateWorldUnlockButtons()

            State.WorldChestsSection = State.Tabs.Misc:AddSection("World Chests")

            State.autoClaimWorldChestsEnabled = false
            State.autoClaimWorldChestsThread = nil
            State.autoClaimWorldChestsOriginalGravity = nil

            State.ClaimWorldChestsToggle = State.WorldChestsSection:AddToggle("ClaimWorldChests", {
                Title = "Claim World Chests", Default = false, Callback = function(Value)
                    State.autoClaimWorldChestsEnabled = Value

                    if State.autoClaimWorldChestsThread then
                        task.cancel(State.autoClaimWorldChestsThread)
                        State.autoClaimWorldChestsThread = nil
                    end

                    if not Value then
                        if State.autoClaimWorldChestsOriginalGravity then
                            workspace.Gravity = State.autoClaimWorldChestsOriginalGravity
                            State.autoClaimWorldChestsOriginalGravity = nil
                        end
                        return
                    end

                    local char = State.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        if not State.startCFrame then
                            State.startCFrame = char:GetPivot()
                        end
                    end

                    State.autoClaimWorldChestsThread = task.spawn(function()

                        State.autoClaimWorldChestsOriginalGravity = originalGravity
                        workspace.Gravity = 0

                        local function isVisibleHitbox(hitbox)
                            if not hitbox or not hitbox:IsA("BasePart") then
                                return false
                            end
                            if hitbox.Transparency >= 1 then
                                return false
                            end

                            State.vp, State.onScreen = workspace.CurrentCamera:WorldToViewportPoint(hitbox.Position)
                            return State.onScreen and State.vp.Z > 0
                        end

                        local function collectChestsForPart(partName)
                            State.chests = {}
                            State.seen = {}

                            local function addChest(chest, requireVisible)
                                if not chest or State.seen[chest] or chest.Name ~= "ClickerChest" then
                                    return
                                end

                                local hitbox = chest:FindFirstChild("Hitbox")
                                if not hitbox or not hitbox:FindFirstChild("TouchInterest") then
                                    return
                                end

                                if requireVisible and not isVisibleHitbox(hitbox) then
                                    return
                                end

                                State.seen[chest] = true
                                table.insert(State.chests, chest)
                            end

                            for _, obj in ipairs(workspace:GetDescendants()) do
                                if obj.Name == "ClickerChest" then
                                    addChest(obj, true)
                                end
                            end

                            if worldChests then
                                for _, obj in ipairs(worldChests:GetDescendants()) do
                                    if obj.Name == "ClickerChest" then
                                        addChest(obj, false)
                                    end
                                end
                            end

                            if partFolder then
                                if not State.targetPart then
                                    State.targetPart = partFolder:FindFirstChild(partName)
                                end
                                if State.targetPart then
                                    for _, obj in ipairs(State.targetPart:GetDescendants()) do
                                        if obj.Name == "ClickerChest" then
                                            addChest(obj, false)
                                        end
                                    end
                                end
                            end

                            return State.chests
                        end

                        local function snapAndClaimChestList(chestList)
                            local c = State.LocalPlayer.Character
                            if not State.myHrp then
                                State.myHrp = c and c:FindFirstChild("HumanoidRootPart")
                            end
                            if not State.myHrp then
                                return
                            end

                            for _, chest in ipairs(chestList) do
                                if not State.autoClaimWorldChestsEnabled then
                                    break
                                end

                                local hitbox = chest:FindFirstChild("Hitbox")
                                if hitbox and hitbox:FindFirstChild("TouchInterest") then
                                    pcall(function()
                                        hitbox.CFrame = State.myHrp.CFrame
                                        firetouchinterest(State.myHrp, hitbox, 0)
                                        task.wait()
                                        firetouchinterest(State.myHrp, hitbox, 1)
                                    end)
                                end
                            end
                        end

                        local function getSortedIslandParts()
                            local partList = {}
                            for _, part in ipairs(IslandParts:GetChildren()) do
                                if part:IsA("BasePart") or part:IsA("Model") then
                                    table.insert(partList, part)
                                end
                            end

                            table.sort(partList, function(a, b)
                                return a.Name < b.Name
                            end)

                            return partList
                        end

                        while State.autoClaimWorldChestsEnabled do
                            local partList = getSortedIslandParts()

                            for _, part in ipairs(partList) do
                                if not State.autoClaimWorldChestsEnabled then
                                    break
                                end

                                State.currentChar = State.LocalPlayer.Character
                                local hrp = State.currentChar and State.currentChar:FindFirstChild("HumanoidRootPart")
                                if State.currentChar and hrp and part then
                                    pcall(function()
                                        State.currentChar:PivotTo(part:GetPivot())
                                    end)
                                    task.wait(1)
                                end

                                local chestList = collectChestsForPart(part.Name)
                                snapAndClaimChestList(chestList)
                            end

                            if State.startCFrame and State.autoClaimWorldChestsEnabled then
                                State.returnChar = State.LocalPlayer.Character
                                if State.returnChar and State.returnChar:FindFirstChild("HumanoidRootPart") then
                                    pcall(function()
                                        State.returnChar:PivotTo(State.startCFrame)
                                    end)
                                end
                            end

                            State.waited = 0
                            while State.autoClaimWorldChestsEnabled and State.waited < 120 do
                                local chestList = collectChestsForPart("Spawn")
                                snapAndClaimChestList(chestList)
                                task.wait(10)
                                State.waited = State.waited + 10
                            end
                        end

                        workspace.Gravity = originalGravity
                        if State.autoClaimWorldChestsOriginalGravity == originalGravity then
                            State.autoClaimWorldChestsOriginalGravity = nil
                        end
                    end)
                end
            })

            State.autoChestMagnetEnabled = false
            State.autoChestMagnetThread = nil

            State.ChestMagnetToggle = State.WorldChestsSection:AddToggle("ChestMagnet", {
                Title = "Chest Magnet (no teleport)", Default = false, Callback = function(Value)
                    State.autoChestMagnetEnabled = Value

                    if State.autoChestMagnetThread then
                        task.cancel(State.autoChestMagnetThread)
                        State.autoChestMagnetThread = nil
                    end

                    if not Value then
                        return
                    end

                    State.autoChestMagnetThread = task.spawn(function()
                        while State.autoChestMagnetEnabled do
                            local char = State.LocalPlayer.Character
                            local hrp = char and char:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                for _, obj in ipairs(workspace:GetDescendants()) do
                                    if not State.autoChestMagnetEnabled then
                                        break
                                    end

                                    if obj.Name == "ClickerChest" then
                                        local hitbox = obj:FindFirstChild("Hitbox")
                                        if hitbox and hitbox:IsA("BasePart") then
                                            pcall(function()
                                                hitbox.CFrame = hrp.CFrame
                                            end)
                                        end
                                    end
                                end
                            end

                            task.wait(5)
                        end
                    end)
                end
            })

            State.AutoSpinSection = State.Tabs.Misc:AddSection("Valentine Wheel")

            State.autoSpinEnabled = false
            State.autoSpinThread = nil

            State.AutoSpinSection:AddToggle("AutoSpinWheelToggle", {
                Title = "Auto Spin Valentine Wheel", Default = false, Callback = function(Value)
                    State.autoSpinEnabled = Value

                    if State.autoSpinThread then
                        task.cancel(State.autoSpinThread)
                        State.autoSpinThread = nil
                    end
                    
                    if Value then
                        State.autoSpinThread = task.spawn(function()
                            while State.autoSpinEnabled do
                                pcall(function()
                                    Network:InvokeServer("SpinWheel")
                                end)
                                task.wait(1)
                            end
                        end)
                    end
                end
            })

            RankRewardSection = State.Tabs.Misc:AddSection("Rank Reward")

            State.autoClaimRankRewardEnabled = false
            State.autoClaimRankRewardThread = nil

            State.ClaimRankRewardToggle = RankRewardSection:AddToggle("ClaimRankReward", {
                Title = "Claim Rank Reward", Default = false, Callback = function(Value)
                    State.autoClaimRankRewardEnabled = Value
                    
                    if State.autoClaimRankRewardThread then
                        task.cancel(State.autoClaimRankRewardThread)
                        State.autoClaimRankRewardThread = nil
                    end
                    
                    if Value then
                        State.autoClaimRankRewardThread = task.spawn(function()
                            
                            while State.autoClaimRankRewardEnabled do
                                pcall(function()
                                    Network:InvokeServer("ClaimRankReward")
                                end)
                                
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            CodesSection = State.Tabs.Misc:AddSection("Codes")

            CodesSection:AddButton({
                Title = "Redeem All", Callback = function()
                    State.codes = {"russo", "lucky", "tacos", "enchant", "SPEEDYTOTEM", "LUCKYTOTEM", "TELEPORT", "VALENTINES"}
                    for _, code in ipairs(State.codes) do
                        task.spawn(function()
                            pcall(function()
                                Network:InvokeServer("RedeemCode", code)
                            end)
                        end)
                    end
                end
            })

            State.QuestsSection = State.Tabs.Misc:AddSection("Quests")

            State.autoClaimQuestsEnabled = false
            State.autoClaimQuestsThread = nil

            State.ClaimQuestsToggle = State.QuestsSection:AddToggle("ClaimQuests", {
                Title = "Auto Claim Quests", Default = false, Callback = function(Value)
                    State.autoClaimQuestsEnabled = Value
                    
                    if State.autoClaimQuestsThread then
                        task.cancel(State.autoClaimQuestsThread)
                        State.autoClaimQuestsThread = nil
                    end
                    
                    if Value then
                        State.autoClaimQuestsThread = task.spawn(function()
                            
                            while State.autoClaimQuestsEnabled do
                                repeat task.wait() until Replication.Loaded and Replication.Data

                                if Replication.Data.Quests then
                                    for questName, questData in pairs(Replication.Data.Quests) do
                                        local questInfo = Quests[questName]
                                        
                                        if questInfo then
                                            local completed = questData.Completed or ((questData.Amount or 0) >= (questInfo.Goal or 0))
                                            local claimed = questData.Claimed or false

                                            if State.autoClaimQuestsEnabled and completed and not claimed then
                                                pcall(function()
                                                    local hitbox = List[questName].Hitbox
                                                    for _, connection in pairs(getconnections(hitbox.Activated)) do
                                                        connection:Fire()
                                                    end
                                                end)
                                                task.wait(0.5)
                                            end
                                        end
                                    end
                                end
                                
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            State.MinigameSection = State.Tabs.Misc:AddSection("Dig Minigame")

            State.autoMinigameEnabled = false
            State.autoMinigameThread = nil

            State.MinigameSection:AddToggle("AutoMinigameToggle", {
                Title = "Auto Dig", Default = false, Callback = function(Value)
                    State.autoMinigameEnabled = Value
                    
                    if State.autoMinigameThread then
                        task.cancel(State.autoMinigameThread)
                        State.autoMinigameThread = nil
                    end
                    
                    if Value then
                        State.autoMinigameThread = task.spawn(function()
                            
                            while State.autoMinigameEnabled do
                                pcall(function()
                                    Network:InvokeServer("StartMinigame", "DigGame")
                                    task.wait(0.25)
                                    Network:InvokeServer("FinishMinigame", "DigGame")
                                end)
                                task.wait(1) 
                            end
                        end)
                    end
                end
            })

            State.MiscSection = State.Tabs.Misc:AddSection("Travelling Merchants")

            local function getFriendlyName(itemId)
                if Items[itemId] and Items[itemId].Name then
                    return Items[itemId].Name
                else
                    return itemId
                end
            end

            State.allMerchantItems = {}
            State.itemToMerchantMap = {}

            for merchantName, merchantData in pairs(TravellingMerchants.Merchants) do
                local displayName = merchantData.DisplayName or merchantName
                
                for _, item in ipairs(merchantData.Items) do
                    local itemName = item.Name
                    local price = item.Price or 0
                    local currency = item.Currency or "Clicks"
                    
                    local dropdownLabel = string.format("%s (%dx %s) - %s", itemName, price, currency, displayName)
                    table.insert(State.allMerchantItems, dropdownLabel)
                    
                    State.itemToMerchantMap[dropdownLabel] = {
                        merchantName = merchantName, itemName = itemName
                    }
                end
            end

            table.sort(State.allMerchantItems)

            State.selectedMerchantItems = {}
            State.autoBuyEnabled = false
            State.autoBuyThread = nil

            State.MerchantItemsDropdown = State.MiscSection:AddDropdown("MerchantItemsDropdown", {
                Title = "Select Items", Values = State.allMerchantItems, Multi = true, Searchable = true, Default = {}, Callback = function(Value)
                    State.selectedMerchantItems = Value
                end
            })

            State.MiscSection:AddButton({
                Title = "Select All", Callback = function()
                    State.allSelected = {}
                    for _, itemLabel in ipairs(State.allMerchantItems) do
                        State.allSelected[itemLabel] = true
                    end
                    State.selectedMerchantItems = State.allSelected
                    State.MerchantItemsDropdown:SetValue(State.allSelected)
                end
            })

            State.MiscSection:AddToggle("AutoBuyMerchant", {
                Title = "Auto Buy", Default = false, Callback = function(Value)
                    State.autoBuyEnabled = Value
                    
                    if State.autoBuyThread then
                        task.cancel(State.autoBuyThread)
                        State.autoBuyThread = nil
                    end
                    
                    if Value then
                        State.autoBuyThread = task.spawn(function()
                            State.MerchantModule = require(State.LocalPlayer.PlayerScripts.Modules.Menus.Merchant)
                            
                            local function getCurrency(type)
                                if type == "Gems" then
                                    return Replication.Data.Statistics.Gems or 0
                                else
                                    return Replication.Data.Statistics.Clicks or 0
                                end
                            end
                            
                            while State.autoBuyEnabled do
                                local boughtSomething = false
                                local activeMerchants = State.MerchantModule:GetActiveMerchants()
                                
                                if activeMerchants then
                                    for dropdownLabel, _ in pairs(State.selectedMerchantItems) do
                                        local itemInfo = State.itemToMerchantMap[dropdownLabel]
                                        
                                        if itemInfo then
                                            local merchantName = itemInfo.merchantName
                                            local itemName = itemInfo.itemName
                                            
                                            local merchantData = activeMerchants[merchantName]
                                            local merchantInfo = TravellingMerchants.Merchants[merchantName]
                                            
                                            if merchantData and merchantInfo then
                                                for _, item in ipairs(merchantInfo.Items) do
                                                    if item.Name == itemName then
                                                        local price = item.Price or 0
                                                        local currency = item.Currency or "Clicks"
                                                        
                                                        if currency == "Gems" and merchantData.gemPrices and merchantData.gemPrices[itemName] then
                                                            price = merchantData.gemPrices[itemName]
                                                        end
                                                        
                                                        State.stock = merchantData.stock[itemName] or 0
                                                        State.playerMoney = getCurrency(currency)
                                                        State.canAfford = (State.stock > 0) and (State.playerMoney >= price)
                                                        
                                                        if State.canAfford then
                                                            Network:InvokeServer("PurchaseMerchantItem", merchantName, itemName)
                                                            boughtSomething = true
                                                        end
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                
                                if boughtSomething then
                                    task.wait(0.2)
                                else
                                    task.wait(5)
                                end
                            end
                        end)
                    end
                end
            })

            State.AutoBuyPotionsSection = State.Tabs.Misc:AddSection("Auto Buy Potions")

            State.selectedPotionAmounts = {}
            State.autoBuyPotionsEnabled = false
            State.autoBuyPotionsThread = nil

            State.PotionAmountsDropdown = State.AutoBuyPotionsSection:Dropdown("PotionAmounts", {
                Title = "Select Amounts", Values = {"1x", "3x", "10x"}, Multi = true, Default = {}, Callback = function(value)
                    State.selectedPotionAmounts = {}
                    
                    if type(value) == "table" then
                        for amountStr, isSelected in pairs(value) do
                            if isSelected then
                                local amount = tonumber(amountStr:match("(%d+)x"))
                                if amount then
                                    table.insert(State.selectedPotionAmounts, amount)
                                end
                            end
                        end
                        table.sort(State.selectedPotionAmounts)
                    end
                end
            })

            State.AutoBuyPotionsToggle = State.AutoBuyPotionsSection:AddToggle("AutoBuyPotions", {
                Title = "Auto Buy Potions", Default = false, Callback = function(Value)
                    State.autoBuyPotionsEnabled = Value
                    
                    if State.autoBuyPotionsThread then
                        task.cancel(State.autoBuyPotionsThread)
                        State.autoBuyPotionsThread = nil
                    end
                    
                    if Value then
                        State.autoBuyPotionsThread = task.spawn(function()
                            
                            while State.autoBuyPotionsEnabled do
                                for _, amount in ipairs(State.selectedPotionAmounts) do
                                    if State.autoBuyPotionsEnabled then
                                        pcall(function()
                                            Network:InvokeServer("BuyPotionMachine", amount)
                                        end)
                                        task.wait(1) 
                                    end
                                end

                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            State.AutoUseBoostsSection = State.Tabs.Misc:AddSection("Auto Use Boosts")

            State.selectedBoosts = {}
            State.autoUseBoostsEnabled = false
            State.autoUseBoostsThread = nil
            State.boostsDropdown = nil

            local function getAllBoostNames()
                State.boostList = {}
                
                for boostName, boostData in pairs(Boosts) do
                    if type(boostData) == "table" then
                        table.insert(State.boostList, boostName)
                    end
                end
                
                table.sort(State.boostList)
                return State.boostList
            end

            State.boostsDropdown = State.AutoUseBoostsSection:Dropdown("BoostsDropdown", {
                Title = "Select Boosts", Values = getAllBoostNames(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedBoosts = {}
                    
                    if type(value) == "table" then
                        for boostName, isSelected in pairs(value) do
                            if isSelected then
                                State.selectedBoosts[boostName] = true
                            end
                        end
                    end
                end
            })

            State.AutoUseBoostsToggle = State.AutoUseBoostsSection:AddToggle("AutoUseBoosts", {
                Title = "Auto Use Boosts", Default = false, Callback = function(Value)
                    State.autoUseBoostsEnabled = Value
                    
                    if State.autoUseBoostsThread then
                        task.cancel(State.autoUseBoostsThread)
                        State.autoUseBoostsThread = nil
                    end
                    
                    if Value then
                        State.autoUseBoostsThread = task.spawn(function()
                            
                            while State.autoUseBoostsEnabled do
                                repeat task.wait() until Replication.Loaded and Replication.Data
                            
                                for boostName, isSelected in pairs(State.selectedBoosts) do
                                    if isSelected and State.autoUseBoostsEnabled then
                                        local ownedAmount = 0
                                        if Replication.Data.Boosts and Replication.Data.Boosts[boostName] then
                                            ownedAmount = Replication.Data.Boosts[boostName]
                                        end
                                    
                                        State.isActive = false
                                        if Replication.Data.ActiveBoosts and Replication.Data.ActiveBoosts[boostName] then
                                            State.isActive = true
                                            local timeLeft = Replication.Data.ActiveBoosts[boostName]
                                        end

                                        if ownedAmount > 0 and not State.isActive then
                                            
                                            success, State.err = pcall(function()
                                                Network:InvokeServer("UseBoost", boostName)
                                            end)
                                            
                                            if success then
                                            end
                                            
                                            task.wait(0.5)
                                        elseif ownedAmount == 0 then
                                        end
                                    end
                                end
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            local function getAllPetsSorted()
                State.pets = {}
                if Replication.Data and Replication.Data.Pets then
                    for id, data in pairs(Replication.Data.Pets) do
                        if not data.Locked then
                            table.insert(State.pets, {
                                data = data, power = getPower(data)
                            })
                        end
                    end
                end
                table.sort(State.pets, function(a, b) return a.power < b.power end)
                return State.pets
            end
                        
            State.EquipBestSection = State.Tabs.Misc:AddSection("Equip Best")

            local function getPower(petData)
                if petData.Multiplier1 and tonumber(petData.Multiplier1) > 0 then
                    return tonumber(petData.Multiplier1)
                end
                local petName = petData.Name or "Unknown"
                State.petTier = petData.Tier or "Normal"
                State.petLevel = petData.Level or 1
                State.globalBestMulti = (Replication.Data.BestMultiplier and Replication.Data.BestMultiplier[1]) or 0
                State.petPercentage = PetStats:GetPercentage(petName)
                State.baseStat = State.petPercentage and (State.globalBestMulti * State.petPercentage / 100) or (petData.Multi1 or 0)
                return PetStats:GetMulti(State.baseStat, State.petTier, State.petLevel, petData)
            end

            local function getMaxPotential(petData)
                local petName = petData.Name or "Unknown"
                State.petTier = petData.Tier or "Normal"
                State.globalBestMulti = (Replication.Data.BestMultiplier and Replication.Data.BestMultiplier[1]) or 0
                State.petRarity = PetStats:GetRarity(petName)
                State.maxLevel = PetStats:GetMaxLevel(State.petRarity)
                State.petPercentage = PetStats:GetPercentage(petName)
                State.baseStat = State.petPercentage and (State.globalBestMulti * State.petPercentage / 100) or (petData.Multi1 or 0)
                return PetStats:GetMulti(State.baseStat, State.petTier, State.maxLevel, petData)
            end

            local function equipTargetSet(targetIds)
                State.currentPets = Replication.Data.Pets
                State.toUnequip = {}
                State.toEquip = {}

                for petId, petData in pairs(State.currentPets) do
                    if petData.Equipped and not targetIds[petId] then
                        table.insert(State.toUnequip, petId)
                    end
                end

                for petId, _ in pairs(targetIds) do
                    if State.currentPets[petId] and not State.currentPets[petId].Equipped then
                        table.insert(State.toEquip, petId)
                    end
                end

                for _, petId in ipairs(State.toUnequip) do
                    task.spawn(function()
                        Signal.Fire("UnequipPetUI", petId)
                        pcall(Network.InvokeServer, Network, "Unequip", petId)
                    end)
                end

                for _, petId in ipairs(State.toEquip) do
                    task.spawn(function()
                        Signal.Fire("EquipPetUI", petId)
                        pcall(Network.InvokeServer, Network, "Equip", petId)
                    end)
                end
            end

            State.autoEquipBestEnabled = false
            State.autoEquipCalculatedBestEnabled = false
            State.autoEquipLowestLevelEnabled = false
            State.autoEquipAndLevelEnabled = false

            State.autoEquipBestThread = nil
            State.autoEquipCalculatedBestThread = nil
            State.autoEquipLowestLevelThread = nil
            State.autoEquipAndLevelThread = nil

            State.selectedPetsToLevel = {}
            State.levelToMaxDropdown = nil

            local function getAllPetVariations()
                State.finalVariations = {}
                pcall(function()
                    State.petNameSet = {}
                    for eggName, eggData in pairs(Eggs) do
                        if type(eggData) == "table" and eggData.Pets and type(eggData.Pets) == "table" then
                            for petName, chance in pairs(eggData.Pets) do State.petNameSet[petName] = true end
                        end
                    end
                    State.petList = {}
                    for petName in pairs(State.petNameSet) do table.insert(State.petList, petName) end
                    table.sort(State.petList)
                    State.tiers = {"Normal", "Golden", "Rainbow"}
                    State.mutations = {}
                    State.moduleSuccess, State.mutationsModule = pcall(require, ReplicatedStorage.Game.PetStats.Mutations)
                    if State.moduleSuccess and type(State.mutationsModule) == "table" then
                        for mutationName, _ in pairs(State.mutationsModule) do table.insert(State.mutations, mutationName) end
                        table.sort(State.mutations)
                    else
                        State.mutations = {"Electric", "Void"}
                    end
                    for _, petName in ipairs(State.petList) do
                        for _, tier in ipairs(State.tiers) do table.insert(State.finalVariations, string.format("%s %s", tier, petName)) end
                        for _, mutation in ipairs(State.mutations) do table.insert(State.finalVariations, string.format("%s Rainbow %s", mutation, petName)) end
                    end
                end)
                return State.finalVariations
            end

            local function getPetDisplayName(petData)
                local name = petData.Name or ""
                local tier = petData.Tier or "Normal"
                local mutation = petData.Mutation
                if mutation and tier == "Rainbow" then
                    return string.format("%s Rainbow %s", mutation, name)
                else
                    return string.format("%s %s", tier, name)
                end
            end

            local function runCalculatedBestLogic()
                pcall(function()
                    repeat task.wait() until Replication.Loaded and Replication.Data
                    State.MAX = Replication.Data.EquipLimit or 5
                    State.petList = {}
                    for id, data in pairs(Replication.Data.Pets) do table.insert(State.petList, {id = id, pot = getMaxPotential(data), cur = getPower(data)}) end
                    table.sort(State.petList, function(a, b) return a.pot == b.pot and a.cur > b.cur or a.pot > b.pot end)
                    local targetIds = {}
                    for i = 1, math.min(State.MAX, #State.petList) do targetIds[State.petList[i].id] = true end
                    equipTargetSet(targetIds)
                end)
            end

            AutoEquipBestToggle = State.EquipBestSection:AddToggle("AutoEquipBest", {
                Title = "Auto Equip Best Pets", Default = false, Callback = function(Value)
                    State.autoEquipBestEnabled = Value
                    if Value then
                        AutoEquipCalculatedBestToggle:SetValue(false)
                        AutoEquipLowestLevelToggle:SetValue(false)
                        AutoEquipAndLevelToggle:SetValue(false)
                        State.autoEquipBestThread = task.spawn(function()
                            while State.autoEquipBestEnabled do
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data
                                    State.bestIds = Network:InvokeServer("EquipBest")
                                    if State.bestIds and type(State.bestIds) == "table" then
                                        local targetIds = {}
                                        for _, id in ipairs(State.bestIds) do targetIds[id] = true end
                                        equipTargetSet(targetIds)
                                    end
                                end)
                                task.wait(5)
                            end
                        end)
                    elseif State.autoEquipBestThread then
                        task.cancel(State.autoEquipBestThread)
                        State.autoEquipBestThread = nil
                    end
                end
            })

            AutoEquipCalculatedBestToggle = State.EquipBestSection:AddToggle("AutoEquipCalculatedBest", {
                Title = "Auto Equip Calculated Best", Default = false, Callback = function(Value)
                    State.autoEquipCalculatedBestEnabled = Value
                    if Value then
                        AutoEquipBestToggle:SetValue(false)
                        AutoEquipLowestLevelToggle:SetValue(false)
                        AutoEquipAndLevelToggle:SetValue(false)
                        State.autoEquipCalculatedBestThread = task.spawn(function()
                            while State.autoEquipCalculatedBestEnabled do
                                runCalculatedBestLogic()
                                task.wait(5)
                            end
                        end)
                    elseif State.autoEquipCalculatedBestThread then
                        task.cancel(State.autoEquipCalculatedBestThread)
                        State.autoEquipCalculatedBestThread = nil
                    end
                end
            })

            AutoEquipLowestLevelToggle = State.EquipBestSection:AddToggle("AutoEquipLowestLevel", {
                Title = "Auto Equip Lowest Level", Default = false, Callback = function(Value)
                    State.autoEquipLowestLevelEnabled = Value
                    if Value then
                        AutoEquipBestToggle:SetValue(false)
                        AutoEquipCalculatedBestToggle:SetValue(false)
                        AutoEquipAndLevelToggle:SetValue(false)
                        State.autoEquipLowestLevelThread = task.spawn(function()
                            while State.autoEquipLowestLevelEnabled do
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data
                                    State.MAX = Replication.Data.EquipLimit or 5
                                    State.leveling, State.maxed = {}, {}
                                    for id, data in pairs(Replication.Data.Pets) do
                                        if not data.Test1122 then
                                            local maxLvl = PetStats:GetMaxLevel(PetStats:GetRarity(data.Name))
                                            if (data.Level or 1) < maxLvl then
                                                table.insert(State.leveling, {id = id, lvl = data.Level or 1})
                                            else
                                                table.insert(State.maxed, {id = id, pwr = getPower(data)})
                                            end
                                        end
                                    end
                                    table.sort(State.leveling, function(a, b) return a.lvl < b.lvl end)
                                    table.sort(State.maxed, function(a, b) return a.pwr > b.pwr end)
                                    local targetIds, count = {}, 0
                                    for _, p in ipairs(State.leveling) do if count < State.MAX then targetIds[p.id] = true count = count + 1 end end
                                    for _, p in ipairs(State.maxed) do if count < State.MAX then targetIds[p.id] = true count = count + 1 end end
                                    equipTargetSet(targetIds)
                                end)
                                task.wait(5)
                            end
                        end)
                    elseif State.autoEquipLowestLevelThread then
                        task.cancel(State.autoEquipLowestLevelThread)
                        State.autoEquipLowestLevelThread = nil
                    end
                end
            })

            State.levelToMaxDropdown = State.EquipBestSection:AddDropdown("LevelToMaxDropdown", {
                Title = "Select Pet Variations to Level", Values = getAllPetVariations(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedPetsToLevel = value
                end
            })

             AutoEquipAndLevelToggle = State.EquipBestSection:AddToggle("AutoEquipAndLevel", {
                Title = "Auto Equip and Level to Max", Default = false, Callback = function(Value)
                    State.autoEquipAndLevelEnabled = Value
                    if State.autoEquipAndLevelThread then
                        task.cancel(State.autoEquipAndLevelThread)
                        State.autoEquipAndLevelThread = nil
                    end

                    if Value then
                        AutoEquipBestToggle:SetValue(false)
                        AutoEquipCalculatedBestToggle:SetValue(false)
                        AutoEquipLowestLevelToggle:SetValue(false)
                        State.autoEquipAndLevelThread = task.spawn(function()
                            while State.autoEquipAndLevelEnabled do
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data and Replication.Data.Pets

                                    State.MAX = Replication.Data.EquipLimit or 5
                                    local targetIds = {}

                                    State.petsToLevel = {}
                                    if next(State.selectedPetsToLevel) then
                                        for id, data in pairs(Replication.Data.Pets) do
                                            if not data.Test1122 then
                                                local displayName = getPetDisplayName(data)
                                                local maxLvl = PetStats:GetMaxLevel(PetStats:GetRarity(data.Name))
                                                if State.selectedPetsToLevel[displayName] and (data.Level or 1) < maxLvl then
                                                    table.insert(State.petsToLevel, {id = id, data = data})
                                                end
                                            end
                                        end
                                    end

                                    if #State.petsToLevel == 0 then
                                        runCalculatedBestLogic()
                                        return
                                    end

                                    table.sort(State.petsToLevel, function(a, b)
                                        State.potA = getMaxPotential(a.data)
                                        State.potB = getMaxPotential(b.data)
                                        return State.potA == State.potB and (a.data.Level or 1) > (b.data.Level or 1) or State.potA > State.potB
                                    end)

                                    for i = 1, math.min(State.MAX, #State.petsToLevel) do
                                        targetIds[State.petsToLevel[i].id] = true
                                    end

                                    State.currentTeamSize = 0
                                    for _ in pairs(targetIds) do State.currentTeamSize = State.currentTeamSize + 1 end

                                    if State.currentTeamSize < State.MAX then
                                        local allPetsSorted = {}
                                        for id, data in pairs(Replication.Data.Pets) do
                                            if not data.Test1122 then
                                                table.insert(allPetsSorted, {id = id, pot = getMaxPotential(data), cur = getPower(data)})
                                            end
                                        end
                                        
                                        table.sort(allPetsSorted, function(a, b) return a.pot == b.pot and a.cur > b.cur or a.pot > b.pot end)
                                        
                                        for _, petInfo in ipairs(allPetsSorted) do
                                            if State.currentTeamSize >= State.MAX then break end
                                            
                                            if not targetIds[petInfo.id] then
                                                targetIds[petInfo.id] = true
                                                State.currentTeamSize = State.currentTeamSize + 1
                                            end
                                        end
                                    end

                                    State.currentPets = Replication.Data.Pets
                                    State.toUnequip = {}
                                    State.toEquip = {}

                                    for petId, petData in pairs(State.currentPets) do
                                        if petData.Equipped and not targetIds[petId] then
                                            table.insert(State.toUnequip, petId)
                                        end
                                    end

                                    for petId, _ in pairs(targetIds) do
                                        if State.currentPets[petId] and not State.currentPets[petId].Equipped then
                                            table.insert(State.toEquip, petId)
                                        end
                                    end

                                    if #State.toUnequip > 0 then
                                        for _, petId in ipairs(State.toUnequip) do
                                            task.spawn(function()
                                                Signal.Fire("UnequipPetUI", petId)
                                                pcall(Network.InvokeServer, Network, "Unequip", petId)
                                            end)
                                        end
                                        task.wait(0.5)
                                    end

                                    if #State.toEquip > 0 then
                                        for _, petId in ipairs(State.toEquip) do
                                            task.spawn(function()
                                                Signal.Fire("EquipPetUI", petId)
                                                pcall(Network.InvokeServer, Network, "Equip", petId)
                                            end)
                                        end
                                        task.wait(0.5)
                                    end
                                end)
                                
                                task.wait(5)
                            end
                        end)
                    end
                end
            })

            State.AutoBuyTreatsSection = State.Tabs.Misc:AddSection("Treats Shop")

            State.selectedTreatsToBuy = {}
            State.autoBuyTreatsEnabled = false
            State.autoBuyTreatsThread = nil
            State.treatDropdownMap = {}

            local function getTreatsForDropdown()
                State.treatList = {}
                State.treatDropdownMap = {} 
                
                State.treatsToSort = {}
                for id, data in pairs(PetTreatsModule) do
                    table.insert(State.treatsToSort, {id = id, data = data})
                end

                table.sort(State.treatsToSort, function(a, b) return (a.data.Price or 0) < (b.data.Price or 0) end)

                for _, treatInfo in ipairs(State.treatsToSort) do
                    local treatId = treatInfo.id
                    local treatData = treatInfo.data
                    local displayName = treatData.Name or "Unknown"
                    local price = treatData.Price or 0
                    local currency = treatData.Currency or "Clicks"
                    local formattedString = displayName

                    if currency == "Tokens" then
                        formattedString = string.format("%s - %d Robux Tokens", displayName, price)
                    elseif currency ~= "Gems" then
                        formattedString = string.format("%s - %s %s", displayName, formatNumber(price), currency)
                    end
                    
                    table.insert(State.treatList, formattedString)
                    State.treatDropdownMap[formattedString] = treatId
                end
                
                return State.treatList
            end

            State.AutoBuyTreatsSection:AddDropdown("SelectTreatsToBuyDropdown", {
                Title = "Select Treats to Buy", Values = getTreatsForDropdown(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedTreatsToBuy = value or {}
                end
            })

            State.AutoBuyTreatsSection:AddToggle("AutoBuyTreatsToggle", {
                Title = "Auto Buy Treats", Default = false, Callback = function(Value)
                    State.autoBuyTreatsEnabled = Value
                    if State.autoBuyTreatsThread then
                        task.cancel(State.autoBuyTreatsThread)
                        State.autoBuyTreatsThread = nil
                    end

                    if Value then
                        State.autoBuyTreatsThread = task.spawn(function()
                            while State.autoBuyTreatsEnabled do
                                local purchasedSomethingThisCycle = false
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data

                                    State.myGems = Replication.Data.Statistics.Gems or 0
                                    State.myRebirths = Replication.Data.Statistics.Rebirths or 0
                                    State.myPaidTokens = (Replication.Data.Items and Replication.Data.Items.PaidTokens) or 0
                                    State.myPurchasedStock = Replication.Data.PetTreatsStock or {}

                                    for displayName, isSelected in pairs(State.selectedTreatsToBuy) do
                                        if not State.autoBuyTreatsEnabled then break end
                                        if isSelected then
                                            local treatId = State.treatDropdownMap[displayName]
                                            local treatData = PetTreatsModule[treatId]

                                            if treatData then
                                                State.baseStock = treatData.Stock or 0
                                                State.alreadyPurchased = State.myPurchasedStock[treatId] or 0
                                                
                                                if (State.baseStock - State.alreadyPurchased) > 0 then
                                                    State.canAfford = false
                                                    State.currencyType = treatData.Currency or "Clicks"

                                                    if State.currencyType == "Gems" then
                                                        local price = treatData.Price or 0
                                                        if treatData.ScaleWithRebirths then
                                                            price = math.round(price * (1 + (State.myRebirths * 0.05)))
                                                        end
                                                        if State.myGems >= price then
                                                            State.canAfford = true
                                                        end
                                                    elseif State.currencyType == "Tokens" then
                                                        if State.myPaidTokens >= (treatData.Price or 0) then
                                                            State.canAfford = true
                                                        end
                                                    else
                                                        State.canAfford = true
                                                    end

                                                    if State.canAfford then
                                                        Network:InvokeServer("PurchasePetTreat", treatId)
                                                        purchasedSomethingThisCycle = true
                                                        task.wait(0.5) 
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end)
                                
                                if purchasedSomethingThisCycle then
                                    task.wait(0.25)
                                else
                                    task.wait(5)
                                end
                            end
                        end)
                    end
                end
            })

            State.LevelPetsSection = State.Tabs.Misc:AddSection("Level Pets")

            State.selectedTreats = {}
            State.useTreatsThread = nil
            State.xpItemMap = {}

            local function getXpItems()
                State.xpItems = {}
                
                for itemId, itemData in pairs(ItemDefinitions) do
                    if itemData.Description and type(itemData.Description) == "string" and itemData.Description:match("%+%s*[%d,]+%s*XP") then
                        local xpAmount = tonumber((itemData.Description:match("%+%s*([%d,]+)%s*XP"):gsub(",", "")))
                        if xpAmount then
                            table.insert(State.xpItems, { id = itemId, name = itemData.Name, xp = xpAmount })
                        end
                    end
                end
                
                table.sort(State.xpItems, function(a, b) return a.xp > b.xp end)
                return State.xpItems
            end

            State.allXpItems = getXpItems()
            State.xpItemDisplayNames = {}
            for _, itemData in ipairs(State.allXpItems) do
                table.insert(State.xpItemDisplayNames, itemData.name)
                State.xpItemMap[itemData.name] = itemData.id
            end

            State.LevelPetsSection:AddDropdown("SelectTreatsDropdown", {
                Title = "Select XP Items to Use", Values = State.xpItemDisplayNames, Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedTreats = value or {}
                end
            })

            State.LevelPetsSection:AddToggle("AutoUseTreatsToggle", {
                Title = "Use Treats", Description = "Automatically uses selected treats on pets with the highest max-level potential.", Default = false, Callback = function(Value)
                    if State.useTreatsThread then
                        task.cancel(State.useTreatsThread)
                        State.useTreatsThread = nil
                    end

                    if Value then
                        State.useTreatsThread = task.spawn(function()
                            while Value do
                                local loopWait = 0.25
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data and Replication.Data.Pets and Replication.Data.Items

                                    State.bestTreatData = nil
                                    for _, itemData in ipairs(State.allXpItems) do
                                        if State.selectedTreats[itemData.name] and (Replication.Data.Items[itemData.id] or 0) > 0 then
                                            State.bestTreatData = itemData
                                            break
                                        end
                                    end

                                    if not State.bestTreatData then
                                        loopWait = 5
                                        return
                                    end

                                    State.MAX_EQUIP = Replication.Data.EquipLimit or 5
                                    State.equippedCount = 0
                                    State.isTeamFullyMaxed = true
                                    State.potentialPets = {}

                                    for id, petData in pairs(Replication.Data.Pets) do
                                        if not petData.Locked then
                                            if petData.Equipped then
                                                State.equippedCount = State.equippedCount + 1
                                            end

                                            local rarity = PetStats:GetRarity(petData.Name)
                                            State.maxLevel = PetStats:GetMaxLevel(rarity)
                                            
                                            if (petData.Level or 1) < State.maxLevel then
                                                table.insert(State.potentialPets, { data = petData, potential = getMaxPotential(petData) })
                                                if petData.Equipped then
                                                    State.isTeamFullyMaxed = false
                                                end
                                            end
                                        end
                                    end
                                    
                                    if State.equippedCount >= State.MAX_EQUIP and State.isTeamFullyMaxed then
                                        loopWait = 5
                                        return
                                    end
                                    
                                    if #State.potentialPets == 0 then
                                        loopWait = 5
                                        return
                                    end
                                    
                                    table.sort(State.potentialPets, function(a, b) return a.potential > b.potential end)
                                    State.bestCandidate = State.potentialPets[1]
                                    
                                    State.targetPetData = State.bestCandidate.data
                                    State.currentLevel = State.targetPetData.Level or 1
                                    State.currentXP = State.targetPetData.XP or 0
                                    local rarity = PetStats:GetRarity(State.targetPetData.Name)
                                    State.maxLevel = PetStats:GetMaxLevel(rarity)
                                    
                                    State.totalXpNeeded = 0
                                    for level = State.currentLevel, State.maxLevel - 1 do
                                        State.totalXpNeeded = State.totalXpNeeded + PetStats:XPRequirement(level, rarity)
                                    end
                                    State.totalXpNeeded = State.totalXpNeeded - State.currentXP

                                    if State.totalXpNeeded <= 0 then return end

                                    State.numTreatsNeeded = math.ceil(State.totalXpNeeded / State.bestTreatData.xp)
                                    State.numTreatsOwned = Replication.Data.Items[State.bestTreatData.id] or 0
                                    State.treatsToUse = math.min(State.numTreatsNeeded, State.numTreatsOwned)

                                    if State.treatsToUse <= 0 then
                                        loopWait = 5
                                        return
                                    end
                                    
                                    Network:InvokeServer("ConvertToXP", State.targetPetData.Id, {[1]={[1]=State.bestTreatData.id, [2]=State.treatsToUse}})
                                end)
                                
                                task.wait(loopWait)
                            end
                        end)
                    end
                end
            })

            State.DeletePetsSection = State.Tabs.Misc:AddSection("Delete Pets")

            local function parseFormattedNumber(input)
                if not input or input == "" then return 0 end
                input = tostring(input):lower():gsub("%s+", "")
                State.multipliers = { k = 1e3, m = 1e6, b = 1e9, t = 1e12, qd = 1e15, qn = 1e18, sx = 1e21, sp = 1e24, oc = 1e27 }
                for suffix, mult in pairs(State.multipliers) do
                    if input:match(suffix .. "$") then
                        local number = tonumber(input:match("^([%d%.]+)"))
                        if number then return number * mult end
                    end
                end
                return tonumber(input) or 0
            end

            State.deleteClicksInput = State.DeletePetsSection:AddInput("DeleteClicksInput", {
                Title = "Delete Pets Under X Clicks", Description = "e.g., 1.2k, 100, 1200", Default = "", Numeric = false, Callback = function(value)
                    deleteClicksThreshold = parseFormattedNumber(value)
                end
            })

            DeleteUnderThresholdToggle = State.DeletePetsSection:AddToggle("DeleteUnderThreshold", {
                Title = "Auto Delete Under Threshold", Default = false, Callback = function(Value)
                    autoDeleteUnderThresholdEnabled = Value
                    if Value then
                        autoDeleteUnderThresholdThread = task.spawn(function()
                            while autoDeleteUnderThresholdEnabled do
                                local allPetsSorted = getAllPetsSorted()
                                if deleteClicksThreshold and deleteClicksThreshold > 0 then
                                    for _, petInfo in ipairs(allPetsSorted) do
                                        if not autoDeleteUnderThresholdEnabled then break end
                                        
                                        if petInfo.power < deleteClicksThreshold then
                                            task.spawn(function()
                                                pcall(Network.InvokeServer, Network, "DeletePet", petInfo.data.Id)
                                            end)
                                        end
                                    end
                                end
                                task.wait(5)
                            end
                        end)
                    elseif autoDeleteUnderThresholdThread then
                        task.cancel(autoDeleteUnderThresholdThread)
                        autoDeleteUnderThresholdThread = nil
                    end
                end
            })

            State.deleteWeakestInput = State.DeletePetsSection:AddInput("DeleteWeakestInput", {
                Title = "Delete X Weakest Pets", Description = "Number of weakest pets to delete", Default = "", Numeric = true, Callback = function(value)
                    deleteWeakestAmount = tonumber(value) or 0
                end
            })

            State.DeleteWeakestButton = State.DeletePetsSection:AddButton({
                Title = "Delete X Weakest Pets", Description = "Deletes the specified amount of weakest pets once", Callback = function()
                    task.spawn(function()
                        local allPetsSorted = getAllPetsSorted()
                        if deleteWeakestAmount > 0 then
                            for i = 1, math.min(deleteWeakestAmount, #allPetsSorted) do
                                local pet = allPetsSorted[i].data
                                task.spawn(function()
                                    pcall(function()
                                        Network:InvokeServer("DeletePet", pet.Id)
                                    end)
                                end)
                            end
                        end
                    end)
                end
            })

            State.selectedSpecificPets = {}
            State.autoDeleteSpecificEnabled = false
            State.autoDeleteSpecificThread = nil
            State.specificPetsDropdown = nil

            local function getPetDisplayName(petData)
                State.parts = {}
                if petData.Tier and petData.Tier ~= "Normal" then table.insert(State.parts, petData.Tier) end
                if petData.Mutation then table.insert(State.parts, petData.Mutation) end
                if petData.Name then table.insert(State.parts, petData.Name) end
                return table.concat(State.parts, " ")
            end

            local function getUniqueOwnedPetNames()
                repeat task.wait() until Replication and Replication.Data and Replication.Data.Pets
                State.petNameSet = {}
                State.petNameList = {}
                for _, petData in pairs(Replication.Data.Pets) do
                    if not petData.Locked then
                        local displayName = getPetDisplayName(petData)
                        if not State.petNameSet[displayName] then
                            State.petNameSet[displayName] = true
                            table.insert(State.petNameList, displayName)
                        end
                    end
                end
                table.sort(State.petNameList)
                return State.petNameList
            end

            State.specificPetsDropdown = State.DeletePetsSection:Dropdown("DeleteSpecificDropdown", {
                Title = "Select Specific Pets to Delete", Values = getUniqueOwnedPetNames(), Multi = true, Searchable = true, Default = {}, Callback = function(value)
                    State.selectedSpecificPets = value
                end
            })

            State.DeletePetsSection:AddButton({
                Title = "Refresh Specific Pet List", Callback = function()
                    if State.specificPetsDropdown then
                        State.specificPetsDropdown:SetValues(getUniqueOwnedPetNames())
                    end
                end
            })

            State.DeletePetsSection:AddToggle("AutoDeleteSelected", {
                Title = "Auto Delete (Selected)", Default = false, Callback = function(Value)
                    State.autoDeleteSpecificEnabled = Value
                    if State.autoDeleteSpecificThread then task.cancel(State.autoDeleteSpecificThread) State.autoDeleteSpecificThread = nil end

                    if Value then
                        State.autoDeleteSpecificThread = task.spawn(function()
                            while State.autoDeleteSpecificEnabled do
                                repeat task.wait() until Replication and Replication.Data and Replication.Data.Pets
                                
                                State.petsToDelete = {}
                                if type(State.selectedSpecificPets) == "table" then
                                    for k, v in pairs(State.selectedSpecificPets) do
                                        if type(k) == "string" and v == true then State.petsToDelete[k] = true
                                        elseif type(k) == "number" and type(v) == "string" then State.petsToDelete[v] = true end
                                    end
                                end

                                if next(State.petsToDelete) then
                                    for petId, petData in pairs(Replication.Data.Pets) do
                                        if State.autoDeleteSpecificEnabled and not petData.Locked then
                                            local currentPetName = getPetDisplayName(petData)
                                            if State.petsToDelete[currentPetName] then
                                                task.spawn(function()
                                                    pcall(Network.InvokeServer, Network, "DeletePet", petId)
                                                end)
                                            end
                                        end
                                    end
                                end
                                task.wait(1)
                            end
                        end)
                    end
                end
            })

            State.DeletePetsSection:AddParagraph("DeletePetsInfo", {
                Title = "Delete Pets Info", Content = "• Delete Under X Clicks: Deletes all unlocked pets with the multiplier below the threshold (e.g., 1.2k = 1200 clicks)\n\n• Delete X Weakest: Deletes the X weakest unlocked pets by multiplier", TitleAlignment = "Middle"
            })

            State.TEAMS_FILE_PATH = "PetTeams.json"

            local function formatNumber(num)
                State.absNum = math.abs(num)
                if State.absNum >= 1e12 then return string.format("%.2fT", num / 1e12):gsub("%.?0+T", "T")
                elseif State.absNum >= 1e9 then return string.format("%.2fB", num / 1e9):gsub("%.?0+B", "B")
                elseif State.absNum >= 1e6 then return string.format("%.2fM", num / 1e6):gsub("%.?0+M", "M")
                elseif State.absNum >= 1e3 then return string.format("%.2fK", num / 1e3):gsub("%.?0+K", "K")
                else return tostring(num) end
            end

            local function getPower(petData)
                if petData.Multiplier1 and tonumber(petData.Multiplier1) > 0 then return tonumber(petData.Multiplier1) end
                State.globalBestMulti = (Replication.Data.BestMultiplier and Replication.Data.BestMultiplier[1]) or 0
                State.petPercentage = PetStats:GetPercentage(petData.Name)
                State.baseStat = State.petPercentage and (State.globalBestMulti * State.petPercentage / 100) or (petData.Multi1 or 0)
                return PetStats:GetMulti(State.baseStat, petData.Tier, petData.Level, petData)
            end

            local function equipTargetSet(targetIds)
                State.currentPets = Replication.Data.Pets
                for petId, petData in pairs(State.currentPets) do
                    if petData.Equipped and not targetIds[petId] then
                        pcall(Network.InvokeServer, Network, "Unequip", petId)
                        Signal.Fire("UnequipPetUI", petId)
                        task.wait(0.1)
                    end
                end
                task.wait(0.2)
                for petId, _ in pairs(targetIds) do
                    if State.currentPets[petId] and not State.currentPets[petId].Equipped then
                        pcall(Network.InvokeServer, Network, "Equip", petId)
                        Signal.Fire("EquipPetUI", petId)
                        task.wait(0.1)
                    end
                end
            end

            State.petTeams = {}
            
            local function loadTeams()
                if isfile and isfile(State.TEAMS_FILE_PATH) then
                    State.fileContent = readfile(State.TEAMS_FILE_PATH)
                    local success, data = pcall(HttpService.JSONDecode, HttpService, State.fileContent)
                    if success then
                        State.petTeams = data
                    end
                end
            end

            local function saveTeams()
                if writefile then
                    State.jsonString = HttpService:JSONEncode(State.petTeams)
                    writefile(State.TEAMS_FILE_PATH, State.jsonString)
                end
            end
            
            State.Tabs.Teams:AddParagraph("HowToUse", {
                Title = "How to Use", Content = "1. Create a Team: Enter a name, select pets, then click 'Create Team'.\n\n2. Equip a Team: Select a saved team from the 'Manage' section and click 'Equip'.\n\n3. Do not create a team with more pets then you have equip slots for!"
            })

            State.createSection = State.Tabs.Teams:AddSection("Create / Update Team")
            State.manageSection = State.Tabs.Teams:AddSection("Manage Existing Teams")

            State.selectedTeamPets = {}
            State.teamsPetDropdown = nil
            State.teamsDropdown = nil
            State.teamsPetDropdownMap = {}

            local function getFormattedPetListForTeams()
                State.teamsPetDropdownMap = {}
                State.petsToSort = {}
                for id, petData in pairs(Replication.Data.Pets) do table.insert(State.petsToSort, petData) end
                table.sort(State.petsToSort, function(a, b) return getPower(a) > getPower(b) end)
                
                State.formattedList = {}
                for i, petData in ipairs(State.petsToSort) do
                    local power = getPower(petData)
                    local petString = string.format("%s (x%s)", petData.Name or "Unknown", formatNumber(power))
                    if petData.Enchant and petData.Enchant ~= "" then petString = petString .. ": " .. petData.Enchant end
                    State.finalDropdownString = string.format("%d. %s", i, petString)
                    table.insert(State.formattedList, State.finalDropdownString)
                    State.teamsPetDropdownMap[State.finalDropdownString] = petData.Id
                end
                return State.formattedList
            end
            
            local function updateTeamsDropdown()
                State.teamNames = {}
                for name, _ in pairs(State.petTeams) do table.insert(State.teamNames, name) end
                table.sort(State.teamNames)
                if State.teamsDropdown then State.teamsDropdown:SetValues(State.teamNames) end
            end

            State.teamNameInput = State.createSection:AddInput("TeamNameInput", {
                Title = "New Team Name", Placeholder = "My Best Pets", Default = ""
            })

            State.teamsPetDropdown = State.createSection:Dropdown("SelectTeamPetsDropdown", {
                Title = "Select Pets for New Team", Values = getFormattedPetListForTeams(), Multi = true, Searchable = true, Default = {}, Callback = function(value) State.selectedTeamPets = value end
            })
            
            State.createSection:AddButton({ Title = "Refresh Pet List", Callback = function()
                if State.teamsPetDropdown then
                    State.teamsPetDropdown:SetValues(getFormattedPetListForTeams())
                    State.teamsPetDropdown:SetValue({})
                end
            end})

            State.createSection:AddButton({ Title = "Create / Update Team", Callback = function()
                State.teamName = State.teamNameInput.Value
                if not State.teamName or State.teamName == "" then return Library:Notify({ Title = "Error", Content = "Please enter a team name.", Duration = 3}) end
                
                State.petIds, State.petCount = {}, 0
                for petString, isSelected in pairs(State.selectedTeamPets) do
                    if isSelected and State.teamsPetDropdownMap[petString] then
                        table.insert(State.petIds, State.teamsPetDropdownMap[petString])
                        State.petCount = State.petCount + 1
                    end
                end

                if State.petCount == 0 then return Library:Notify({ Title = "Error", Content = "Please select pets for the team.", Duration = 3 }) end
                
                State.isUpdating = State.petTeams[State.teamName] ~= nil
                State.petTeams[State.teamName] = State.petIds
                saveTeams()
                updateTeamsDropdown()
                
                State.message = State.isUpdating and "updated" or "created"
                Library:Notify({ Title = "Success", Content = "Team '" .. State.teamName .. "' " .. State.message .. ".", Duration = 3 })
            end})

            State.teamsDropdown = State.manageSection:Dropdown("SelectTeamDropdown", {
                Title = "Select Saved Team", Values = {}, Multi = false, Searchable = true,
            })

            State.manageSection:AddButton({ Title = "Equip Selected Team", Callback = function()
                State.teamName = State.teamsDropdown.Value
                if not State.teamName or not State.petTeams[State.teamName] then return Library:Notify({ Title = "Error", Content = "Please select a valid team.", Duration = 3 }) end
                
                State.targetIdSet = {}
                for _, id in ipairs(State.petTeams[State.teamName]) do State.targetIdSet[id] = true end
                
                equipTargetSet(State.targetIdSet)
                Library:Notify({ Title = "Success", Content = "Equipped team: " .. State.teamName, Duration = 3 })
            end})

            State.manageSection:AddButton({ Title = "Delete Selected Team", Callback = function()
                State.teamName = State.teamsDropdown.Value
                if not State.teamName or not State.petTeams[State.teamName] then return Library:Notify({ Title = "Error", Content = "Please select a valid team.", Duration = 3 }) end
                
                State.petTeams[State.teamName] = nil
                saveTeams()
                updateTeamsDropdown()
                Library:Notify({ Title = "Success", Content = "Deleted team: " .. State.teamName, Duration = 3 })
            end})

            loadTeams()
            updateTeamsDropdown()

            TradingSection = State.Tabs.Trading:AddSection("Trading Plaza")
 
            local function isPremiumKey()
                State.keyFile = "active_key.txt"
                if not isfile or not isfile(State.keyFile) then
                    return false
                end

                local success, data = pcall(readfile, State.keyFile)
                if not success or not data then
                    return false
                end

                State.savedKey = data:match("^(.-)\n") or data
                if not State.savedKey then
                    return false
                end

                State.keyLower = State.savedKey:lower():gsub("%s+", "")
                if State.keyLower == "adminpremium" or State.keyLower:sub(1, 6) == "ducky-" then
                    return true
                end

                return false
            end

            if not isPremiumKey() then
                TradingSection:Paragraph("TradingInfo", {
                    Title = "Sorry!", Content = "This feature is only for premium users. Join the discord for more information.", TitleAlignment = "Middle"
                })

            else
                TradingSection:Paragraph("TradingInfo", {
                    Title = "Premium Users", Content = "Thank you so much for being a premium user! Your support truly means a lot to me, and I really enjoy creating these scripts for you.", TitleAlignment = "Middle"
                })

                State.loadstringText = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/Scriptsforfun/MainCode/refs/heads/main/Plaza"))()'

                TradingSection:Button({
                    Title = "Load Trading Plaza Script", Callback = function()
                        loadstring(game:HttpGet("https://raw.githubusercontent.com/Scriptsforfun/MainCode/refs/heads/main/Plaza"))()
                    end
                })

                TradingSection:Button({
                    Title = "Copy Script Loadstring", Description = "Useful if you want to auto execute the script!", Callback = function()
                        setclipboard(State.loadstringText)
                        Library:Notify({
                            Title = "Success", Content = "Loadstring copied to clipboard!", Duration = 3
                        })
                    end
                })
            end

            State.WEBHOOK_URL = ""
            State.DISCORD_USER_ID = ""
            State.selectedRarities = {}
            State.webhookEnabled = false
            State.webhookThread = nil
            State.statsWebhookEnabled = false
            State.statsWebhookThread = nil
            State.pingUserForStats = false
            State.statsWebhookDelay = 30

            local function getRarityList()
                State.orderedRarities = {
                    "Common", "Rare", "Epic", "Legendary", "Mythical", "Godly", "Exclusive", "Secret I", "Secret II", "Secret III"
                }
                
                local result = {}
                for _, rarity in ipairs(State.orderedRarities) do
                    if PetStatsRarities[rarity] then
                        table.insert(result, rarity)
                    end
                end
                
                return result
            end

            local function getRarityColor(rarity)
                if PetStatsRarities[rarity] and PetStatsRarities[rarity][1] then
                    State.color3 = PetStatsRarities[rarity][1]
                    return math.floor(State.color3.R * 255) * 65536 + math.floor(State.color3.G * 255) * 256 + math.floor(State.color3.B * 255)
                end
                return 0xFFFFFF
            end

            local function sendDiscordWebhook(content, embeds)
                if not State.WEBHOOK_URL or State.WEBHOOK_URL == "" then
                    return
                end
                
                success, State.response = pcall(function()
                    local data = {
                        content = content, embeds = embeds
                    }
                    
                    return requestFunc({
                        Url = State.WEBHOOK_URL, Method = "POST", Headers = {
                            ["Content-Type"] = "application/json"
                        }, Body = HttpService:JSONEncode(data)
                    })
                end)
            end

            State.SettingsSection = State.Tabs.Discord:AddSection("Settings")

            State.webhookUrlInput = State.SettingsSection:AddInput("WebhookURL", {
                Title = "Webhook URL", Default = State.WEBHOOK_URL, Numeric = false, Finished = false, Callback = function(value)
                    if value and value ~= "" then
                        State.WEBHOOK_URL = value
                    end
                end
            })

            State.discordIdInput = State.SettingsSection:AddInput("DiscordUserID", {
                Title = "Discord User ID", Default = State.DISCORD_USER_ID, Numeric = false, Finished = false, Callback = function(value)
                    if value and value ~= "" then
                        State.DISCORD_USER_ID = value
                    end
                end
            })

            State.showRobloxUser = false

            State.ShowUserToggle = State.SettingsSection:AddToggle("ShowRobloxUser", {
                Title = "Show Roblox User", Description = "Shows your Roblox username in webhook embeds", Default = false, Callback = function(Value)
                    State.showRobloxUser = Value
                end
            })

            State.TestWebhookButton = State.SettingsSection:AddButton({
                Title = "Test Webhook", Description = "Sends a test message to verify your webhook works", Callback = function()
                    State.testEmbeds = {
                        {
                            title = "🔔 Webhook Test", description = "Your webhook is working correctly!", color = 0x00FF00, fields = {
                                {
                                    name = "👤 User", value = State.showRobloxUser and State.username or "Anonymous", inline = true
                                },
                                {
                                    name = "🆔 User ID", value = State.showRobloxUser and tostring(State.userid) or "Hidden", inline = true
                                },
                                {
                                    name = "🎮 Game", value = "Tap Simulator", inline = false
                                }
                            }, footer = {
                                text = "By Ducky (OH AND BEAN IS SOOO COOL)"
                            }, timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
                        }
                    }
                    
                    State.pingContent = ""
                    if State.DISCORD_USER_ID and State.DISCORD_USER_ID ~= "" then
                        State.pingContent = string.format("<@%s>", State.DISCORD_USER_ID)
                    end
                    
                    sendDiscordWebhook(State.pingContent, State.testEmbeds)
                    Library:Notify({
                        Title = "Webhook Test", Content = "Test message sent to Discord!", Duration = 3
                    })
                end
            })

            State.PetWebhookSection = State.Tabs.Discord:AddSection("Pet Webhook")

             State.PetWebhookSection:Paragraph("WebhookInfo", {
                Title = "📖 How to Use", Content = "\n1️⃣ Get your webhook URL from Discord (e.g. https://discordapp.com/api/webhooks/144869829200/NgO232_e5MjzIsERltnITXpvtHlPj5QpsOIjXbewr321):\n   Server Settings → Integrations → Webhooks → New Webhook\n\n2️⃣ Get your Discord User ID:\n   Enable Developer Mode → Right-click your name → Copy ID\n\n3️⃣ Configure settings below\n\n4️⃣ Click 'Test Webhook' to verify it works\n\n5️⃣ Enable the webhook toggles for what you want to track" , TitleAlignment = "Left"
            })

            State.raritiesDropdown = State.PetWebhookSection:Dropdown("WebhookRarities", {
                Title = "Select Rarities to Track", Values = getRarityList(), Searchable = true, Multi = true, Default = {}, Callback = function(value)
                    State.selectedRarities = {}
                    
                    if type(value) == "table" then
                        for rarity, isSelected in pairs(value) do
                            if isSelected then
                                State.selectedRarities[rarity] = true
                            end
                        end
                    end
                end
            })

            State.EnableWebhookToggle = State.PetWebhookSection:AddToggle("EnableWebhook", {
                Title = "Enable Pet Webhook", Description = "Sends notifications when you hatch selected rarities", Default = false, Callback = function(Value)
                    State.webhookEnabled = Value
                    
                    if State.webhookThread then
                        task.cancel(State.webhookThread)
                        State.webhookThread = nil
                    end
                    
                    if Value then
                        State.webhookThread = task.spawn(function()
                            
                            State.originalInvokeServer = Network.InvokeServer
                            
                            Network.InvokeServer = function(self, eventName, ...)
                                State.args = {...}
                                
                                if eventName == "OpenEgg" and State.webhookEnabled then
                                    local eggName = State.args[1]
                                    local result = State.originalInvokeServer(self, eventName, ...)
                                    
                                    if result ~= nil and type(result) == "table" then
                                        State.petsToSend = {}
                                        
                                        for i, petData in ipairs(result) do
                                            if petData ~= nil and type(petData) == "table" then
                                                local petName = petData[1]
                                                local tier = petData[2]
                                                
                                                if petName ~= nil then
                                                    local rarity = "Unknown"
                                                    pcall(function()
                                                        rarity = PetStats:GetRarity(petName, true) or "Unknown"
                                                    end)
                                                    
                                                    if State.selectedRarities[rarity] then
                                                        table.insert(State.petsToSend, {
                                                            name = petName, tier = tier, rarity = rarity
                                                        })
                                                    end
                                                end
                                            end
                                        end
                                        
                                        if #State.petsToSend > 0 then
                                            State.pingContent = ""
                                            if State.DISCORD_USER_ID and State.DISCORD_USER_ID ~= "" then
                                                State.pingContent = string.format("<@%s>", State.DISCORD_USER_ID)
                                            end
                                            
                                            State.embedFields = {}
                                            for i, pet in ipairs(State.petsToSend) do
                                                table.insert(State.embedFields, {
                                                    name = string.format("🎉 Pet #%d", i), value = string.format("**%s %s**\n✨ Rarity: `%s`", pet.tier or "Normal", pet.name, pet.rarity), inline = true
                                                })
                                            end
                                            
                                            State.embedColor = getRarityColor(State.petsToSend[1].rarity)
                                            
                                            local embeds = {
                                                {
                                                    title = string.format("🥚 Hatched %d Pet(s) from %s Egg!", #State.petsToSend, eggName or "Unknown"), color = State.embedColor, fields = State.embedFields, footer = {
                                                        text = State.showRobloxUser
                                                            and string.format("👤 %s (%s)", State.username, State.userid)
                                                            or "👤 Anonymous"
                                                    }, timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
                                                }
                                            }
                                            
                                            sendDiscordWebhook(State.pingContent, embeds)
                                        end
                                    end
                                    
                                    return result
                                end
                                
                                return State.originalInvokeServer(self, eventName, ...)
                            end
                            
                            while State.webhookEnabled do
                                task.wait(1)
                            end
                            
                            Network.InvokeServer = State.originalInvokeServer
                        end)
                        
                        Library:Notify({
                            Title = "Pet Webhook Enabled", Content = "Monitoring egg hatches for selected rarities!", Duration = 3
                        })
                    end
                end
            })

            State.StatsWebhookSection = State.Tabs.Discord:AddSection("Main Stats Webhook")

            State.statsDelayInput = State.StatsWebhookSection:AddInput("StatsWebhookDelay", {
                Title = "Frequency (Seconds)", Default = "30", Numeric = true, Description = "How often to send stats updates", Callback = function(value)
                    local num = tonumber(value)
                    if num and num > 0 then
                        State.statsWebhookDelay = num
                    else
                        State.statsWebhookDelay = 30
                        Library:Notify({
                            Title = "Invalid Input", Content = "Please enter a positive number. Reset to 30.", Duration = 2
                        })
                    end
                end
            })

            State.PingUserForStatsToggle = State.StatsWebhookSection:AddToggle("PingUserForStats", {
                Title = "Ping User for Stats", Default = false, Callback = function(Value)
                    State.pingUserForStats = Value
                end
            })

            State.EnableStatsWebhookToggle = State.StatsWebhookSection:AddToggle("EnableStatsWebhook", {
                Title = "Enable Stats Webhook", Default = false, Callback = function(Value)
                    State.statsWebhookEnabled = Value
                    
                    if State.statsWebhookThread then
                        task.cancel(State.statsWebhookThread)
                        State.statsWebhookThread = nil
                    end
                    
                    if Value then
                        State.statsWebhookThread = task.spawn(function()
                            if not State.PlayerGui then
                                State.PlayerGui = State.LocalPlayer:WaitForChild("PlayerGui")
                            end
                            
                            while State.statsWebhookEnabled do
                                pcall(function()
                                    repeat task.wait() until Replication.Loaded and Replication.Data
                                    
                                    local data = Replication.Data
                                    State.leaderstats = State.LocalPlayer:WaitForChild("leaderstats")
                                    State.statsUI = State.PlayerGui:WaitForChild("RightHud"):WaitForChild("Main"):WaitForChild("RightUI"):WaitForChild("Badges"):WaitForChild("List"):WaitForChild("Stats")
                                    
                                    local function getMostHatchedEgg()
                                        if not data.HatchedEggs then return "None", 0 end
                                        
                                        State.mostEgg = "None"
                                        State.mostCount = 0
                                        
                                        for eggName, count in pairs(data.HatchedEggs) do
                                            if count > State.mostCount then
                                                State.mostCount = count
                                                State.mostEgg = eggName
                                            end
                                        end
                                        
                                        return State.mostEgg, State.mostCount
                                    end
                                    
                                    local function formatTime(seconds)
                                        if not seconds then return "Unknown" end
                                        State.days = math.floor(seconds / 86400)
                                        local hours = math.floor((seconds % 86400) / 3600)
                                        local minutes = math.floor((seconds % 3600) / 60)
                                        
                                        if State.days > 0 then
                                            return string.format("%dd %dh %dm", State.days, hours, minutes)
                                        elseif hours > 0 then
                                            return string.format("%dh %dm", hours, minutes)
                                        else
                                            return string.format("%dm", minutes)
                                        end
                                    end
                                    
                                    State.mostEgg, State.mostEggCount = getMostHatchedEgg()
                                    State.totalData = data.Total or {}
                                    
                                    State.petCount = 0
                                    State.equippedCount = 0
                                    for petId, petData in pairs(data.Pets or {}) do
                                        State.petCount = State.petCount + 1
                                        if petData.Equipped then
                                            State.equippedCount = State.equippedCount + 1
                                        end
                                    end
                                    
                                    State.boostsText = "None"
                                    if data.Boosts then
                                        State.boostLines = {}
                                        for boostName, amount in pairs(data.Boosts) do
                                            if amount > 0 then
                                                table.insert(State.boostLines, string.format("%s: %d", boostName, amount))
                                            end
                                        end
                                        if #State.boostLines > 0 then
                                            State.boostsText = table.concat(State.boostLines, "\n")
                                        end
                                    end
                                    
                                    State.activeBoostsText = "None active"
                                    if data.ActiveBoosts then
                                        State.activeLines = {}
                                        for boostName, timeLeft in pairs(data.ActiveBoosts) do
                                            local hours = math.floor(timeLeft / 3600)
                                            local minutes = math.floor((timeLeft % 3600) / 60)
                                            local seconds = timeLeft % 60
                                            table.insert(State.activeLines, string.format("%s: %dh %dm %ds", boostName, hours, minutes, seconds))
                                        end
                                        if #State.activeLines > 0 then
                                            State.activeBoostsText = table.concat(State.activeLines, "\n")
                                        end
                                    end
                                    
                                    local function safeGetStatText(statUI)
                                        local success, result = pcall(function()
                                            return statUI.Value.Text
                                        end)
                                        return success and result or "—"
                                    end

                                    local embeds = {
                                        {
                                            title = "📊 Tap Simulator Stats", color = 0x5865F2, fields = {
                                                {
                                                    name = "💎 Gems", value = string.format("%s (%s total)", formatNumber(data.Statistics.Gems or 0), formatNumber(State.totalData.Gems or 0)), inline = true
                                                },
                                                {
                                                    name = "🔥 Clicks", value = string.format("%s (%s actual)", formatNumber(data.Statistics.Clicks or 0), formatNumber(State.totalData.ActualClicks or 0)), inline = true
                                                },
                                                {
                                                    name = "👆 Total Pet Power", value = State.statsUI.TotalPetPower.Value.Text, inline = true
                                                },
                                                {
                                                    name = "🔄 Rebirths", value = formatNumber(data.Statistics.Rebirths or 0), inline = true
                                                },
                                                {
                                                    name = "🔄 Rebirth Multiplier", value = State.statsUI.RebirthMulti.Value.Text, inline = true
                                                },
                                                {
                                                    name = "🥚 Eggs Opened", value = formatNumber(data.Statistics.Eggs or 0), inline = true
                                                },
                                                {
                                                    name = "🌟 Best Hatch", value = tostring(State.leaderstats.Rarest.Value or "None"), inline = true
                                                },
                                                {
                                                    name = "🥚 Most Hatched Egg", value = string.format("%s (%s times)", State.mostEgg, formatNumber(State.mostEggCount)), inline = true
                                                },
                                                {
                                                    name = "⏰ Time Played", value = formatTime(State.totalData.Time), inline = true
                                                },
                                                {
                                                    name = "🏆 Leaderboard Rank", value = "#" .. State.statsUI.LeaderboardRank.Placement.Text, inline = false
                                                },
                                                {
                                                    name = "🐾 Pets", value = string.format("**Total:** %d\n**Equipped:** %d\n**Discovered:** %d", State.petCount, State.equippedCount, data.DiscoveredCount or 0), inline = true
                                                },
                                                {
                                                    name = "🍀 Luck Stats", value = string.format("**✨ Secret:** %s\n**🌟 Golden:** %s\n**🌈 Rainbow:** %s\n**🥚 Hatch Speed:** %s", safeGetStatText(State.statsUI.SecretLuck), safeGetStatText(State.statsUI.GoldLuck), safeGetStatText(State.statsUI.RainbowLuck), safeGetStatText(State.statsUI.HatchSpeed)), inline = true
                                                },
                                                {
                                                    name = "⚡ Boosts", value = (function()
                                                        State.multiplier = State.statsUI.BoostsMulti.Value.Text
                                                        if State.multiplier == "None" then
                                                            return "**💪 Multiplier:** None"
                                                        else
                                                            return string.format("**💪 Multiplier:** %s\n\n%s", State.multiplier, State.boostsText)
                                                        end
                                                    end)(), inline = true
                                                },
                                                {
                                                    name = "🎨 Active Boosts", value = State.activeBoostsText, inline = false
                                                }
                                            }, footer = {
                                                text = State.showRobloxUser
                                                    and string.format("👤 %s", State.username)
                                                    or "👤 Anonymous"
                                            }, timestamp = os.date("!%Y-%m-%dT%H:%M:%S")
                                        }
                                    }
                                    
                                    State.pingContent = ""
                                    if State.pingUserForStats and State.DISCORD_USER_ID and State.DISCORD_USER_ID ~= "" then
                                        State.pingContent = string.format("<@%s>", State.DISCORD_USER_ID)
                                    end
                                    
                                    sendDiscordWebhook(State.pingContent, embeds)
                                end)
                                
                                State.currentDelay = State.statsWebhookDelay or 30
                                task.wait(State.currentDelay)
                            end
                        end)
                        
                        Library:Notify({
                            Title = "Stats Webhook Enabled", Content = string.format("Sending stats every %d seconds!", State.statsWebhookDelay), Duration = 3
                        })
                    end
                end
            })
        end

        task.spawn(function()
            if not game:IsLoaded() then game.Loaded:Wait() end

                State.Window = Library:CreateWindow{
                Title = "Tap Simulator", SubTitle = "By Ducky", TabWidth = 165, Size = UDim2.fromOffset(580, 460), Resize = false, Theme = "Vynixu", MinimizeKey = Enum.KeyCode.LeftShift, Acrylic = true, Transparency = false
            }

            State.Tabs = {
                Home = State.Window:AddTab({ Title = "Thank you", Icon = "phosphor-hands-praying-bold" }), Settings = State.Window:AddTab({ Title = "Settings", Icon = "settings" }), Utility = State.Window:AddTab({ Title = "Utility", Icon = "phosphor-screwdriver-bold" }), Rejoin = State.Window:AddTab({ Title = "Rejoin", Icon = "recycle" }), Event = State.Window:AddTab({ Title = "Events", Icon = "sparkle" }), Main = State.Window:AddTab({ Title = "Main", Icon = "crown" }), Eggs = State.Window:AddTab({ Title = "Eggs", Icon = "egg" }), Crafting = State.Window:AddTab({ Title = "Pet Crafting", Icon = "paw-print" }), Teleport = State.Window:AddTab({ Title = "Teleport", Icon = "map" }), Enchant = State.Window:AddTab({ Title = "Enchanting", Icon = "phosphor-magic-wand-bold" }), Misc = State.Window:AddTab({ Title = "Misc", Icon = "sparkles" }), Teams = State.Window:AddTab({ Title = "Pet Teams", Icon = "dog" }), Trading = State.Window:AddTab({ Title = "Trading Plaza", Icon = "handshake" }), Discord = State.Window:AddTab({ Title = "Webhook", Icon = "phosphor-discord-logo" })
            }

            State.Window.Root.Destroying:Connect(function()
                if toggleGui then
                    toggleGui:Destroy()
                end
            end)

            State.BuildUI()

            local function getWindowFrame(win)
                if typeof(win) == "table" then
                    for _, key in ipairs({ "Frame", "Main", "Root", "Window", "Container" }) do
                        local v = rawget(win, key)
                        if typeof(v) == "Instance" and v:IsA("GuiObject") then
                            return v
                        end
                    end
                    if typeof(win.ScreenGui) == "Instance" then
                        State.best, bestArea = nil, 0
                        for _, inst in ipairs(win.ScreenGui:GetDescendants()) do
                            if inst:IsA("Frame") and inst.Visible then
                                local s = inst.AbsoluteSize
                                local area = s.X * s.Y
                                if area > State.bestArea then
                                    State.best, bestArea = inst, area
                                end
                            end
                        end
                        return State.best
                    end
                end

                State.best, bestArea = nil, 0
                for _, inst in ipairs(core:GetDescendants()) do
                    if inst:IsA("Frame") and inst.Visible then
                        local s = inst.AbsoluteSize
                        local area = s.X * s.Y
                        if area > State.bestArea then
                            State.best, bestArea = inst, area
                        end
                    end
                end
                return State.best
            end

            local function parseSize(text)
                text = tostring(text or ""):lower()
                local w, h = text:match("(%d+)%D+(%d+)")
                w, h = tonumber(w), tonumber(h)
                return w, h
            end

            local function setWindowSize(win, w, h)
                if not w or not h then return false end
                w = math.max(200, w)
                h = math.max(150, h)
                if not State.frame then
                    if not State.frame then
                        State.frame = getWindowFrame(win)
                    end
                end
                if State.frame and State.frame:IsA("GuiObject") then
                    State.frame.Size = UDim2.fromOffset(w, h)
                    return true
                end
                return false
            end

            State.AppearanceSection = State.Tabs.Settings:CreateSection("Appearance")

            State.SizeInput = State.AppearanceSection:CreateInput("WindowSize", {
                Title = "Window Size", Description = "Original: 580x460", Default = "580x460", Placeholder = "widthxheight", Finished = false, Callback = function(value)
                    local w, h = parseSize(value)

                    if w and h then
                        State.ok = setWindowSize(State.Window, w, h)

                        if State.ok then
                            Library:Notify({
                                Title = "Success", Content = "Window resized to " .. w .. "x" .. h, Duration = 4
                            })
                        else
                            Library:Notify({
                                Title = "Failed", Content = "Couldn't find the window frame to resize.", Duration = 5
                            })
                        end
                    else
                        Library:Notify({
                            Title = "Invalid Size", Content = "Use: widthxheight (example: 830x525).", Duration = 5
                        })
                    end
                end
            })

            State.HideButtonToggle = State.AppearanceSection:AddToggle("HideOpenClose", {
                Title = "Hide Open/Close Button", Default = false, Callback = function(Value)
                    local function toggleAll(parent)
                        for _, child in ipairs(parent:GetChildren()) do
                            if child.Name == "DuckyToggleGui" then
                                child.Enabled = not Value
                            end
                        end
                    end
                    toggleAll(CoreGui)
                    toggleAll(State.LocalPlayer:WaitForChild("PlayerGui"))
                end
            })

            if not State.frame then
                State.frame = getWindowFrame(State.Window)
            end

            if State.frame then
                State.inputText = State.SizeInput.Value or ""
                local w, h = parseSize(State.inputText)
                if not w or not h then w, h = 580, 460 end
                State.frame.Size = UDim2.fromOffset(580, 460)
                State.shrinkTween = TweenService:Create(State.frame, TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.fromOffset(1, 1)})
                State.shrinkTween:Play()
                State.shrinkTween.Completed:Wait()
                State.frame.Visible = false
                State.frame.Size = UDim2.fromOffset(1000,1000)
                task.wait(0.5)
                State.frame.Size = UDim2.fromOffset(1,1)
                State.frame.Visible = true
                State.expandTween = TweenService:Create(State.frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(w, h)})
                State.expandTween:Play()
                State.expandTween.Completed:Wait()
            end

            SaveManager:SetLibrary(Library)
            InterfaceManager:SetLibrary(Library)
            SaveManager:IgnoreThemeSettings()
            SaveManager:SetIgnoreIndexes{}
            InterfaceManager:SetFolder("FluentScriptHub")
            SaveManager:SetFolder("FluentScriptHub/TapSimulator")

            InterfaceManager:BuildInterfaceSection(State.Tabs.Settings)
            SaveManager:BuildConfigSection(State.Tabs.Settings)

            State.Window:SelectTab(1)
            SaveManager:LoadAutoloadConfig()

            State.usercountsection = State.Tabs.Settings:AddSection("User Count")

            State.userCountParagraph = State.Tabs.Settings:AddParagraph("UserCountStatus", {
                Title = "Script User Count", Content = "Loading..."
            })

            pcall(function()
                requestFunc({
                    Url = "https://duckyscripts.pythonanywhere.com/api/tapsim/add-user", Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode({ userid = State.userid })
                })
            end)

            task.spawn(function()
                task.wait(math.random(0, 59))
                while true do
                    pcall(function()
                        requestFunc({
                            Url = "https://duckyscripts.pythonanywhere.com/api/tapsim/active", Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = HttpService:JSONEncode({ userid = State.userid })
                        })
                    end)
                    task.wait(180)
                end
            end)

            task.spawn(function()
                task.wait(2)
                State.ok, State.response = pcall(function()
                    return requestFunc({
                        Url = "https://duckyscripts.pythonanywhere.com/api/tapsim/users", Method = "GET"
                    })
                end)

                if State.ok and State.response and State.response.Body then
                    State.ok2, data = pcall(function()
                        return HttpService:JSONDecode(State.response.Body)
                    end)

                    if State.ok2 and data then
                        State.userCountParagraph:SetValue(
                            "Total users: " .. tostring(data.count or 0) .. "\n" ..
                            "Active Users: " .. tostring(data.active or 0)
                        )
                        return
                    end
                end

                State.userCountParagraph:SetValue("Total users: ?\nActive Users: ?")
            end)
        end)

        State.loadSuccess = true
    end)

    if success and State.loadSuccess then
        print(string.format("[Tap Simulator] Successfully loaded on attempt %d/%d", attempt, State.maxRetries))
        break
    else
        warn(string.format("[Tap Simulator] Failed to load (Attempt %d/%d): %s", attempt, State.maxRetries, tostring(State.errorMsg)))
        
        if attempt < State.maxRetries then
            warn(string.format("[Tap Simulator] Retrying in %d seconds...", State.retryDelay))
            task.wait(State.retryDelay)
        else
            warn("[Tap Simulator] Failed to load after " .. State.maxRetries .. " attempts. Please try again.")
        end
    end
end
