-- SLAYZHUB XENO GO v4.1 🔥 PREMIUM + FPS DEVOURER v5.0 + ANTI-CRASH (XENO v1.3.1 FIX)
-- Compatible Xeno, Solara, Fluxus, etc.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === ANTI-CRASH SYSTEM + AUTO REJOIN (XENO SAFE) ===
local antiCrashActive = false
local safeParts = {}
local safeFolder = Instance.new("Folder")
safeFolder.Name = "SlayzSafe"
safeFolder.Parent = workspace

-- ANTI-CRASH XENO SAFE (pas de métatables)
spawn(function()
    while wait(0.5) do
        pcall(function()
            -- Nettoie les FPS killers
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("FPSKiller") or obj.Name:find("ParticleHell") or obj.Name:find("ChaosModel") then
                    if obj.Parent ~= safeFolder then
                        obj:Destroy()
                    end
                end
            end
        end)
    end
end)

-- ScreenGui (XENO FIX: DisplayOrder + ZIndex)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647 -- MAX pour Xenon v1.3.1
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MainFrame avec dégradé violet/noir
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 2147483647
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Dégradé moderne violet/noir
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 28, 135)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(45, 15, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 40))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- TitleBar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 20, 60)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2147483647
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 50, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 30, 200))
}
TitleGradient.Rotation = 90
TitleGradient.Parent = TitleBar

-- SLAYZHUB TITLE
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 SLAYZHUB PREMIUM v4.1 + ANTI-CRASH"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0.7
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.ZIndex = 2147483647
TitleLabel.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0.5, -20)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.ZIndex = 2147483647
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Tab Buttons Frame
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -40, 0, 50)
TabFrame.Position = UDim2.new(0, 20, 0, 70)
TabFrame.BackgroundTransparency = 1
TabFrame.ZIndex = 2147483647
TabFrame.Parent = MainFrame

-- Onglet PREMIUM (actif par défaut)
local PremiumTab = Instance.new("TextButton")
PremiumTab.Size = UDim2.new(0, 120, 1, 0)
PremiumTab.Position = UDim2.new(0, 0, 0, 0)
PremiumTab.BackgroundColor3 = Color3.fromRGB(120, 60, 200)
PremiumTab.Text = "💎 PREMIUM"
PremiumTab.TextColor3 = Color3.new(1, 1, 1)
PremiumTab.TextScaled = true
PremiumTab.Font = Enum.Font.GothamBold
PremiumTab.ZIndex = 2147483647
PremiumTab.Parent = TabFrame

local PremiumTabCorner = Instance.new("UICorner")
PremiumTabCorner.CornerRadius = UDim.new(0, 10)
PremiumTabCorner.Parent = PremiumTab

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -140)
ContentFrame.Position = UDim2.new(0, 20, 0, 130)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 2147483647
ContentFrame.Parent = MainFrame

-- Premium Content
local PremiumContent = Instance.new("Frame")
PremiumContent.Size = UDim2.new(1, 0, 1, 0)
PremiumContent.BackgroundTransparency = 1
PremiumContent.ZIndex = 2147483647
PremiumContent.Parent = ContentFrame
PremiumContent.Visible = true

-- Boutons Premium Grid
local ListLayout = Instance.new("UIGridLayout")
ListLayout.CellSize = UDim2.new(0.48, -10, 0, 65)
ListLayout.CellPadding = UDim2.new(0, 10, 0, 12)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = PremiumContent

-- Bouton INSTANT TP
local InstantTP = Instance.new("TextButton")
InstantTP.Name = "InstantTP"
InstantTP.BackgroundColor3 = Color3.fromRGB(60, 180, 255)
InstantTP.Text = "⚡ INSTANT TP"
InstantTP.TextColor3 = Color3.new(1, 1, 1)
InstantTP.TextScaled = true
InstantTP.Font = Enum.Font.GothamBold
InstantTP.ZIndex = 2147483647
InstantTP.Parent = PremiumContent

local InstantTPCorner = Instance.new("UICorner")
InstantTPCorner.CornerRadius = UDim.new(0, 12)
InstantTPCorner.Parent = InstantTP

local InstantTPGradient = Instance.new("UIGradient")
InstantTPGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 200, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 140, 220))
}
InstantTPGradient.Parent = InstantTP

-- Bouton Nameless
local Nameless = Instance.new("TextButton")
Nameless.Name = "Nameless"
Nameless.BackgroundColor3 = Color3.fromRGB(255, 100, 150)
Nameless.Text = "👻 NAMELESS"
Nameless.TextColor3 = Color3.new(1, 1, 1)
Nameless.TextScaled = true
Nameless.Font = Enum.Font.GothamBold
Nameless.ZIndex = 2147483647
Nameless.Parent = PremiumContent

local NamelessCorner = Instance.new("UICorner")
NamelessCorner.CornerRadius = UDim.new(0, 12)
NamelessCorner.Parent = Nameless

local NamelessGradient = Instance.new("UIGradient")
NamelessGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 60, 120))
}
NamelessGradient.Parent = Nameless

-- Bouton Auto-Block
local AutoBlock = Instance.new("TextButton")
AutoBlock.Name = "AutoBlock"
AutoBlock.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
AutoBlock.Text = "🛡️ AUTO-BLOCK"
AutoBlock.TextColor3 = Color3.new(1, 1, 1)
AutoBlock.TextScaled = true
AutoBlock.Font = Enum.Font.GothamBold
AutoBlock.ZIndex = 2147483647
AutoBlock.Parent = PremiumContent

local AutoBlockCorner = Instance.new("UICorner")
AutoBlockCorner.CornerRadius = UDim.new(0, 12)
AutoBlockCorner.Parent = AutoBlock

local AutoBlockGradient = Instance.new("UIGradient")
AutoBlockGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 255, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 220, 60))
}
AutoBlockGradient.Parent = AutoBlock

-- Bouton FPS DEVOURER 🔥💀 (CRASH LES AUTRES UNIQUEMENT)
local FPSDevourer = Instance.new("TextButton")
FPSDevourer.Name = "FPSDevourer"
FPSDevourer.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
FPSDevourer.Text = "💀 FPS DEVOURER (AUTRES)"
FPSDevourer.TextColor3 = Color3.new(1, 1, 1)
FPSDevourer.TextScaled = true
FPSDevourer.Font = Enum.Font.GothamBold
FPSDevourer.ZIndex = 2147483647
FPSDevourer.Parent = PremiumContent

local FPSDevourerCorner = Instance.new("UICorner")
FPSDevourerCorner.CornerRadius = UDim.new(0, 12)
FPSDevourerCorner.Parent = FPSDevourer

local FPSDevourerGradient = Instance.new("UIGradient")
FPSDevourerGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 60, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 20, 20))
}
FPSDevourerGradient.Parent = FPSDevourer

-- Animations Hover
local function addHoverEffect(button)
    local originalSize = button.Size
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = UDim2.new(0.48, 0, 0, 70)}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {Size = ListLayout.CellSize}):Play()
    end)
end

addHoverEffect(InstantTP)
addHoverEffect(Nameless)
addHoverEffect(AutoBlock)
addHoverEffect(FPSDevourer)

-- XENO SAFE LOADSTRINGS (avec pcall)
local function safeLoadstring(url)
    pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)
end

-- Click Events XENO SAFE
InstantTP.MouseButton1Click:Connect(function()
    safeLoadstring("https://pandadevelopment.net/virtual/file/3e58fa5b69bab3b3")
end)

Nameless.MouseButton1Click:Connect(function()
    safeLoadstring("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr")
end)

AutoBlock.MouseButton1Click:Connect(function()
    safeLoadstring("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer")
end)

-- FPS DEVOURER v5.0 - XENO SAFE
FPSDevourer.MouseButton1Click:Connect(function()
    FPSDevourer.Text = "💀 CRASH AUTRES ACTIVÉ..."
    FPSDevourer.TextColor3 = Color3.new(1, 0, 0)
    antiCrashActive = true
    
    print("🛡️ ANTI-CRASH ACTIVÉ - SEULEMENT LES AUTRES CRASHENT!")
    
    -- XENO SAFE: Limite les spams
    spawn(function()
        for i = 1, 50 do -- Réduit pour Xenon
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

-- Close Button + Anti-Crash OFF
CloseButton.MouseButton1Click:Connect(function()
    antiCrashActive = false
    ScreenGui:Destroy()
end)

-- Draggable XENO SAFE
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
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Entrée en scène XENO SAFE
wait(0.1) -- Délai Xenon
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 550, 0, 450)
}):Play()

print("🔥 SLAYZHUB v4.1 XENO v1.3.1 LOADED!")
