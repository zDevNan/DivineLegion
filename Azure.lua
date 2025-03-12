local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- **Lista dos mobs permitidos**
local AllowedMobs = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

-- **Resetar a data do jogo**
local function ResetGameDate()
    local Stats = Workspace:WaitForChild("UserData"):WaitForChild("User_"..LocalPlayer.UserId):WaitForChild("Stats")
    Stats.Date.Value = 0
    print("⏳ Data do jogo resetada.")
end

-- **Pegar a missão correta**
local function GetMission()
    local MissionGui = LocalPlayer.PlayerGui:FindFirstChild("MissionGui")

    if MissionGui then
        local MissionText = MissionGui.Frame.Frame.Header.Text

        if MissionText == "Mission Objective" then
            print("✅ Missão correta obtida!")
            return true
        else
            print("❌ Missão errada, resetando...")
            ResetGameDate()
            wait(1)
            workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer()
        end
    end
    return false
end

-- **Pegar um Compass**
local function GetCompass()
    workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
    print("🧭 Compass coletado!")
    wait(2)
end

-- **Usar o Compass**
local function UseCompass()
    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if Backpack then
        local Compass = Backpack:FindFirstChild("Compass")
        if Compass then
            LocalPlayer.Character.Humanoid:EquipTool(Compass)
            local Poser = Compass:FindFirstChild("Poser")
            if Poser then
                LocalPlayer.Character.HumanoidRootPart.CFrame = Poser.Value
                print("📍 Posição do Compass alcançada.")
                wait(2)
                Compass:Activate()
                print("🧭 Compass ativado!")
            end
        end
    end
end

-- **Resgatar a recompensa do Compass**
local function ClaimCompassReward()
    local CompassEvent = Workspace.UserData["User_"..LocalPlayer.UserId].ChallengesRemote
    CompassEvent:FireServer("Claim", "Daily4")
    print("🎁 Recompensa do Compass coletada.")
end

-- **Comprar e equipar o Slingshot**
local function BuyAndEquipSlingshot()
    workspace.Merchants.WeaponMerchant.Clickable.Retum:FireServer()
    print("🏹 Slingshot comprado.")

    local Backpack = LocalPlayer:FindFirstChild("Backpack")
    if Backpack then
        local Slingshot = Backpack:FindFirstChild("Slingshot")
        if Slingshot then
            LocalPlayer.Character.Humanoid:EquipTool(Slingshot)
            print("🏹 Slingshot equipado.")
        end
    end
end

-- **Fazer 30 kills com o Slingshot nos mobs permitidos**
local function Complete30Kills()
    local Kills = 0

    while Kills < 30 do
        for _, MobName in ipairs(AllowedMobs) do
            local Mob = Workspace.Enemies:FindFirstChild(MobName)
            if Mob and Mob:FindFirstChild("Humanoid") and Mob.Humanoid.Health > 0 then
                -- Posiciona o jogador acima do mob
                LocalPlayer.Character.HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame + Vector3.new(0, 25, 0)

                -- Atira no mob até ele morrer
                local Slingshot = LocalPlayer.Character:FindFirstChild("Slingshot")
                if Slingshot then
                    while Mob.Humanoid.Health > 0 do
                        Slingshot:Activate()
                        wait(1)
                    end

                    Kills = Kills + 1
                    print("☠️ Kill "..Kills.." de 30 concluída!")
                    if Kills >= 30 then break end
                end
            end
        end
        wait(1)
    end

    print("✅ 30 Kills concluídas!")
end

-- **Verificar se o jogador tem 10k Beri antes de pegar o Daily2**
local function CheckBeri()
    local Data = Workspace.UserData["User_"..LocalPlayer.UserId].Data
    local Cash = Data.Cash.Value

    while Cash < 10000 do
        print("💰 Aguardando 10k Beri... (atualmente: "..Cash.." Beri)")
        wait(2)
        Cash = Data.Cash.Value
    end

    print("💰 10k Beri alcançados!")
end

-- **Completar as missões diárias (agora Daily2 só após 10k Beri)**
local function CompleteDailyMissions()
    print("📌 Completando missões diárias...")

    local DailyEvent = Workspace.UserData["User_"..LocalPlayer.UserId].ChallengesRemote

    -- Fazer uma missão (2.5k Beri)
    DailyEvent:FireServer("Claim", "Daily1")

    -- **Aguardar 10k Beri antes de resgatar o Daily2**
    CheckBeri()
    DailyEvent:FireServer("Claim", "Daily2")

    -- Fazer um Compass
    DailyEvent:FireServer("Claim", "Daily4")

    -- Resgatar 30 kills APÓS completar
    DailyEvent:FireServer("Claim", "Daily3")

    print("✅ Todas as missões diárias foram completadas.")
end

-- **Resgatar todas as recompensas do Daily (somente após completar tudo)**
local function ClaimAllDaily()
    local DailyEvent = Workspace.UserData["User_"..LocalPlayer.UserId].ChallengesRemote
    DailyEvent:FireServer("Claim", "AllDaily")
    print("🎁 Recompensas do Daily coletadas (10 gem).")
end

-- **Resetar a data do jogo após tudo**
local function FinalReset()
    ResetGameDate()
    print("🔄 Data resetada após completar todas as tarefas.")
end

-- **Execução**
spawn(function()
    while true do
        wait(1)
        if GetMission() then
            GetCompass()
            wait(2)
            UseCompass()
            wait(5)
            ClaimCompassReward()
            wait(2)
            BuyAndEquipSlingshot()
            wait(2)
            Complete30Kills() -- Agora faz 30 kills apenas nos mobs permitidos
            wait(2)
            CompleteDailyMissions()
            wait(2)
            ClaimAllDaily()
            wait(2)
            FinalReset()
            break
        end
    end
end)
