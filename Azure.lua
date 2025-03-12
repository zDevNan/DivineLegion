local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local missionGui = player.PlayerGui:WaitForChild("MissionGui")
local cashData = workspace.UserData["User_" .. player.UserId].Data.Cash
local enemies = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"} -- To pensando em tirar gunslinger pq ele atira

-- Função da resetar a data
local function resetData()
    workspace:WaitForChild("UserData"):WaitForChild("User_" .. player.UserId):WaitForChild("Stats"):FireServer()
    wait(2)
end

-- Função para pegar a missão Expertise
local function pegarMissao()
    workspace.Merchants.ExpertiseMerchant.Clickable.Retum:FireServer()
    wait(2) -- tempo para o servidor processar a nova missão
end

-- Verifica se a missão é "Complete 1 quest objectives."
local function verificarMissao()
    local descricao = missionGui.Frame.Frame.Description.Text
    return descricao:match("Complete 1 quest objectives%.")
end

-- Loop para garantir que a missão seja a correta
local function garantirMissaoCorreta()
    while not verificarMissao() do
        resetData()
        pegarMissao()
    end
end

-- Pega um Compass
local function pegarCompass()
    workspace.Merchants.QuestMerchant.Clickable.Retum:FireServer("Claim1")
end

-- Move o jogador até o objetivo do Compass
local function moverParaCompass()
    local compass = player.Backpack:FindFirstChild("Compass")
    if compass and compass:FindFirstChild("Poser") then
        humanoidRootPart.CFrame = CFrame.new(compass.Poser.Value)
    end
end

-- Atacar mobs com o Slingshot
local function atacarMobs()
    for _, mob in ipairs(workspace.Enemies:GetChildren()) do
        if table.find(enemies, mob.Name) then
            while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
                humanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 25, 0) -- Fica acima do mob
                game:GetService("ReplicatedStorage").Weapons.Slingshot.Fire:FireServer(mob.HumanoidRootPart.Position)
                wait(0.5)
            end
        end
    end
end

-- Verifica se o jogador tem 10k Beri antes de resgatar o Daily2
local function verificarBeri()
    return cashData.Value >= 10000
end

-- Resgata as recompensas diárias
local function resgatarDaily()
    workspace.UserData["User_" .. player.UserId].ChallengesRemote:FireServer("Claim", "Daily1")
    if verificarBeri() then
        workspace.UserData["User_" .. player.UserId].ChallengesRemote:FireServer("Claim", "Daily2")
    end
    workspace.UserData["User_" .. player.UserId].ChallengesRemote:FireServer("Claim", "Daily3") -- 30 kills
    workspace.UserData["User_" .. player.UserId].ChallengesRemote:FireServer("Claim", "Daily4") -- Compass
end

-- Processo principal
while true do
    garantirMissaoCorreta() -- Garante que a missão seja a certa antes de prosseguir
    pegarCompass()
    wait(2)
    moverParaCompass()
    wait(2)
    atacarMobs()
    resgatarDaily()
    wait(10) -- Aguarda um tempo antes de rodar de novo
end
