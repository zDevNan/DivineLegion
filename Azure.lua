local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Backpack = LocalPlayer:FindFirstChild("Backpack")

local mobsPermitidos = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

-- **🔄 Resetar a Data do Jogo**
local function resetData()
    local userId = LocalPlayer.UserId
    print("🔄 Resetando a data do jogo...")
    
    local success, err = pcall(function()
        Workspace:WaitForChild("UserData"):WaitForChild("User_" .. userId):WaitForChild("Stats"):FireServer()
    end)

    if success then
        print("✅ Data resetada com sucesso!")
    else
        print("⚠️ Falha ao resetar data: " .. err)
    end

    wait(3) -- Dá tempo para o reset ser aplicado
end

-- **📜 Pegar a Missão do Expertise Merchant**
local function getMission()
    local expertiseMerchant = Workspace:WaitForChild("Merchants"):WaitForChild("ExpertiseMerchant")
    local clickable = expertiseMerchant:WaitForChild("Clickable")
    local missionGui = LocalPlayer.PlayerGui:WaitForChild("MissionGui", 5)

    for i = 1, 10 do -- Tenta até 10 vezes pegar a missão correta
        print("📜 Tentando pegar a missão... (Tentativa " .. i .. ")")
        clickable.Retum:FireServer()
        wait(2) -- Dá tempo para o GUI atualizar

        if missionGui and missionGui:FindFirstChild("Frame") and missionGui.Frame:FindFirstChild("Header") then
            local missionName = missionGui.Frame.Header.Text
            print("📜 Missão recebida: " .. missionName)

            if missionName == "Mission Objective" then
                print("✅ Missão correta obtida!")
                return true
            else
                print("❌ Missão errada! Resetando data e tentando novamente...")
                resetData()
            end
        else
            print("⚠️ GUI da missão não encontrado! Tentando novamente...")
        end
    end

    print("⚠️ Falha ao pegar a missão correta após 10 tentativas.")
    return false
end

-- **📍 Pegar e Ativar o Compass**
local function getAndUseCompass()
    print("📍 Pegando um Compass...")
    Workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
    wait(2)

    local compass = Backpack:FindFirstChild("Compass")
    if compass then
        compass.Parent = Character
        wait(1)

        local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and compass:FindFirstChild("Poser") then
            print("📍 Teleportando para a posição do Compass...")
            humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
        else
            print("⚠️ Falha ao encontrar Poser do Compass!")
        end
    else
        print("⚠️ Compass não encontrado na mochila!")
    end
end

-- **🛒 Comprar e Equipar o Slingshot**
local function getAndEquipSlingshot()
    print("🛒 Comprando Slingshot...")
    Workspace.Merchants.WeaponMerchant.Clickable.Retum:FireServer("BuySlingshot")
    wait(2)

    local slingshot = Backpack:FindFirstChild("Slingshot")
    if slingshot then
        print("🎯 Equipando Slingshot...")
        slingshot.Parent = Character
    else
        print("⚠️ Slingshot não encontrado na mochila!")
    end
end

-- **🎯 Atacar Mobs com Slingshot**
local function attackMobs()
    print("🎯 Iniciando ataque aos mobs...")
    for _, mob in ipairs(Workspace.Enemies:GetChildren()) do
        if table.find(mobsPermitidos, mob.Name) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
            if mobRoot then
                local humanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.CFrame = mobRoot.CFrame * CFrame.new(0, 25, 0)
                end
                
                while mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
                    print("🎯 Atacando: " .. mob.Name)
                    Workspace.Remotes.WeaponRemote:FireServer("SlingshotAttack", mobRoot.Position)
                    wait(0.5)
                end
            end
        end
    end
end

-- **💰 Verificar Beri e Pegar Daily2**
local function checkBeriAndClaimDaily2()
    local userId = LocalPlayer.UserId
    local beriValue = Workspace.UserData["User_" .. userId].Data.Cash.Value

    if beriValue >= 10000 then
        print("💰 Pegando recompensa do Daily2...")
        Workspace.UserData["User_" .. userId].ChallengesRemote:FireServer("Claim", "Daily2")
    else
        print("⚠️ Não tem Beri suficiente para Daily2! (" .. beriValue .. "/10000)")
    end
end

-- **🎁 Resgatar Recompensas do Daily**
local function claimAllDaily()
    local userId = LocalPlayer.UserId
    print("🎁 Pegando recompensas do AllDaily...")
    Workspace.UserData["User_" .. userId].ChallengesRemote:FireServer("Claim", "AllDaily")
end

-- **🚀 Execução Principal**
if getMission() then
    wait(2)
    getAndUseCompass()
    wait(2)
    getAndEquipSlingshot()
    wait(2)
    attackMobs()
    wait(2)
    checkBeriAndClaimDaily2()
    wait(2)
    claimAllDaily()
end
