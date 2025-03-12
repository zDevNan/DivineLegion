local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local slingshotEvent = character:WaitForChild("Slingshot"):WaitForChild("RemoteEvent")

local allowedMobs = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

while wait(1) do -- Pequeno delay para evitar lag
    local closestMob = nil
    local closestDistance = math.huge

    -- Encontra o mob mais próximo
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:IsA("Model") and table.find(allowedMobs, mob.Name) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")
            if mobRoot then
                local distance = (humanoidRootPart.Position - mobRoot.Position).Magnitude
                if distance < closestDistance then
                    closestMob = mobRoot
                    closestDistance = distance
                end
            end
        end
    end

    if closestMob then
        -- Move o jogador 25 unidades acima do mob
        humanoidRootPart.CFrame = closestMob.CFrame * CFrame.new(0, 25, 0)

        -- Atira continuamente até o mob morrer
        while closestMob and closestMob.Parent and closestMob.Parent:FindFirstChildOfClass("Humanoid") and closestMob.Parent:FindFirstChildOfClass("Humanoid").Health > 0 do
            local args = {
                [1] = humanoidRootPart.CFrame * CFrame.new(0, -5, 0), -- Dispara para baixo
                [2] = closestMob
            }
            slingshotEvent:FireServer(unpack(args))
            wait(0.3) -- Intervalo entre os tiros
        end
    end
end
