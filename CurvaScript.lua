-- Garantindo que o script funcione corretamente no executor
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Acesso direto ao ReplicatedStorage
local replicatedstorage = game:GetService('ReplicatedStorage')

-- Tenta acessar a pasta Values e o CurveMultiplier
local foldercurve = replicatedstorage:FindFirstChild('Values')
if foldercurve then
    local foldercurve2 = foldercurve:FindFirstChild('CurveMultiplier')
    
    if foldercurve2 then
        -- Criar o botão flutuante na tela do jogador
        local screenGui = Instance.new("ScreenGui")
        screenGui.ResetOnSpawn = false  -- Mantém o GUI mesmo após o reset
        screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        -- Criação do Frame do Menu
        local menuFrame = Instance.new("Frame")
        menuFrame.Size = UDim2.new(0, 220, 0, 150)
        menuFrame.Position = UDim2.new(0.5, -110, 0.5, -75)
        menuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        menuFrame.BorderSizePixel = 2
        menuFrame.Visible = true
        menuFrame.Parent = screenGui

        -- Botão para aumentar a curva
        local increaseButton = Instance.new("TextButton")
        increaseButton.Size = UDim2.new(0, 200, 0, 50)
        increaseButton.Position = UDim2.new(0, 10, 0, 10)
        increaseButton.Text = "Aumentar Curva"
        increaseButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        increaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        increaseButton.Parent = menuFrame

        -- Botão para diminuir a curva
        local decreaseButton = Instance.new("TextButton")
        decreaseButton.Size = UDim2.new(0, 200, 0, 50)
        decreaseButton.Position = UDim2.new(0, 10, 0, 70)
        decreaseButton.Text = "Diminuir Curva"
        decreaseButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        decreaseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        decreaseButton.Parent = menuFrame

        -- Botão de Abrir/Fechar o Menu
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0, 100, 0, 40)
        toggleButton.Position = UDim2.new(0, 10, 0, 10)
        toggleButton.Text = "Fechar Menu"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 170)
        toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        toggleButton.Parent = screenGui

        -- Função para aumentar a curva
        local function aumentarCurva()
            foldercurve2.Value = foldercurve2.Value * 1.5  -- Aumenta a intensidade da curva
            print("CurveMultiplier aumentado!")
        end

        -- Função para diminuir a curva
        local function diminuirCurva()
            foldercurve2.Value = foldercurve2.Value / 1.5  -- Diminui a intensidade da curva
            print("CurveMultiplier diminuído!")
        end

        -- Função para mover o menu (arrastar)
        local function criarMovimentoDoBotao(botao)
            local dragging, dragInput, dragStart, startPos

            local function update(input)
                local delta = input.Position - dragStart
                botao.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end

            botao.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    dragStart = input.Position
                    startPos = botao.Position
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)

            botao.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
                    update(input)
                end
            end)
        end

        -- Conectar o movimento ao menu
        criarMovimentoDoBotao(menuFrame)

        -- Conectar o botão "Aumentar Curva" ao evento de clique
        increaseButton.MouseButton1Click:Connect(function()
            aumentarCurva()
        end)

        -- Conectar o botão "Diminuir Curva" ao evento de clique
        decreaseButton.MouseButton1Click:Connect(function()
            diminuirCurva()
        end)

        -- Função para abrir/fechar o menu
        toggleButton.MouseButton1Click:Connect(function()
            menuFrame.Visible = not menuFrame.Visible
            if menuFrame.Visible then
                toggleButton.Text = "Fechar Menu"
            else
                toggleButton.Text = "Abrir Menu"
            end
        end)

        print("Menu com botão de abrir/fechar criado com sucesso!")
    else
        warn("CurveMultiplier não encontrado.")
    end
else
    warn("Pasta 'Values' não encontrada.")
end
