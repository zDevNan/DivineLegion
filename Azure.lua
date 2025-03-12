local player = game:GetService("Players").LocalPlayer
local slingshotEvent = player:WaitForChild("RemoteEvent")

while true do
    wait(0.5) -- Ajuste para não sobrecarregar o servidor

    -- Procura um mob dentro da lista dos permitidos
    for _, mob in pairs(workspace.Enemies:GetChildren()) do
        if mob:IsA("Model") and (mob.Name == "Boar" or mob.Name == "Crab" or mob.Name == "Angry" or mob.Name == "Thief" or mob.Name == "Gunslinger" or mob.Name == "Freddy") then
            local mobPosition = mob:FindFirstChild("HumanoidRootPart")
            
            if mobPosition then
                local args = {
                    [1] = mobPosition.CFrame
                }
                slingshotEvent:FireServer(unpack(args)) -- Atira no mob
            end
        end
    end
end
