-- SLAYZHUB by [TON NOM] 🔥
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Créer ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Coins arrondis
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Gradient sombre
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- TITRE "SlayzHub" HAUT DROITE ✨
local Title = Instance.new("TextLabel")
Title.Name = "SlayzHubTitle"
Title.Size = UDim2.new(0, 120, 0, 40)
Title.Position = UDim2.new(1, -130, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "SlayzHub"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
Title.Parent = MainFrame

-- Barre de titre
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

-- Bouton fermer
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- List ScrollingFrame
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, -20, 1, -70)
ListFrame.Position = UDim2.new(0, 10, 0, 60)
ListFrame.BackgroundTransparency = 1
ListFrame.ScrollBarThickness = 6
ListFrame.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
ListFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 8)
ListLayout.Parent = ListFrame

-- Bouton 1: Nameless Hub
local Btn1 = Instance.new("TextButton")
Btn1.Name = "NamelessHub"
Btn1.Size = UDim2.new(1, -20, 0, 50)
Btn1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Btn1.Text = "🎮 Nameless Hub"
Btn1.TextColor3 = Color3.new(1,1,1)
Btn1.TextScaled = true
Btn1.Font = Enum.Font.GothamSemibold
Btn1.Parent = ListFrame

local Btn1Corner = Instance.new("UICorner")
Btn1Corner.CornerRadius = UDim.new(0, 8)
Btn1Corner.Parent = Btn1

-- Bouton 2: Instant Block
local Btn2 = Instance.new("TextButton")
Btn2.Name = "InstantBlock"
Btn2.Size = UDim2.new(1, -20, 0, 50)
Btn2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Btn2.Text = "🧱 Instant Block"
Btn2.TextColor3 = Color3.new(1,1,1)
Btn2.TextScaled = true
Btn2.Font = Enum.Font.GothamSemibold
Btn2.Parent = ListFrame

local Btn2Corner = Instance.new("UICorner")
Btn2Corner.CornerRadius = UDim.new(0, 8)
Btn2Corner.Parent = Btn2

-- Bouton 3: TP TO STEAL
local Btn3 = Instance.new("TextButton")
Btn3.Name = "TPToSteal"
Btn3.Size = UDim2.new(1, -20, 0, 50)
Btn3.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Btn3.Text = "💎 TP TO STEAL"
Btn3.TextColor3 = Color3.new(1,1,1)
Btn3.TextScaled = true
Btn3.Font = Enum.Font.GothamSemibold
Btn3.Parent = ListFrame

local Btn3Corner = Instance.new("UICorner")
Btn3Corner.CornerRadius = UDim.new(0, 8)
Btn3Corner.Parent = Btn3

-- Fonction drag
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

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Effet hover boutons
local function hoverEffect(btn)
    local tweenIn = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)})
    local tweenOut = TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)})
    
    btn.MouseEnter:Connect(function() tweenIn:Play() end)
    btn.MouseLeave:Connect(function() tweenOut:Play() end)
end

hoverEffect(Btn1)
hoverEffect(Btn2)
hoverEffect(Btn3)

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

hoverEffect(CloseButton)

-- LIENS DES SCRIPTS (remplace par tes vrais liens)
local SCRIPTS = {
    ["NamelessHub"] = "https://raw.githubusercontent.com/NamelessHub/main/loader.lua",
    ["InstantBlock"] = "https://raw.githubusercontent.com/InstantBlock/main/script.lua", 
    ["TPToSteal"] = "https://raw.githubusercontent.com/TPToSteal/main/teleport.lua"
}

-- Exécuter scripts
Btn1.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(SCRIPTS.NamelessHub))()
end)

Btn2.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(SCRIPTS.InstantBlock))()
end)

Btn3.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(SCRIPTS.TPToSteal))()
end)

-- Ajuster canvas size
ListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
end)

print("🎮 SlayzHub chargé !")
