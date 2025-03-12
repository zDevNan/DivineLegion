local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

local function ResetGameDate()
    Workspace:WaitForChild("UserData"):WaitForChild("User_"..LocalPlayer.UserId):WaitForChild("Stats").Date.Value = 0
    print("Data do jogo resetada.")
end

local function ClaimDailyRewards()
    local ChallengesRemote = Workspace.UserData["User_"..LocalPlayer.UserId].ChallengesRemote
    ChallengesRemote:FireServer("Claim", "Daily1")
    ChallengesRemote:FireServer("Claim", "Daily2")
    ChallengesRemote:FireServer("Claim", "Daily3")
    ChallengesRemote:FireServer("Claim", "Daily4")
    ChallengesRemote:FireServer("Claim", "AllDaily")
    print("Recompensas diárias resgatadas.")
end

local function CheckMission()
    local MissionGui = LocalPlayer.PlayerGui.MissionGui.Frame.Frame.Header
    return MissionGui.Text == "Mission Objective"
end

local function GetCompassAndUse()
    local Compass = Workspace.UserData["User_"..LocalPlayer.UserId]:FindFirstChild("Compass")
    if Compass then
        LocalPlayer.Character.HumanoidRootPart.CFrame = Compass.Poser.Value
        wait(1)
        Compass:Activate()
        print("Compass ativado.")
    end
end

local function FarmBeri()
    local UserData = Workspace.UserData["User_"..LocalPlayer.UserId]
    local Cash = UserData.Data.Cash
    local Slingshot = UserData.Backpack:FindFirstChild("Slingshot")

    if not Slingshot then
        print("Comprando Slingshot...")
        -- Código para comprar Slingshot
    end

    for _, mob in pairs(Workspace.Mobs:GetChildren()) do
        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
            LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 25, 0)
            while mob.Humanoid.Health > 0 do
                Slingshot:Activate()
                wait(0.5)
            end
            print("Mob derrotado:", mob.Name)
        end
    end

    if Cash.Value >= 10000 then
        print("Farm concluído, 10k Beri obtidos!")
    else
        print("Ainda falta Beri.")
    end
end

-- Execução do fluxo
while true do
    if not CheckMission() then
        ResetGameDate()
        wait(1)
    else
        GetCompassAndUse()
        ClaimDailyRewards()
        FarmBeri()
        wait(10)
    end
end
