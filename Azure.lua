local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local slingshotEvent = character:WaitForChild("Slingshot"):WaitForChild("RemoteEvent")

local allowedMobs = {"Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy"}

while true do
    wait(0.5) -- Evita sobrecarga no servidor

    -- Verifica os inimigos no workspace
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:IsA("Model") and table.find(allowedMobs, mob.Name) then
            local mobHead = mob:FindFirstChild("WeldToHead") or mob:FindFirstChild("HumanoidRootPart")

            if mobHead then
                local args = {
                    [1] = mobHead.CFrame, -- Dispara na posição do mob
                    [2] = mobHead -- Define o alvo específico
                }
                slingshotEvent:FireServer(unpack(args)) -- Atira no mob
            end
        end
    end
end
