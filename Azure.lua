local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local MobList = { "Boar", "Crab", "Angry", "Thief", "Gunslinger", "Freddy" }

local function IsMobAllowed(mobName)
    for _, allowedMob in ipairs(MobList) do
        if string.find(mobName, allowedMob) then
            return true
        end
    end
    return false
end

spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.farmPosition then
                character = player.Character or player.CharacterAdded:Wait()
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart then
                    for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
                        if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") 
                            and mob.Humanoid.Health > 0 and IsMobAllowed(mob.Name) then
                            
                            local mobRoot = mob.HumanoidRootPart
                            humanoidRootPart.CFrame = mobRoot.CFrame * CFrame.new(0, 25, 0) -- 25 unidades acima do mob
                            
                            break -- Para evitar movimentações desnecessárias
                        end
                    end
                end
            end
        end)
    end
end)
