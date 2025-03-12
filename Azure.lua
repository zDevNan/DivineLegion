local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local enemies = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

-- Compra o Slingshot
local function comprarSlingshot()
    local args = {
        [1] = "Buy",
        [2] = "Slingshot"
    }
    workspace.Merchants.SniperMerchant.Clickable.Retum:FireServer(unpack(args))
    wait(2) -- Espera um pouco antes de equipar
end

-- Equipa o Slingshot da mochila
local function equiparSlingshot()
    local backpack = player.Backpack
    local slingshot = backpack:FindFirstChild("Slingshot")

    if slingshot then
        player.Character.Humanoid:EquipTool(slingshot)
    else
        warn("Slingshot não encontrado na mochila!")
    end
end

-- Move o jogador até um mob e atira até derrotá-lo
local function atacarMobs()
    for _, mob in ipairs(workspace.Enemies:GetChildren()) do
        if table.find(enemies, mob.Name) then
            while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 do
                humanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame + Vector3.new(0, 25, 0) -- Mantém distância segura
                game:GetService("ReplicatedStorage").Weapons.Slingshot.Fire:FireServer(mob.HumanoidRootPart.Position)
                wait(0.5)
            end
        end
    end
end

-- Executa o processo completo
comprarSlingshot()
equiparSlingshot()
wait(1)
atacarMobs()
