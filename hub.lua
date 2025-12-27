- SLAYZHUB XENO GO v4.2 🔥 INTERFACE MODERNE PREMIUM
-- Design violet-noir moderne avec animations fluides

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

-- Frame principale avec glassmorphism
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 580, 0, 480)
MainFrame.Position = UDim2.new(0.5, -290, 0.5, -240)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 10, 30)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 20)
MainCorner.Parent = MainFrame

-- Effet de bordure néon
local BorderGlow = Instance.new("UIStroke")
BorderGlow.Color = Color3.fromRGB(138, 43, 226)
BorderGlow.Thickness = 2
BorderGlow.Transparency = 0.3
BorderGlow.Parent = MainFrame

-- Animation de la bordure
spawn(function()
    while wait() do
        if MainFrame.Parent then
            TweenService:Create(BorderGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(186, 85, 211)
            }):Play()
            wait(2)
            TweenService:Create(BorderGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(138, 43, 226)
            }):Play()
        else
            break
        end
    end
end)

-- Barre de titre moderne
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 15, 45)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = TitleBar

-- Masque pour garder les coins arrondis seulement en haut
local TitleMask = Instance.new("Frame")
TitleMask.Size = UDim2.new(1, 0, 0, 20)
TitleMask.Position = UDim2.new(0, 0, 1, -20)
TitleMask.BackgroundColor3 = Color3.fromRGB(28, 15, 45)
TitleMask.BackgroundTransparency = 0.1
TitleMask.BorderSizePixel = 0
TitleMask.Parent = TitleBar

-- Logo et titre
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 40, 0, 40)
LogoLabel.Position = UDim2.new(0, 15, 0.5, -20)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "🔥"
LogoLabel.TextScaled = true
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 300, 0, 30)
TitleLabel.Position = UDim2.new(0, 60, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SLAYZHUB PREMIUM"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 300, 0, 18)
SubtitleLabel.Position = UDim2.new(0, 60, 0, 35)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "v4.2 • Anti-Crash Actif"
SubtitleLabel.TextColor3 = Color3.fromRGB(186, 85, 211)
SubtitleLabel.TextSize = 13
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Parent = TitleBar

-- Bouton fermer moderne
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -50, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(40, 25, 55)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 24
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(138, 43, 226)
CloseStroke.Thickness = 1.5
CloseStroke.Transparency = 0.5
CloseStroke.Parent = CloseButton

-- Effet hover sur le bouton fermer
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 25, 55)
    }):Play()
end)

-- Frame des onglets
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, -40, 0, 50)
TabsFrame.Position = UDim2.new(0, 20, 0, 75)
TabsFrame.BackgroundTransparency = 1
TabsFrame.Parent = MainFrame

-- Fonction pour créer un onglet
local function createTab(name, text, icon, position)
    local Tab = Instance.new("TextButton")
    Tab.Name = name
    Tab.Size = UDim2.new(0.48, 0, 1, 0)
    Tab.Position = position
    Tab.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    Tab.BorderSizePixel = 0
    Tab.Text = ""
    Tab.AutoButtonColor = false
    Tab.Parent = TabsFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)
    TabCorner.Parent = Tab
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = Color3.fromRGB(138, 43, 226)
    TabStroke.Thickness = 1.5
    TabStroke.Transparency = 0.8
    TabStroke.Parent = Tab
    
    -- Icône
    local TabIcon = Instance.new("TextLabel")
    TabIcon.Size = UDim2.new(0, 25, 0, 25)
    TabIcon.Position = UDim2.new(0, 15, 0.5, -12.5)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Text = icon
    TabIcon.TextScaled = true
    TabIcon.Font = Enum.Font.GothamBold
    TabIcon.Parent = Tab
    
    -- Texte
    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(1, -50, 0, 20)
    TabLabel.Position = UDim2.new(0, 45, 0.5, -10)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Text = text
    TabLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabLabel.TextSize = 15
    TabLabel.Font = Enum.Font.GothamBold
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.Parent = Tab
    
    return Tab, TabStroke, TabLabel
end

-- Création des onglets
local PremiumTab, PremiumStroke, PremiumLabel = createTab("PremiumTab", "PREMIUM", "💎", UDim2.new(0, 0, 0, 0))
local ESPTab, ESPStroke, ESPLabel = createTab("ESPTab", "ESP", "👁️", UDim2.new(0.52, 0, 0, 0))

-- Zone de contenu
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -100)
ContentFrame.Position = UDim2.new(0, 20, 0, 80)
ContentFrame.Size = UDim2.new(1, -40, 1, -155)
ContentFrame.Position = UDim2.new(0, 20, 0, 140)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Contenu Premium
local PremiumContent = Instance.new("Frame")
PremiumContent.Name = "PremiumContent"
PremiumContent.Size = UDim2.new(1, 0, 1, 0)
PremiumContent.BackgroundTransparency = 1
PremiumContent.Visible = true
PremiumContent.Parent = ContentFrame

-- Grille de boutons modernes
local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.new(0.48, 0, 0, 80)
GridLayout.CellPadding = UDim2.new(0.02, 0, 0, 15)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.Parent = ContentFrame
GridLayout.Parent = PremiumContent

-- Contenu ESP (vide pour l'instant)
local ESPContent = Instance.new("Frame")
ESPContent.Name = "ESPContent"
ESPContent.Size = UDim2.new(1, 0, 1, 0)
ESPContent.BackgroundTransparency = 1
ESPContent.Visible = false
ESPContent.Parent = ContentFrame

local ESPPlaceholder = Instance.new("TextLabel")
ESPPlaceholder.Size = UDim2.new(1, 0, 0, 100)
ESPPlaceholder.Position = UDim2.new(0, 0, 0.5, -50)
ESPPlaceholder.BackgroundTransparency = 1
ESPPlaceholder.Text = "🚧 ESP Features\nComing Soon..."
ESPPlaceholder.TextColor3 = Color3.fromRGB(138, 43, 226)
ESPPlaceholder.TextSize = 20
ESPPlaceholder.Font = Enum.Font.GothamBold
ESPPlaceholder.TextTransparency = 0.3
ESPPlaceholder.Parent = ESPContent

-- Fonction pour changer d'onglet
local function switchTab(tab)
    -- Réinitialiser tous les onglets
    PremiumStroke.Transparency = 0.8
    PremiumLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    PremiumTab.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    PremiumContent.Visible = false
    
    ESPStroke.Transparency = 0.8
    ESPLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ESPTab.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    ESPContent.Visible = false
    
    -- Activer l'onglet sélectionné
    if tab == "Premium" then
        PremiumStroke.Transparency = 0.2
        PremiumLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        PremiumTab.BackgroundColor3 = Color3.fromRGB(45, 30, 65)
        PremiumContent.Visible = true
    elseif tab == "ESP" then
        ESPStroke.Transparency = 0.2
        ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ESPTab.BackgroundColor3 = Color3.fromRGB(45, 30, 65)
        ESPContent.Visible = true
    end
end

-- Events des onglets
PremiumTab.MouseButton1Click:Connect(function()
    switchTab("Premium")
end)

ESPTab.MouseButton1Click:Connect(function()
    switchTab("ESP")
end)

-- Activer l'onglet Premium par défaut
switchTab("Premium")

-- Fonction pour créer un bouton moderne
local function createModernButton(name, text, icon, color1, color2)
@@ -187,174 +311,174 @@
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = ContentFrame
    Button.Parent = PremiumContent

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 15)
    ButtonCorner.Parent = Button

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = color1
    ButtonStroke.Thickness = 1.5
    ButtonStroke.Transparency = 0.6
    ButtonStroke.Parent = Button

    -- Icône
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 35, 0, 35)
    Icon.Position = UDim2.new(0, 12, 0.5, -17.5)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextScaled = true
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Button

    -- Texte
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 0, 25)
    Label.Position = UDim2.new(0, 52, 0.5, -12.5)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextSize = 16
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    -- Gradient subtle
    local Gradient = Instance.new("UIGradient")
    Gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    }
    Gradient.Rotation = 45
    Gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.85),
        NumberSequenceKeypoint.new(1, 0.9)
    }
    Gradient.Parent = Button

    -- Effet hover
    Button.MouseEnter:Connect(function()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {Transparency = 0.2}):Play()
        TweenService:Create(Gradient, TweenInfo.new(0.2), {
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.7),
                NumberSequenceKeypoint.new(1, 0.8)
            }
        }):Play()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(0.48, 0, 0, 85)}):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {Transparency = 0.6}):Play()
        TweenService:Create(Gradient, TweenInfo.new(0.2), {
            Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0, 0.85),
                NumberSequenceKeypoint.new(1, 0.9)
            }
        }):Play()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = GridLayout.CellSize}):Play()
    end)

    return Button
end

-- Création des boutons
-- Création des boutons dans l'ordre demandé
local FPSDevourer = createModernButton("FPSDevourer", "FPS DEVOURER", "💀", 
    Color3.fromRGB(155, 89, 182), Color3.fromRGB(142, 68, 173))

local InstantTP = createModernButton("InstantTP", "INSTANT TP", "⚡", 
    Color3.fromRGB(52, 152, 219), Color3.fromRGB(41, 128, 185))

local Nameless = createModernButton("Nameless", "NAMELESS", "👻", 
    Color3.fromRGB(231, 76, 60), Color3.fromRGB(192, 57, 43))

local AutoBlock = createModernButton("AutoBlock", "AUTO-BLOCK", "🛡️", 
    Color3.fromRGB(46, 204, 113), Color3.fromRGB(39, 174, 96))

local FPSDevourer = createModernButton("FPSDevourer", "FPS DEVOURER", "💀", 
    Color3.fromRGB(155, 89, 182), Color3.fromRGB(142, 68, 173))
local Nameless = createModernButton("Nameless", "NAMELESS", "👻", 
    Color3.fromRGB(231, 76, 60), Color3.fromRGB(192, 57, 43))

-- Fonctions de chargement sécurisées
local function safeLoadstring(url)
    pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
end

-- Events des boutons
InstantTP.MouseButton1Click:Connect(function()
    safeLoadstring("https://pandadevelopment.net/virtual/file/3e58fa5b69bab3b3")
end)

Nameless.MouseButton1Click:Connect(function()
    safeLoadstring("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
end)

AutoBlock.MouseButton1Click:Connect(function()
    safeLoadstring("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer")
end)

FPSDevourer.MouseButton1Click:Connect(function()
    antiCrashActive = true
    FPSDevourer:FindFirstChild("TextLabel").Text = "ACTIVÉ ✓"
    FPSDevourer:FindFirstChildOfClass("TextLabel").Text = "ACTIVÉ ✓"

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

InstantTP.MouseButton1Click:Connect(function()
    safeLoadstring("https://pandadevelopment.net/virtual/file/3e58fa5b69bab3b3")
end)

AutoBlock.MouseButton1Click:Connect(function()
    safeLoadstring("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer")
end)

Nameless.MouseButton1Click:Connect(function()
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

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
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
MainFrame.BackgroundTransparency = 1

wait(0.1)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 580, 0, 480),
    BackgroundTransparency = 0.05
}):Play()

print("🔥 SLAYZHUB v4.2 MODERNE CHARGÉ!")
