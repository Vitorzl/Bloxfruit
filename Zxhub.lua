-- ##########################################################################################
-- Configurações Iniciais
-- ##########################################################################################
getgenv().SelectedIsland = "Pirate Starter Island"  -- Ilha inicial
getgenv().SelectedSea = "First Sea"  -- Sea inicial
getgenv().ESPEnabled = true  -- Ativar ESP
getgenv().AutoFarmEnabled = false  -- Ativar AutoFarm
getgenv().AutoBossEnabled = false  -- Ativar Auto Boss

-- ##########################################################################################
-- Mapeamento das Ilhas e suas Coordenadas
-- ##########################################################################################
local Islands = {
    ["First Sea"] = {
        ["Pirate Starter Island"] = CFrame.new(200, 10, 300),
        ["Moss Island"] = CFrame.new(100, 10, 200),
        ["Jungle Island"] = CFrame.new(500, 10, 600),
        -- Adicione mais ilhas conforme necessário
    },
    ["Second Sea"] = {
        ["Castle on the Sea"] = CFrame.new(1500, 10, 1600),
        -- Adicione mais ilhas conforme necessário
    },
    ["Third Sea"] = {
        ["Haunted Castle"] = CFrame.new(5500, 90, 5600),
        -- Adicione mais ilhas conforme necessário
    }
}

-- ##########################################################################################
-- Funções de Teleporte e Proteção de Kick
-- ##########################################################################################
function TeleportToIsland()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    -- Pega a coordenada da ilha selecionada
    local islandPos = Islands[getgenv().SelectedSea][getgenv().SelectedIsland]
    
    -- Verifica se a coordenada da ilha é válida
    if islandPos then
        -- Verifica se a posição é válida (fora do mapa)
        if islandPos.Position.X > 10000 or islandPos.Position.Y > 500 or islandPos.Position.Z > 10000 then
            -- Kicka o jogador se a posição for inválida
            game:GetService("Players").LocalPlayer:Kick("Posição inválida para teleporte!")
        else
            -- Teleporta o jogador para a posição da ilha
            hrp.CFrame = islandPos
        end
    else
        -- Caso a ilha não exista ou não tenha coordenada, kicka o jogador
        game:GetService("Players").LocalPlayer:Kick("Ilha não encontrada!")
    end
end

-- ##########################################################################################
-- Funções de ESP (Espiar objetos e Bosses)
-- ##########################################################################################
function ESP()
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()

    -- Adiciona a ESP para os Bosses e jogadores
    for _, v in ipairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
            if v.Humanoid.Health > 0 then
                local box = Instance.new("BoxHandleAdornment")
                box.Adornee = v:FindFirstChild("Head") or v:FindFirstChild("HumanoidRootPart")
                box.Size = Vector3.new(3, 5, 3)
                box.Color3 = Color3.fromRGB(255, 0, 0) -- Vermelho para Bosses
                box.Transparency = 0.5
                box.Parent = game.CoreGui
            end
        end
    end
end

-- ##########################################################################################
-- Funções de Auto Farm
-- ##########################################################################################
function AutoFarm()
    -- Aqui você coloca a lógica para farmar automaticamente, atacando inimigos, etc.
    -- Exemplo: Automatizar ataques a NPCs ou coleta de recursos
end

-- ##########################################################################################
-- Funções de Auto Boss
-- ##########################################################################################
function AutoBoss()
    -- Lógica para derrotar Bosses automaticamente
    -- Exemplo: Encontrar Bosses no mapa e derrotá-los automaticamente
end

-- ##########################################################################################
-- Funções da GUI (Interface Gráfica)
-- ##########################################################################################
local Window = loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
local IslandTab = Window:MakeTab({
    Name = "Teleportar Ilhas",
    Icon = "rbxassetid://113422439338527",  -- Ícone atualizado
    PremiumOnly = false
})

-- Dropdown para escolher o Sea
IslandTab:AddDropdown({
    Name = "Escolha o Sea",
    Default = "First Sea",
    Options = {"First Sea", "Second Sea", "Third Sea"},
    Callback = function(Value)
        getgenv().SelectedSea = Value
    end
})

-- Dropdown para escolher a Ilha
IslandTab:AddDropdown({
    Name = "Escolha a Ilha",
    Default = "Pirate Starter Island",
    Options = {
        "Pirate Starter Island", "Moss Island", "Jungle Island", "Desert Island", "Sky Island", 
        "Frozen Village", "Little Garden", "Alabasta", "Sabaody Archipelago", "Enies Lobby", 
        "Marineford", "Skypiea", "Impel Down", -- Adicione mais ilhas conforme necessário
    },
    Callback = function(Value)
        getgenv().SelectedIsland = Value
    end
})

-- Botão para Teleportar
IslandTab:AddButton({
    Name = "Teletransportar",
    Callback = function()
        TeleportToIsland()
    end
})

-- Criando a aba para AutoFarm e AutoBoss
local FarmTab = Window:MakeTab({
    Name = "Farma e Bosses",
    Icon = "rbxassetid://113422439338527",  -- Ícone atualizado
    PremiumOnly = false
})

-- Toggle para Ativar/Desativar Auto Farm
FarmTab:AddToggle({
    Name = "Ativar Auto Farm",
    Default = false,
    Callback = function(Value)
        getgenv().AutoFarmEnabled = Value
        if Value then
            AutoFarm()
        end
    end
})

-- Toggle para Ativar/Desativar Auto Boss
FarmTab:AddToggle({
    Name = "Ativar Auto Boss",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBossEnabled = Value
        if Value then
            AutoBoss()
        end
    end
})

-- Toggle para Ativar/Desativar ESP
FarmTab:AddToggle({
    Name = "Ativar ESP",
    Default = true,
    Callback = function(Value)
        getgenv().ESPEnabled = Value
        if Value then
            ESP()
        end
    end
})

-- Botão para Desativar Todos os Recursos
FarmTab:AddButton({
    Name = "Desativar Todos",
    Callback = function()
        -- Desativa todos os recursos
        getgenv().AutoFarmEnabled = false
        getgenv().AutoBossEnabled = false
        getgenv().ESPEnabled = false
    end
})

-- Botão para Teleportar para o Spawn
FarmTab:AddButton({
    Name = "Teleportar para Spawn",
    Callback = function()
        -- Exemplo de teleporte para o spawn
        local spawnPosition = CFrame.new(0, 100, 0)  -- Mude para as coordenadas do spawn
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp.CFrame = spawnPosition
    end
})
