local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Backpack = LocalPlayer.Backpack

local mobsPermitidos = {"Boar", "Crab", "Angry", "Thief", "Freddy"}

-- **Função para resetar a data do jogo**
local function resetData()
    local userId = LocalPlayer.UserId
    Workspace:WaitForChild("UserData"):WaitForChild("User_" .. userId):WaitForChild("Stats"):FireServer()
end

-- **Função para pegar a missão do Expertise Merchant**
local function getMission()
    local expertiseMerchant = Workspace:WaitForChild("Merchants"):WaitForChild("ExpertiseMerchant")
    local clickable = expertiseMerchant:WaitForChild("Clickable")
    local missionGui = LocalPlayer.PlayerGui:FindFirstChild("MissionGui")

    -- Loop para garantir que pega a missão certa
    for i = 1, 10 do -- Tenta 10 vezes no máximo
        clickable.Retum:FireServer()
        wait(1)

        -- Verifica se pegou a missão correta
        if missionGui and missionGui:FindFirstChild("Frame") and missionGui.Frame:FindFirstChild("Header") then
            local missionName = missionGui.Frame.Header.Text
            if missionName == "Mission Objective" then
                print("✅ Missão correta obtida!")
                return true
            else
                print("❌ Missão errada, resetando data...")
                resetData()
                wait(2)
            end
        end
    end

    print("⚠️ Não conseguiu pegar a missão correta!")
    return false
end

-- **Função para pegar e ativar o Compass**
local function getAndUseCompass()
    -- Pega um Compass
    Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
    wait(1)

    -- Equipa o Compass e teleporta o jogador
    local compass = Backpack:FindFirstChild("Compass")
    if compass then
        compass.Parent = Character -- Move para o personagem (equipa)
        wait(1)

        -- **Teleporta o player para o objetivo**
        local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and compass:FindFirstChild("Poser") then
            humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        end
    end
end

-- **Função para comprar e equipar o Slingshot**
local function getAndEquipSlingshot()
    Workspace.Merchants.WeaponMerchant.Clickable.Retum:FireServer("BuySlingshot")
    wait(1)
    
    local slingshot = Backpack:FindFirstChild("Slingshot")
    if slingshot then
        slingshot.Parent = Character
    end
end

-- **Função para atacar mobs com o Slingshot**
local function attackMobs()
    for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
        if table.find(mobsPermitidos, mob.Name) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
            if mobRoot then
                -- Posição acima do mob para atacar de longe
                local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.CFrame = mobRoot.CFrame * CFrame.new(0, 25, 0)
                end
                
                -- Atira no mob até ele morrer
                while mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
                    -- Simula um ataque com o Slingshot
                    Workspace.Remotes.WeaponRemote:FireServer("SlingshotAttack", mobRoot.Position)
                    wait(0.5)
                end
            end
        end
    end
end

-- **Função para verificar Beri e pegar Daily2**
local function checkBeriAndClaimDaily2()
    local userId = LocalPlayer.UserId
    local beriValue = Workspace:FindFirstChild("UserData"):FindFirstChild("User_" .. userId):FindFirstChild("Data"):FindFirstChild("Cash").Value

    if beriValue >= 10000 then
        Workspace.UserData["User_" .. userId].ChallengesRemote:FireServer("Claim", "Daily2")
    end
end

-- **Função para resgatar todas as recompensas do Daily**
local function claimAllDaily()
    local userId = LocalPlayer.UserId
    Workspace.UserData["User_" .. userId].ChallengesRemote:FireServer("Claim", "AllDaily")
end

-- **Execução principal do script**
if getMission() then
    wait(1)
    getAndUseCompass() -- Pega o Compass e teleporta
    wait(1)
    getAndEquipSlingshot() -- Compra e equipa o Slingshot
    wait(1)
    attackMobs() -- Faz as 30 kills necessárias
    wait(1)
    checkBeriAndClaimDaily2() -- Verifica se tem 10k Beri antes de pegar Daily2
    wait(1)
    claimAllDaily() -- Resgata as recompensas do Daily quando tudo estiver pronto
end
