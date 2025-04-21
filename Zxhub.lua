
local ZxHub = Instance.new("ScreenGui") ZxHub.Name = "ZxHub" ZxHub.Parent = game.CoreGui

local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 320, 0, 450) MainFrame.Position = UDim2.new(0.5, -160, 0.5, -225) MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) MainFrame.BorderSizePixel = 0 MainFrame.Parent = ZxHub

local Title = Instance.new("TextLabel") Title.Text = "Zx Hub | Edição 2025" Title.Size = UDim2.new(1, 0, 0, 45) Title.BackgroundColor3 = Color3.fromRGB(0, 170, 255) Title.TextColor3 = Color3.new(1, 1, 1) Title.Font = Enum.Font.GothamBold Title.TextScaled = true Title.Parent = MainFrame

local function createButton(text, posY, callback) local btn = Instance.new("TextButton") btn.Text = text btn.Size = UDim2.new(0.9, 0, 0, 38) btn.Position = UDim2.new(0.05, 0, 0, posY) btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60) btn.TextColor3 = Color3.new(1, 1, 1) btn.Font = Enum.Font.Gotham btn.TextScaled = true btn.Parent = MainFrame btn.MouseButton1Click:Connect(callback) end

-- Auto Farm Inteligente local autoFarm = false function SmartAutoFarm() autoFarm = not autoFarm print("[ZxHub] AutoFarm " .. (autoFarm and "Ativado" or "Desativado"))

while autoFarm do
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        for _, npc in pairs(workspace.Enemies:GetChildren()) do
            if npc:FindFirstChild("Humanoid") and npc:FindFirstChild("HumanoidRootPart") then
                repeat
                    char.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Z", false, game)
                    wait(0.2)
                until npc.Humanoid.Health <= 0 or not autoFarm
            end
        end
    end
    wait(1)
end

end

-- ESP Atualizado function ESPPlayers() for _, player in pairs(game.Players:GetPlayers()) do if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then if not player.Character.Head:FindFirstChild("ZxESP") then local esp = Instance.new("BillboardGui", player.Character.Head) esp.Name = "ZxESP" esp.Size = UDim2.new(0, 200, 0, 50) esp.AlwaysOnTop = true local text = Instance.new("TextLabel", esp) text.Size = UDim2.new(1, 0, 1, 0) text.Text = player.Name text.TextColor3 = Color3.fromRGB(255, 50, 50) text.BackgroundTransparency = 1 text.TextScaled = true end end end end

-- Auto Stats function AutoStats() local stats = {"Melee", "Defense", "Sword"} for _, stat in pairs(stats) do game:GetService("ReplicatedStorage").Remotes.CommF:InvokeServer("AddPoint", stat, 255) end print("[Zx Hub] Pontos aplicados!") end

-- Teleport com Menu function Teleport() local locations = { ["Inicio"] = Vector3.new(1059, 15, 1550), ["Jungle"] = Vector3.new(-1448, 67, 11), ["Pirate Island"] = Vector3.new(-1103, 13, 3896) } for name, pos in pairs(locations) do print("[Zx Hub] Indo para " .. name) game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos) wait(1.5) end end

-- Server Hop function ServerHop() print("[Zx Hub] Pulando para outro servidor...") local ts = game:GetService("TeleportService") ts:Teleport(game.PlaceId, game.Players.LocalPlayer) end

-- Criando os botões createButton("Auto Farm Inteligente", 60, SmartAutoFarm) createButton("ESP Players", 110, ESPPlayers) createButton("Auto Stats", 160, AutoStats) createButton("Teleport Ilhas", 210, Teleport) createButton("Server Hop", 260, ServerHop) createButton("Fechar GUI", 310, function() ZxHub:Destroy() end)
