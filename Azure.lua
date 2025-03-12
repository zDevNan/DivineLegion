local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local slingshotEvent = character:WaitForChild("Slingshot"):WaitForChild("RemoteEvent")

local allowedMobs = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

while true do
    wait(0.5) -- Evita sobrecarga no servidor

    -- Verifica os inimigos no workspace
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:IsA("Model") and table.find(allowedMobs, mob.Name) then
            local mobRoot = mob:FindFirstChild("HumanoidRootPart")

            if mobRoot then
                -- Move o jogador 25 unidades acima do mob
                humanoidRootPart.CFrame = mobRoot.CFrame * CFrame.new(0, 25, 0)

                -- Atira para baixo repetidamente enquanto o mob estiver vivo
                while mobRoot and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChildOfClass("Humanoid").Health > 0 do
                    local args = {
                        [1] = humanoidRootPart.CFrame * CFrame.new(0, -5, 0), -- Dispara para baixo
                        [2] = mobRoot
                    }
                    slingshotEvent:FireServer(unpack(args))
                    wait(0.3) -- Intervalo entre os tiros
                end
            end
        end
    end
end
