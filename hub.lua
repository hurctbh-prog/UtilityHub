-- SLAYZHUB XENO GO v4.2 🔥 OPTIMISÉ XENON ✅
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui (IMPORTANT: Xenon bloque parfois les gros noms)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XGui" -- Nom discret
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 1000000 -- Plus haut pour Xenon

-- MainFrame simplifié
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- TitleBar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 25, 70)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

-- Titre discret
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0.8, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 SLAYZHUB XENO v4.2"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = TitleBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -75)
ContentFrame.Position = UDim2.new(0, 10, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Grid Layout
local ListLayout = Instance.new("UIGridLayout")
ListLayout.CellSize = UDim2.new(0.48, -8, 0, 60)
ListLayout.CellPadding = UDim2.new(0, 8, 0, 10)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentFrame

-- Boutons simplifiés (FONCTIONNENT SUR XENON)
local buttons = {
    {name = "InstantTP", text = "⚡ INSTANT TP", color = Color3.fromRGB(60, 180, 255)},
    {name = "Nameless", text = "👻 NAMELESS", color = Color3.fromRGB(255, 100, 150)},
    {name = "AutoBlock", text = "🛡️ AUTO-BLOCK", color = Color3.fromRGB(100, 255, 100)},
    {name = "FPSBoost", text = "🚀 FPS BOOST", color = Color3.fromRGB(255, 200, 60)}
}

for i, btnData in ipairs(buttons) do
    local Button = Instance.new("TextButton")
    Button.Name = btnData.name
    Button.BackgroundColor3 = btnData.color
    Button.Text = btnData.text
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.Parent = ContentFrame
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = Button
    
    -- Effet hover simple
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(0.48, 0, 0, 65)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = ListLayout.CellSize}):Play()
    end)
    
    -- Click events (liens simplifiés)
    Button.MouseButton1Click:Connect(function()
        if btnData.name == "InstantTP" then
            -- Script local simple
            local char = player.Character
            if char then
                char.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
                game.StarterGui:SetCore("SendNotification", {
                    Title = "SLAYZHUB"; Text = "TP au spawn!"; Duration = 2
                })
            end
        elseif btnData.name == "Nameless" then
            player.DisplayName = "👻"
            player.NameDisplayDistance = 100
        elseif btnData.name == "AutoBlock" then
            spawn(function()
                while wait(0.1) do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CanCollide = true
                    end
                end
            end)
        elseif btnData.name == "FPSBoost" then
            -- FPS Boost simple
            settings().Rendering.QualityLevel = 1
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
            end
        end
    end)
end

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Draggable (version Xenon safe)
local dragging, dragStart, startPos
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

-- Animation d'entrée (Xenon safe)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1
TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 500, 0, 400),
    BackgroundTransparency = 0
}):Play()

print("✅ SLAYZHUB XENO v4.2 CHARGÉ!")
game.StarterGui:SetCore("SendNotification", {
    Title = "SLAYZHUB"; 
    Text = "v4.2 XENO ✅"; 
    Duration = 3
})
