local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(0, 280, 0, 50)
Button.Position = UDim2.new(0, 10, 0, 10)
Button.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
Button.Text = "Executar Script"
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Parent = Frame

Button.MouseButton1Click:Connect(function()
    print("Executando seu script...")
    
    -- Coloque o seu script aqui
    local function MeuScript()
        print("Script rodando!")
    end

    MeuScript()
end)
