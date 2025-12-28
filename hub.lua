-- SLAYZHUB XENO GO v4.2 🔥 INTERFACE MODERNE PREMIUM
-- Design noir-vert moderne avec animations fluides + FONCTIONNALITÉS ACTIVES

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

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

-- Frame principale rectangle carré noir-vert
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 500)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- Effet de bordure néon vert
local BorderGlow = Instance.new("UIStroke")
BorderGlow.Color = Color3.fromRGB(0, 255, 127)
BorderGlow.Thickness = 2
BorderGlow.Transparency = 0.3
BorderGlow.Parent = MainFrame

-- Animation de la bordure
spawn(function()
    while wait() do
        if MainFrame.Parent then
            TweenService:Create(BorderGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(46, 255, 159)
            }):Play()
            wait(2)
            TweenService:Create(BorderGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = Color3.fromRGB(0, 255, 127)
            }):Play()
        else
            break
        end
    end
end)

-- Barre de titre moderne
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

-- Logo et titre
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 35, 0, 35)
LogoLabel.Position = UDim2.new(0, 15, 0.5, -17.5)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "⚡"
LogoLabel.TextScaled = true
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
LogoLabel.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 0, 25)
TitleLabel.Position = UDim2.new(0, 55, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SLAYZHUB PREMIUM"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(0, 250, 0, 15)
SubtitleLabel.Position = UDim2.new(0, 55, 0, 32)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "v4.2 • Anti-Crash Actif"
SubtitleLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
SubtitleLabel.TextSize = 12
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Parent = TitleBar

-- Bouton fermer moderne
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0.5, -15)
CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 20
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(0, 255, 127)
CloseStroke.Thickness = 1.5
CloseStroke.Transparency = 0.5
CloseStroke.Parent = CloseButton

-- Effet hover sur le bouton fermer
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    }):Play()
end)

-- Frame des onglets VERTICAUX à gauche
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(0, 120, 1, -70)
TabsFrame.Position = UDim2.new(0, 10, 0, 60)
TabsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabsFrame.BackgroundTransparency = 0.2
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

local TabsCorner = Instance.new("UICorner")
TabsCorner.CornerRadius = UDim.new(0, 12)
TabsCorner.Parent = TabsFrame

-- Fonction pour créer un onglet vertical
local function createVerticalTab(name, text, icon)
    local Tab = Instance.new("TextButton")
    Tab.Name = name
    Tab.Size = UDim2.new(1, -10, 0, 60)
    Tab.Position = UDim2.new(0, 5, 0, (#TabsFrame:GetChildren() - 2) * 65)
    Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tab.BorderSizePixel = 0
    Tab.Text = ""
    Tab.AutoButtonColor = false
    Tab.Parent = TabsFrame
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = Tab
    
    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = Color3.fromRGB(0, 255, 127)
    TabStroke.Thickness = 1.5
    TabStroke.Transparency = 0.8
    TabStroke.Parent = Tab
    
    -- Icône
    local TabIcon = Instance.new("TextLabel")
    TabIcon.Size = UDim2.new(0, 30, 0, 30)
    TabIcon.Position = UDim2.new(0.5, -15, 0, 5)
    TabIcon.BackgroundTransparency = 1
    TabIcon.Text = icon
    TabIcon.TextScaled = true
    TabIcon.Font = Enum.Font.GothamBold
    TabIcon.Parent = Tab
    
    -- Texte
    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(1, 0, 0, 20)
    TabLabel.Position = UDim2.new(0, 0, 1, -25)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Text = text
    TabLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabLabel.TextSize = 14
    TabLabel.Font = Enum.Font.GothamBold
    TabLabel.TextXAlignment = Enum.TextXAlignment.Center
    TabLabel.Parent = Tab
    
    return Tab, TabStroke, TabLabel
end

-- Création des onglets verticaux
local PremiumTab, PremiumStroke, PremiumLabel = createVerticalTab("PremiumTab", "PREMIUM", "💎")
local ESPTab, ESPStroke, ESPLabel = createVerticalTab("ESPTab", "ESP", "👁️")

-- Zone de contenu à droite
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Size = UDim2.new(1, -140, 1, -70)
ContentFrame.Position = UDim2.new(0, 135, 0, 60)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ContentFrame.BackgroundTransparency = 0.1
ContentFrame.BorderSizePixel = 0
ContentFrame.ScrollBarThickness = 6
ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 127)
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentFrame

local ContentListLayout = Instance.new("UIListLayout")
ContentListLayout.Padding = UDim.new(0, 10)
ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentListLayout.Parent = ContentFrame

-- Contenu Premium
local PremiumContent = Instance.new("Frame")
PremiumContent.Name = "PremiumContent"
PremiumContent.Size = UDim2.new(1, -20, 0, 0)
PremiumContent.BackgroundTransparency = 1
PremiumContent.Visible = false
PremiumContent.Parent = ContentFrame

-- Contenu ESP
local ESPContent = Instance.new("Frame")
ESPContent.Name = "ESPContent"
ESPContent.Size = UDim2.new(1, -20, 0, 0)
ESPContent.BackgroundTransparency = 1
ESPContent.Visible = false
ESPContent.Parent = ContentFrame

local ESPPlaceholder = Instance.new("TextLabel")
ESPPlaceholder.Size = UDim2.new(1, 0, 0, 100)
ESPPlaceholder.Position = UDim2.new(0, 0, 0.5, -50)
ESPPlaceholder.BackgroundTransparency = 1
ESPPlaceholder.Text = "🚧 ESP Features\nComing Soon..."
ESPPlaceholder.TextColor3 = Color3.fromRGB(0, 255, 127)
ESPPlaceholder.TextSize = 18
ESPPlaceholder.Font = Enum.Font.GothamBold
ESPPlaceholder.TextXAlignment = Enum.TextXAlignment.Center
ESPPlaceholder.Parent = ESPContent

-- ÉTAT DES BOUTONS
local instantTPActive = false
local autoBlockActive = false
local namelessActive = false

-- ✅ CASE 1: INSTANT TP FONCTIONNELLE
local InstantTP = Instance.new("TextButton")
InstantTP.Name = "InstantTP"
InstantTP.Size = UDim2.new(1, 0, 0, 55)
InstantTP.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
InstantTP.BorderSizePixel = 0
InstantTP.Text = ""
InstantTP.AutoButtonColor = false
InstantTP.Parent = PremiumContent

local InstantTPCorner = Instance.new("UICorner")
InstantTPCorner.CornerRadius = UDim.new(0, 12)
InstantTPCorner.Parent = InstantTP

local InstantTPStroke = Instance.new("UIStroke")
InstantTPStroke.Color = Color3.fromRGB(0, 255, 127)
InstantTPStroke.Thickness = 1.5
InstantTPStroke.Transparency = 0.6
InstantTPStroke.Parent = InstantTP

local InstantTPIcon = Instance.new("TextLabel")
InstantTPIcon.Size = UDim2.new(0, 30, 0, 30)
InstantTPIcon.Position = UDim2.new(0, 15, 0.5, -15)
InstantTPIcon.BackgroundTransparency = 1
InstantTPIcon.Text = "⚡"
InstantTPIcon.TextScaled = true
InstantTPIcon.Font = Enum.Font.GothamBold
InstantTPIcon.Parent = InstantTP

local InstantTPLabel = Instance.new("TextLabel")
InstantTPLabel.Size = UDim2.new(1, -70, 0, 25)
InstantTPLabel.Position = UDim2.new(0, 55, 0, 10)
InstantTPLabel.BackgroundTransparency = 1
InstantTPLabel.Text = "INSTANT TP"
InstantTPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InstantTPLabel.TextSize = 16
InstantTPLabel.Font = Enum.Font.GothamBold
InstantTPLabel.TextXAlignment = Enum.TextXAlignment.Left
InstantTPLabel.Parent = InstantTP

-- ✅ CASE 2: AUTO-BLOCK FONCTIONNELLE
local AutoBlock = Instance.new("TextButton")
AutoBlock.Name = "AutoBlock"
AutoBlock.Size = UDim2.new(1, 0, 0, 55)
AutoBlock.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
AutoBlock.BorderSizePixel = 0
AutoBlock.Text = ""
AutoBlock.AutoButtonColor = false
AutoBlock.Parent = PremiumContent

local AutoBlockCorner = Instance.new("UICorner")
AutoBlockCorner.CornerRadius = UDim.new(0, 12)
AutoBlockCorner.Parent = AutoBlock

local AutoBlockStroke = Instance.new("UIStroke")
AutoBlockStroke.Color = Color3.fromRGB(0, 255, 127)
AutoBlockStroke.Thickness = 1.5
AutoBlockStroke.Transparency = 0.6
AutoBlockStroke.Parent = AutoBlock

local AutoBlockIcon = Instance.new("TextLabel")
AutoBlockIcon.Size = UDim2.new(0, 30, 0, 30)
AutoBlockIcon.Position = UDim2.new(0, 15, 0.5, -15)
AutoBlockIcon.BackgroundTransparency = 1
AutoBlockIcon.Text = "🛡️"
AutoBlockIcon.TextScaled = true
AutoBlockIcon.Font = Enum.Font.GothamBold
AutoBlockIcon.Parent = AutoBlock

local AutoBlockLabel = Instance.new("TextLabel")
AutoBlockLabel.Size = UDim2.new(1, -70, 0, 25)
AutoBlockLabel.Position = UDim2.new(0, 55, 0, 10)
AutoBlockLabel.BackgroundTransparency = 1
AutoBlockLabel.Text = "AUTO-BLOCK"
AutoBlockLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBlockLabel.TextSize = 16
AutoBlockLabel.Font = Enum.Font.GothamBold
AutoBlockLabel.TextXAlignment = Enum.TextXAlignment.Left
AutoBlockLabel.Parent = AutoBlock

-- ✅ CASE 3: NAMELESS FONCTIONNELLE
local Nameless = Instance.new("TextButton")
Nameless.Name = "Nameless"
Nameless.Size = UDim2.new(1, 0, 0, 55)
Nameless.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Nameless.BorderSizePixel = 0
Nameless.Text = ""
Nameless.AutoButtonColor = false
Nameless.Parent = PremiumContent

local NamelessCorner = Instance.new("UICorner")
NamelessCorner.CornerRadius = UDim.new(0, 12)
NamelessCorner.Parent = Nameless

local NamelessStroke = Instance.new("UIStroke")
NamelessStroke.Color = Color3.fromRGB(0, 255, 127)
NamelessStroke.Thickness = 1.5
NamelessStroke.Transparency = 0.6
NamelessStroke.Parent = Nameless

local NamelessIcon = Instance.new("TextLabel")
NamelessIcon.Size = UDim2.new(0, 30, 0, 30)
NamelessIcon.Position = UDim2.new(0, 15, 0.5, -15)
NamelessIcon.BackgroundTransparency = 1
NamelessIcon.Text = "👻"
NamelessIcon.TextScaled = true
NamelessIcon.Font = Enum.Font.GothamBold
NamelessIcon.Parent = Nameless

local NamelessLabel = Instance.new("TextLabel")
NamelessLabel.Size = UDim2.new(1, -70, 0, 25)
NamelessLabel.Position = UDim2.new(0, 55, 0, 10)
NamelessLabel.BackgroundTransparency = 1
NamelessLabel.Text = "NAMELESS"
NamelessLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NamelessLabel.TextSize = 16
NamelessLabel.Font = Enum.Font.GothamBold
NamelessLabel.TextXAlignment = Enum.TextXAlignment.Left
NamelessLabel.Parent = Nameless

-- Fonction pour changer d'onglet
local function switchTab(tab)
    PremiumStroke.Transparency = 0.8
    PremiumLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    PremiumTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    PremiumContent.Visible = false
    
    ESPStroke.Transparency = 0.8
    ESPLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    ESPTab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ESPContent.Visible = false
    
    if tab == "Premium" then
        PremiumStroke.Transparency = 0.2
        PremiumLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        PremiumTab.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        PremiumContent.Visible = true
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, PremiumContent.AbsoluteSize.Y + 20)
    elseif tab == "ESP" then
        ESPStroke.Transparency = 0.2
        ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        ESPTab.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
        ESPContent.Visible = true
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ESPContent.AbsoluteSize.Y + 20)
    end
end

-- Events des onglets
PremiumTab.MouseButton1Click:Connect(function()
    switchTab("Premium")
end)

ESPTab.MouseButton1Click:Connect(function()
    switchTab("ESP")
end)

switchTab("Premium")

-- 🎮 FONCTIONNALITÉS PREMIUM ACTIVES ✅

-- 1. INSTANT TP Toggle
InstantTP.MouseButton1Click:Connect(function()
    instantTPActive = not instantTPActive
    if instantTPActive then
        InstantTPLabel.Text = "INSTANT TP ✓"
        InstantTP.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        InstantTPStroke.Color = Color3.fromRGB(255, 255, 255)
        
        -- Système de TP avec clic droit
        mouse = player:GetMouse()
        mouse.Button2Down:Connect(function()
            if instantTPActive and humanoidRootPart then
                local target = mouse.Target
                if target and target.Parent:FindFirstChild("HumanoidRootPart") then
                    humanoidRootPart.CFrame = target.Parent.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
                end
            end
        end)
    else
        InstantTPLabel.Text = "INSTANT TP"
        InstantTP.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        InstantTPStroke.Color = Color3.fromRGB(0, 255, 127)
    end
end)

-- 2. AUTO-BLOCK Toggle
AutoBlock.MouseButton1Click:Connect(function()
    autoBlockActive = not autoBlockActive
    if autoBlockActive then
        AutoBlockLabel.Text = "AUTO-BLOCK ✓"
        AutoBlock.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        AutoBlockStroke.Color = Color3.fromRGB(255, 255, 255)
        
        spawn(function()
            while autoBlockActive do
                pcall(function()
                    for _, otherPlayer in pairs(Players:GetPlayers()) do
                        if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            humanoidRootPart.CFrame = otherPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-5,5), 0, math.random(-5,5))
                        end
                    end
                end)
                wait(0.1)
            end
        end)
    else
        AutoBlockLabel.Text = "AUTO-BLOCK"
        AutoBlock.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        AutoBlockStroke.Color = Color3.fromRGB(0, 255, 127)
    end
end)

-- 3. NAMELESS Toggle
Nameless.MouseButton1Click:Connect(function()
    namelessActive = not namelessActive
    if namelessActive then
        NamelessLabel.Text = "NAMELESS ✓"
        Nameless.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
        NamelessStroke.Color = Color3.fromRGB(255, 255, 255)
        
        -- Cache le nom du joueur
        pcall(function()
            if player.Character then
                for _, v in pairs(player.Character:GetChildren()) do
                    if v:IsA("BillboardGui") or v:IsA("BillboardGui") and v.Name == "NameGui" then
                        v.Enabled = false
                    end
                end
            end
        end)
        
        player.CharacterAdded:Connect(function(char)
            wait(1)
            pcall(function()
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BillboardGui") or v.Name == "NameGui" then
                        v.Enabled = false
                    end
                end
            end)
        end)
    else
        NamelessLabel.Text = "NAMELESS"
        Nameless.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        NamelessStroke.Color = Color3.fromRGB(0, 255, 127)
        
        pcall(function()
            if player.Character then
                for _, v in pairs(player.Character:GetChildren()) do
                    if v:IsA("BillboardGui") or v.Name == "NameGui" then
                        v.Enabled = true
                    end
                end
            end
        end)
    end
end)

-- Effets hover pour tous les boutons
local function addHoverEffect(button)
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(0, 200, 100) then
            TweenService:Create(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2), {Transparency = 0.2}):Play()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(0, 200, 100) then
            TweenService:Create(button:FindFirstChild("UIStroke"), TweenInfo.new(0.2), {Transparency = 0.6}):Play()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
        end
    end)
end

addHoverEffect(InstantTP)
addHoverEffect(AutoBlock)
addHoverEffect(Nameless)

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

-- Ajuster CanvasSize
ContentListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentListLayout.AbsoluteContentSize.Y + 20)
end)

-- Animation d'entrée
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1

wait(0.1)

TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 500, 0, 500),
    BackgroundTransparency = 0.05
}):Play()

print("⚡ SLAYZHUB v4.2 PREMIUM - AUTO-BLOCK • INSTANT TP • NAMELESS ✅")
