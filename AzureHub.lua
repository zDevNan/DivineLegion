local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Farm Script",
    SubTitle = "Auto Farm Fluent",
    TabWidth = 100,
    Size = UDim2.fromOffset(600, 350),
    Acrylic = true,
    Theme = "Dark"
    MinimizeKey = Enum.KeyCode.LeftControl
})

local AutoTab = Window:AddTab({ Title = "Automation" })

local function ResetData()
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("Stats")
end

local function ClaimAllDailies()
    local args = {"Claim", "AllDaily"}
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. game.Players.LocalPlayer.UserId):WaitForChild("ChallengesRemote"):FireServer(unpack(args))
end

local function GetMission()
    while true do
        local missionText = game:GetService("Players").LocalPlayer.PlayerGui.MissionGui.Frame.Frame.Header.Text
        if missionText == "Mission Objective" then break end
        ResetData()
        workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
        task.wait(1)
    end
end

local function UseCompass()
    local backpack = game.Players.LocalPlayer.Backpack
    local character = game.Players.LocalPlayer.Character
    local humanoid = character:FindFirstChild("Humanoid")
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    
    local compass = backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoid:UnequipTools()
        compass.Parent = character
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        compass:Activate()
    end
end

local function BuySlingshot()
    local args = {"Slingshot", 1000}
    workspace:WaitForChild("Merchants"):WaitForChild("SniperMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer(unpack(args))
end

local function FarmMobs()
    local allowedMobs = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}
    while _G.AutoFarm do
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                for _, allowed in ipairs(allowedMobs) do
                    if string.find(mob.Name, allowed) then
                        local playerRoot = game.Players.LocalPlayer.Character.HumanoidRootPart
                        playerRoot.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)
                        playerRoot.Anchored = true
                        while mob.Humanoid.Health > 0 and _G.AutoFarm do
                            game.Players.LocalPlayer.Character:FindFirstChild("Slingshot"):Activate()
                            task.wait(0.1)
                        end
                        playerRoot.Anchored = false
                        break
                    end
                end
            end
        end
        task.wait(1)
    end
end

AutoTab:AddToggle("Automation", {
    Title = "Enable Automation",
    Default = false,
    Callback = function(state)
        _G.AutoFarm = state
        _G.AutoMission = state
        _G.AutoCompass = state
        _G.AutoSlingshot = state
        if state then
            GetMission()
            UseCompass()
            BuySlingshot()
            FarmMobs()
            ClaimAllDailies()
        end
    end
})
