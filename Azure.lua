local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- **Função para resetar a data do jogo**
local function ResetGameDate()
    local Stats = Workspace:WaitForChild("UserData"):WaitForChild("User_"..LocalPlayer.UserId):WaitForChild("Stats")
    Stats.Date.Value = 0
    print("⏳ Data do jogo resetada.")
end

-- **Função para pegar a missão**
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
            -- Pega outra missão
            workspace:WaitForChild("Merchants"):WaitForChild("ExpertiseMerchant"):WaitForChild("Clickable"):WaitForChild("Retum"):FireServer()
        end
    end
    return false
end

-- **Loop para garantir que a missão correta seja pega**
spawn(function()
    while true do
        wait(1)
        if GetMission() then
            break -- Sai do loop quando a missão estiver correta
        end
    end
end)
