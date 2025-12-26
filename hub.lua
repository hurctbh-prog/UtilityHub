-- Lemon Freezer v1.3.1 - Compatible Zeno Executor
-- Script complet avec fonctionnalités

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Configuration globale
local Config = {
    StarterPower = 0.25,
    MainPower = 0.5,
    Duration = 0.5,
    StarterActive = false,
    MainActive = false,
    LagAfterSteal = false
}

local connections = {}

-- Fonctions principales
local function createServerLag(power, targetPlayer)
    -- Méthode 1: Spam de RemoteEvents
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            for i = 1, power * 50 do
                pcall(function()
                    v:FireServer(string.rep("a", 1000))
                end)
            end
        end
    end
    
    -- Méthode 2: Création d'instances
    spawn(function()
        for i = 1, power * 100 do
            local part = Instance.new("Part")
            part.Anchored = true
            part.Size = Vector3.new(0.1, 0.1, 0.1)
            part.Transparency = 1
            part.CanCollide = false
            if targetPlayer and targetPlayer.Character then
                part.Position = targetPlayer.Character.HumanoidRootPart.Position
            end
            game:GetService("Debris"):AddItem(part, 0.1)
        end
    end)
end

local function getHighestPlayer()
    local highest = nil
    local highestCash = 0
    
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local leaderstats = plr:FindFirstChild("leaderstats")
            if leaderstats then
                local cash = leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("coins")
                if cash and cash.Value > highestCash then
                    highestCash = cash.Value
                    highest = plr
                end
            end
        end
    end
    
    return highest
end

local function teleportToPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then 
        warn("Joueur cible invalide")
        return 
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    local playerChar = player.Character
    local playerRoot = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
    
    if targetRoot and playerRoot then
        playerRoot.CFrame = targetRoot.CFrame * CFrame.new(5, 0, 5)
        print("[Lemon Freezer] Téléporté à " .. targetPlayer.Name)
    end
end

local function activateStarterLag()
    if Config.StarterActive then
        local highest = getHighestPlayer()
        if highest then
            print("[Starter Lag] Activation sur " .. highest.Name)
            createServerLag(Config.StarterPower, highest)
        end
    end
end

local function activateMainLag()
    if Config.MainActive then
        local highest = getHighestPlayer()
        if highest then
            print("[Main Lag] Activation sur " .. highest.Name)
            createServerLag(Config.MainPower, highest)
            
            if Config.LagAfterSteal then
                wait(Config.Duration)
                createServerLag(Config.MainPower * 0.5, highest)
            end
        end
    end
end

local function stopAll()
    Config.StarterActive = false
    Config.MainActive = false
    
    for _, conn in pairs(connections) do
        if conn then conn:Disconnect() end
    end
    connections = {}
    
    print("[Lemon Freezer] Tous les effets arrêtés")
end

-- Création de l'interface
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LemonFreezerUI_v131"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true

-- Protection pour Zeno
pcall(function()
    if syn and syn.protect_gui then
        syn.protect_gui(screenGui)
    end
end)

screenGui.Parent = player.PlayerGui

-- Frame principale
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 650, 0, 450)
main.Position = UDim2.new(0.5, -325, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(255, 140, 0)
stroke.Thickness = 4

-- Header
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -20, 0, 40)
header.Position = UDim2.new(0, 10, 0, 10)
header.BackgroundTransparency = 1
header.Text = "⚡ LEMON FREEZER - Dual Mode v1.3.1"
header.TextColor3 = Color3.fromRGB(255, 140, 0)
header.TextSize = 22
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = main

-- Container panels
local panelContainer = Instance.new("Frame")
panelContainer.Size = UDim2.new(1, -20, 0, 220)
panelContainer.Position = UDim2.new(0, 10, 0, 60)
panelContainer.BackgroundTransparency = 1
panelContainer.Parent = main

-- STARTER PANEL
local starterPanel = Instance.new("Frame")
starterPanel.Size = UDim2.new(0.48, 0, 1, 0)
starterPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
starterPanel.BorderSizePixel = 0
starterPanel.Parent = panelContainer

Instance.new("UICorner", starterPanel).CornerRadius = UDim.new(0, 8)
local starterStroke = Instance.new("UIStroke", starterPanel)
starterStroke.Color = Color3.fromRGB(0, 255, 0)
starterStroke.Thickness = 2

local starterTitle = Instance.new("TextLabel")
starterTitle.Size = UDim2.new(1, -20, 0, 25)
starterTitle.Position = UDim2.new(0, 10, 0, 10)
starterTitle.BackgroundTransparency = 1
starterTitle.Text = "⚡ STARTER LAG"
starterTitle.TextColor3 = Color3.fromRGB(100, 255, 100)
starterTitle.TextSize = 16
starterTitle.Font = Enum.Font.GothamBold
starterTitle.TextXAlignment = Enum.TextXAlignment.Left
starterTitle.Parent = starterPanel

local starterPowerLabel = Instance.new("TextLabel")
starterPowerLabel.Size = UDim2.new(1, -20, 0, 18)
starterPowerLabel.Position = UDim2.new(0, 10, 0, 40)
starterPowerLabel.BackgroundTransparency = 1
starterPowerLabel.Text = "Power (0.01-100):"
starterPowerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
starterPowerLabel.TextSize = 12
starterPowerLabel.Font = Enum.Font.Gotham
starterPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
starterPowerLabel.Parent = starterPanel

local starterInput = Instance.new("TextBox")
starterInput.Size = UDim2.new(1, -20, 0, 32)
starterInput.Position = UDim2.new(0, 10, 0, 62)
starterInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
starterInput.BorderSizePixel = 0
starterInput.Text = "0.25"
starterInput.TextColor3 = Color3.fromRGB(255, 200, 0)
starterInput.TextSize = 18
starterInput.Font = Enum.Font.GothamBold
starterInput.Parent = starterPanel
Instance.new("UICorner", starterInput).CornerRadius = UDim.new(0, 6)

local starterBtn = Instance.new("TextButton")
starterBtn.Size = UDim2.new(1, -20, 0, 35)
starterBtn.Position = UDim2.new(0, 10, 0, 105)
starterBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
starterBtn.BorderSizePixel = 0
starterBtn.Text = "⚡ ACTIVATE"
starterBtn.TextColor3 = Color3.white
starterBtn.TextSize = 14
starterBtn.Font = Enum.Font.GothamBold
starterBtn.Parent = starterPanel
Instance.new("UICorner", starterBtn).CornerRadius = UDim.new(0, 6)

local starterTPBtn = Instance.new("TextButton")
starterTPBtn.Size = UDim2.new(1, -20, 0, 32)
starterTPBtn.Position = UDim2.new(0, 10, 0, 148)
starterTPBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
starterTPBtn.BorderSizePixel = 0
starterTPBtn.Text = "⚡ START + TP HIGHEST"
starterTPBtn.TextColor3 = Color3.white
starterTPBtn.TextSize = 12
starterTPBtn.Font = Enum.Font.GothamBold
starterTPBtn.Parent = starterPanel
Instance.new("UICorner", starterTPBtn).CornerRadius = UDim.new(0, 6)

-- MAIN PANEL
local mainPanel = Instance.new("Frame")
mainPanel.Size = UDim2.new(0.48, 0, 1, 0)
mainPanel.Position = UDim2.new(0.52, 0, 0, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = panelContainer

Instance.new("UICorner", mainPanel).CornerRadius = UDim.new(0, 8)
local mainStroke = Instance.new("UIStroke", mainPanel)
mainStroke.Color = Color3.fromRGB(255, 80, 80)
mainStroke.Thickness = 2

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, -20, 0, 25)
mainTitle.Position = UDim2.new(0, 10, 0, 10)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "🔥 MAIN LAG"
mainTitle.TextColor3 = Color3.fromRGB(255, 140, 0)
mainTitle.TextSize = 16
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextXAlignment = Enum.TextXAlignment.Left
mainTitle.Parent = mainPanel

local mainPowerLabel = Instance.new("TextLabel")
mainPowerLabel.Size = UDim2.new(1, -20, 0, 18)
mainPowerLabel.Position = UDim2.new(0, 10, 0, 40)
mainPowerLabel.BackgroundTransparency = 1
mainPowerLabel.Text = "Power (0.01-100):"
mainPowerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
mainPowerLabel.TextSize = 12
mainPowerLabel.Font = Enum.Font.Gotham
mainPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
mainPowerLabel.Parent = mainPanel

local mainInput = Instance.new("TextBox")
mainInput.Size = UDim2.new(1, -20, 0, 32)
mainInput.Position = UDim2.new(0, 10, 0, 62)
mainInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainInput.BorderSizePixel = 0
mainInput.Text = "0.5"
mainInput.TextColor3 = Color3.fromRGB(255, 200, 0)
mainInput.TextSize = 18
mainInput.Font = Enum.Font.GothamBold
mainInput.Parent = mainPanel
Instance.new("UICorner", mainInput).CornerRadius = UDim.new(0, 6)

local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(1, -20, 0, 35)
mainBtn.Position = UDim2.new(0, 10, 0, 105)
mainBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
mainBtn.BorderSizePixel = 0
mainBtn.Text = "⚡ ACTIVATE"
mainBtn.TextColor3 = Color3.white
mainBtn.TextSize = 14
mainBtn.Font = Enum.Font.GothamBold
mainBtn.Parent = mainPanel
Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 6)

-- Options
local lagAfterLabel = Instance.new("TextLabel")
lagAfterLabel.Size = UDim2.new(0.5, 0, 0, 15)
lagAfterLabel.Position = UDim2.new(0, 10, 0, 150)
lagAfterLabel.BackgroundTransparency = 1
lagAfterLabel.Text = "Lag After Steal:"
lagAfterLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
lagAfterLabel.TextSize = 11
lagAfterLabel.Font = Enum.Font.Gotham
lagAfterLabel.TextXAlignment = Enum.TextXAlignment.Left
lagAfterLabel.Parent = mainPanel

local lagAfterBtn = Instance.new("TextButton")
lagAfterBtn.Size = UDim2.new(0, 50, 0, 18)
lagAfterBtn.Position = UDim2.new(0, 195, 0, 148)
lagAfterBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
lagAfterBtn.BorderSizePixel = 0
lagAfterBtn.Text = "OFF"
lagAfterBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
lagAfterBtn.TextSize = 11
lagAfterBtn.Font = Enum.Font.GothamBold
lagAfterBtn.Parent = mainPanel
Instance.new("UICorner", lagAfterBtn).CornerRadius = UDim.new(0, 4)

local durationLabel = Instance.new("TextLabel")
durationLabel.Size = UDim2.new(0.5, 0, 0, 15)
durationLabel.Position = UDim2.new(0, 10, 0, 172)
durationLabel.BackgroundTransparency = 1
durationLabel.Text = "Duration (sec):"
durationLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
durationLabel.TextSize = 11
durationLabel.Font = Enum.Font.Gotham
durationLabel.TextXAlignment = Enum.TextXAlignment.Left
durationLabel.Parent = mainPanel

local durationInput = Instance.new("TextBox")
durationInput.Size = UDim2.new(0, 50, 0, 18)
durationInput.Position = UDim2.new(0, 195, 0, 170)
durationInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
durationInput.BorderSizePixel = 0
durationInput.Text = "0.5"
durationInput.TextColor3 = Color3.fromRGB(255, 200, 0)
durationInput.TextSize = 11
durationInput.Font = Enum.Font.GothamBold
durationInput.Parent = mainPanel
Instance.new("UICorner", durationInput).CornerRadius = UDim.new(0, 4)

-- Bottom buttons
local bottomFrame = Instance.new("Frame")
bottomFrame.Size = UDim2.new(1, -20, 0, 38)
bottomFrame.Position = UDim2.new(0, 10, 0, 290)
bottomFrame.BackgroundTransparency = 1
bottomFrame.Parent = main

local tpHighestBtn = Instance.new("TextButton")
tpHighestBtn.Size = UDim2.new(0.32, -3, 1, 0)
tpHighestBtn.Position = UDim2.new(0, 0, 0, 0)
tpHighestBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
tpHighestBtn.BorderSizePixel = 0
tpHighestBtn.Text = "⚡ TP TO HIGHEST"
tpHighestBtn.TextColor3 = Color3.white
tpHighestBtn.TextSize = 12
tpHighestBtn.Font = Enum.Font.GothamBold
tpHighestBtn.Parent = bottomFrame
Instance.new("UICorner", tpHighestBtn).CornerRadius = UDim.new(0, 6)

local kickBtn = Instance.new("TextButton")
kickBtn.Size = UDim2.new(0.32, -3, 1, 0)
kickBtn.Position = UDim2.new(0.34, 0, 0, 0)
kickBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
kickBtn.BorderSizePixel = 0
kickBtn.Text = "⚡ Kick Self"
kickBtn.TextColor3 = Color3.white
kickBtn.TextSize = 12
kickBtn.Font = Enum.Font.GothamBold
kickBtn.Parent = bottomFrame
Instance.new("UICorner", kickBtn).CornerRadius = UDim.new(0, 6)

local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(0.32, -3, 1, 0)
stopBtn.Position = UDim2.new(0.68, 0, 0, 0)
stopBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopBtn.BorderSizePixel = 0
stopBtn.Text = "⬛ STOP ALL"
stopBtn.TextColor3 = Color3.white
stopBtn.TextSize = 12
stopBtn.Font = Enum.Font.GothamBold
stopBtn.Parent = bottomFrame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)

-- Floor section
local floorFrame = Instance.new("Frame")
floorFrame.Size = UDim2.new(1, -20, 0, 88)
floorFrame.Position = UDim2.new(0, 10, 0, 342)
floorFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
floorFrame.BorderSizePixel = 0
floorFrame.Parent = main
Instance.new("UICorner", floorFrame).CornerRadius = UDim.new(0, 8)
local floorStroke = Instance.new("UIStroke", floorFrame)
floorStroke.Color = Color3.fromRGB(255, 140, 0)
floorStroke.Thickness = 2

local floorLabel = Instance.new("TextLabel")
floorLabel.Size = UDim2.new(1, -20, 0, 22)
floorLabel.Position = UDim2.new(0, 10, 0, 8)
floorLabel.BackgroundTransparency = 1
floorLabel.Text = "🔓 UNLOCK FLOOR (on highest brainrot's base):"
floorLabel.TextColor3 = Color3.fromRGB(255, 180, 100)
floorLabel.TextSize = 12
floorLabel.Font = Enum.Font.GothamBold
floorLabel.TextXAlignment = Enum.TextXAlignment.Left
floorLabel.Parent = floorFrame

local floorBtnFrame = Instance.new("Frame")
floorBtnFrame.Size = UDim2.new(1, -20, 0, 36)
floorBtnFrame.Position = UDim2.new(0, 10, 0, 38)
floorBtnFrame.BackgroundTransparency = 1
floorBtnFrame.Parent = floorFrame

for i = 1, 3 do
    local floorBtn = Instance.new("TextButton")
    floorBtn.Size = UDim2.new(0.32, -3, 1, 0)
    floorBtn.Position = UDim2.new((i-1) * 0.34, 0, 0, 0)
    floorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    floorBtn.BorderSizePixel = 0
    floorBtn.Text = "Floor " .. i
    floorBtn.TextColor3 = Color3.white
    floorBtn.TextSize = 13
    floorBtn.Font = Enum.Font.GothamBold
    floorBtn.Parent = floorBtnFrame
    Instance.new("UICorner", floorBtn).CornerRadius = UDim.new(0, 6)
    
    floorBtn.MouseButton1Click:Connect(function()
        local highest = getHighestPlayer()
        if highest then
            teleportToPlayer(highest)
            print("[Floor " .. i .. "] Téléportation effectuée")
        else
            warn("Aucun joueur trouvé")
        end
    end)
end

-- Event handlers
starterBtn.MouseButton1Click:Connect(function()
    Config.StarterPower = tonumber(starterInput.Text) or 0.25
    Config.StarterActive = not Config.StarterActive
    
    if Config.StarterActive then
        starterBtn.Text = "⚡ DEACTIVATE"
        starterBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        activateStarterLag()
    else
        starterBtn.Text = "⚡ ACTIVATE"
        starterBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end
end)

mainBtn.MouseButton1Click:Connect(function()
    Config.MainPower = tonumber(mainInput.Text) or 0.5
    Config.MainActive = not Config.MainActive
    
    if Config.MainActive then
        mainBtn.Text = "⚡ DEACTIVATE"
        mainBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        activateMainLag()
    else
        mainBtn.Text = "⚡ ACTIVATE"
        mainBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

starterTPBtn.MouseButton1Click:Connect(function()
    Config.StarterPower = tonumber(starterInput.Text) or 0.25
    Config.StarterActive = true
    starterBtn.Text = "⚡ DEACTIVATE"
    starterBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    
    local highest = getHighestPlayer()
    if highest then
        activateStarterLag()
        wait(0.5)
        teleportToPlayer(highest)
    end
end)

lagAfterBtn.MouseButton1Click:Connect(function()
    Config.LagAfterSteal = not Config.LagAfterSteal
    if Config.LagAfterSteal then
        lagAfterBtn.Text = "ON"
        lagAfterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        lagAfterBtn.TextColor3 = Color3.white
    else
        lagAfterBtn.Text = "OFF"
        lagAfterBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        lagAfterBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

durationInput.FocusLost:Connect(function()
    Config.Duration = tonumber(durationInput.Text) or 0.5
end)

tpHighestBtn.MouseButton1Click:Connect(function()
    local highest = getHighestPlayer()
    if highest then
        teleportToPlayer(highest)
    else
        warn("Aucun joueur avec stats trouvé")
    end
end)

kickBtn.MouseButton1Click:Connect(function()
    player:Kick("Auto-kick activé")
end)

stopBtn.MouseButton1Click:Connect(function()
    stopAll()
    starterBtn.Text = "⚡ ACTIVATE"
    starterBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    mainBtn.Text = "⚡ ACTIVATE"
    mainBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
end)

-- Auto-loop pour les effets actifs
table.insert(connections, RunService.Heartbeat:Connect(function()
    if Config.StarterActive then
        activateStarterLag()
        wait(0.5)
    end
    if Config.MainActive then
        activateMainLag()
        wait(1)
    end
end))

print("[Lemon Freezer v1.3.1] Chargé avec succès!")
print("Compatible avec Zeno Executor")
print("Interface draggable - Tire sur la frame pour la déplacer")
}):Play()

print("🔥 SLAYZHUB v4.2 LOADED - GREEN EDITION!")
