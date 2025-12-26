-- Lemon Freezer UI - LocalScript
-- Place dans StarterGui > ScreenGui > LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local Config = {
    StarterPower = 0.25,
    MainPower = 0.5,
    Duration = 0.5,
    StarterActive = false,
    MainActive = false,
    LagAfterSteal = false
}

-- Créer le ScreenGui principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LemonFreezerUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = playerGui

-- Frame principale
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 650, 0, 450)
mainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainBorder = Instance.new("UIStroke")
mainBorder.Color = Color3.fromRGB(255, 140, 0)
mainBorder.Thickness = 4
mainBorder.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, -20, 0, 50)
header.Position = UDim2.new(0, 10, 0, 10)
header.BackgroundTransparency = 1
header.Parent = mainFrame

local headerIcon = Instance.new("TextLabel")
headerIcon.Size = UDim2.new(0, 30, 0, 30)
headerIcon.Position = UDim2.new(0, 0, 0, 10)
headerIcon.BackgroundTransparency = 1
headerIcon.Text = "⚡"
headerIcon.TextSize = 28
headerIcon.TextColor3 = Color3.fromRGB(255, 140, 0)
headerIcon.Parent = header

local headerTitle = Instance.new("TextLabel")
headerTitle.Size = UDim2.new(1, -40, 1, 0)
headerTitle.Position = UDim2.new(0, 40, 0, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Text = "LEMON FREEZER - Dual Mode"
headerTitle.TextSize = 24
headerTitle.TextColor3 = Color3.fromRGB(255, 140, 0)
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextXAlignment = Enum.TextXAlignment.Left
headerTitle.Parent = header

-- Container pour les deux panels
local panelsContainer = Instance.new("Frame")
panelsContainer.Name = "PanelsContainer"
panelsContainer.Size = UDim2.new(1, -20, 0, 220)
panelsContainer.Position = UDim2.new(0, 10, 0, 70)
panelsContainer.BackgroundTransparency = 1
panelsContainer.Parent = mainFrame

-- STARTER LAG Panel (Gauche)
local starterPanel = Instance.new("Frame")
starterPanel.Name = "StarterPanel"
starterPanel.Size = UDim2.new(0.48, 0, 1, 0)
starterPanel.Position = UDim2.new(0, 0, 0, 0)
starterPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
starterPanel.BorderSizePixel = 0
starterPanel.Parent = panelsContainer

local starterCorner = Instance.new("UICorner")
starterCorner.CornerRadius = UDim.new(0, 8)
starterCorner.Parent = starterPanel

local starterBorder = Instance.new("UIStroke")
starterBorder.Color = Color3.fromRGB(0, 255, 0)
starterBorder.Thickness = 2
starterBorder.Parent = starterPanel

-- Starter Header
local starterHeader = Instance.new("TextLabel")
starterHeader.Size = UDim2.new(1, -20, 0, 30)
starterHeader.Position = UDim2.new(0, 10, 0, 10)
starterHeader.BackgroundTransparency = 1
starterHeader.Text = "⚡ STARTER LAG"
starterHeader.TextSize = 18
starterHeader.TextColor3 = Color3.fromRGB(100, 255, 100)
starterHeader.Font = Enum.Font.GothamBold
starterHeader.TextXAlignment = Enum.TextXAlignment.Left
starterHeader.Parent = starterPanel

-- Starter Power Label
local starterPowerLabel = Instance.new("TextLabel")
starterPowerLabel.Size = UDim2.new(1, -20, 0, 20)
starterPowerLabel.Position = UDim2.new(0, 10, 0, 45)
starterPowerLabel.BackgroundTransparency = 1
starterPowerLabel.Text = "Power (0.01-100):"
starterPowerLabel.TextSize = 14
starterPowerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
starterPowerLabel.Font = Enum.Font.Gotham
starterPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
starterPowerLabel.Parent = starterPanel

-- Starter Power Input
local starterPowerInput = Instance.new("TextBox")
starterPowerInput.Name = "PowerInput"
starterPowerInput.Size = UDim2.new(1, -20, 0, 35)
starterPowerInput.Position = UDim2.new(0, 10, 0, 70)
starterPowerInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
starterPowerInput.BorderSizePixel = 0
starterPowerInput.Text = tostring(Config.StarterPower)
starterPowerInput.TextSize = 20
starterPowerInput.TextColor3 = Color3.fromRGB(255, 200, 0)
starterPowerInput.Font = Enum.Font.GothamBold
starterPowerInput.PlaceholderText = "0.25"
starterPowerInput.Parent = starterPanel

local starterInputCorner = Instance.new("UICorner")
starterInputCorner.CornerRadius = UDim.new(0, 6)
starterInputCorner.Parent = starterPowerInput

-- Starter Activate Button
local starterActivateBtn = Instance.new("TextButton")
starterActivateBtn.Name = "ActivateButton"
starterActivateBtn.Size = UDim2.new(1, -20, 0, 35)
starterActivateBtn.Position = UDim2.new(0, 10, 0, 115)
starterActivateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
starterActivateBtn.BorderSizePixel = 0
starterActivateBtn.Text = "⚡ ACTIVATE"
starterActivateBtn.TextSize = 16
starterActivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
starterActivateBtn.Font = Enum.Font.GothamBold
starterActivateBtn.Parent = starterPanel

local starterBtnCorner = Instance.new("UICorner")
starterBtnCorner.CornerRadius = UDim.new(0, 6)
starterBtnCorner.Parent = starterActivateBtn

-- Starter TP Button
local starterTPBtn = Instance.new("TextButton")
starterTPBtn.Name = "TPButton"
starterTPBtn.Size = UDim2.new(1, -20, 0, 35)
starterTPBtn.Position = UDim2.new(0, 10, 0, 160)
starterTPBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
starterTPBtn.BorderSizePixel = 0
starterTPBtn.Text = "⚡ START + TP HIGHEST"
starterTPBtn.TextSize = 14
starterTPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
starterTPBtn.Font = Enum.Font.GothamBold
starterTPBtn.Parent = starterPanel

local starterTPCorner = Instance.new("UICorner")
starterTPCorner.CornerRadius = UDim.new(0, 6)
starterTPCorner.Parent = starterTPBtn

-- MAIN LAG Panel (Droite)
local mainPanel = Instance.new("Frame")
mainPanel.Name = "MainPanel"
mainPanel.Size = UDim2.new(0.48, 0, 1, 0)
mainPanel.Position = UDim2.new(0.52, 0, 0, 0)
mainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainPanel.BorderSizePixel = 0
mainPanel.Parent = panelsContainer

local mainPanelCorner = Instance.new("UICorner")
mainPanelCorner.CornerRadius = UDim.new(0, 8)
mainPanelCorner.Parent = mainPanel

local mainPanelBorder = Instance.new("UIStroke")
mainPanelBorder.Color = Color3.fromRGB(255, 80, 80)
mainPanelBorder.Thickness = 2
mainPanelBorder.Parent = mainPanel

-- Main Header
local mainHeader = Instance.new("TextLabel")
mainHeader.Size = UDim2.new(1, -20, 0, 30)
mainHeader.Position = UDim2.new(0, 10, 0, 10)
mainHeader.BackgroundTransparency = 1
mainHeader.Text = "🔥 MAIN LAG"
mainHeader.TextSize = 18
mainHeader.TextColor3 = Color3.fromRGB(255, 140, 0)
mainHeader.Font = Enum.Font.GothamBold
mainHeader.TextXAlignment = Enum.TextXAlignment.Left
mainHeader.Parent = mainPanel

-- Main Power Label
local mainPowerLabel = Instance.new("TextLabel")
mainPowerLabel.Size = UDim2.new(1, -20, 0, 20)
mainPowerLabel.Position = UDim2.new(0, 10, 0, 45)
mainPowerLabel.BackgroundTransparency = 1
mainPowerLabel.Text = "Power (0.01-100):"
mainPowerLabel.TextSize = 14
mainPowerLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
mainPowerLabel.Font = Enum.Font.Gotham
mainPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
mainPowerLabel.Parent = mainPanel

-- Main Power Input
local mainPowerInput = Instance.new("TextBox")
mainPowerInput.Name = "PowerInput"
mainPowerInput.Size = UDim2.new(1, -20, 0, 35)
mainPowerInput.Position = UDim2.new(0, 10, 0, 70)
mainPowerInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainPowerInput.BorderSizePixel = 0
mainPowerInput.Text = tostring(Config.MainPower)
mainPowerInput.TextSize = 20
mainPowerInput.TextColor3 = Color3.fromRGB(255, 200, 0)
mainPowerInput.Font = Enum.Font.GothamBold
mainPowerInput.PlaceholderText = "0.5"
mainPowerInput.Parent = mainPanel

local mainInputCorner = Instance.new("UICorner")
mainInputCorner.CornerRadius = UDim.new(0, 6)
mainInputCorner.Parent = mainPowerInput

-- Main Activate Button
local mainActivateBtn = Instance.new("TextButton")
mainActivateBtn.Name = "ActivateButton"
mainActivateBtn.Size = UDim2.new(1, -20, 0, 35)
mainActivateBtn.Position = UDim2.new(0, 10, 0, 115)
mainActivateBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
mainActivateBtn.BorderSizePixel = 0
mainActivateBtn.Text = "⚡ ACTIVATE"
mainActivateBtn.TextSize = 16
mainActivateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
mainActivateBtn.Font = Enum.Font.GothamBold
mainActivateBtn.Parent = mainPanel

local mainBtnCorner = Instance.new("UICorner")
mainBtnCorner.CornerRadius = UDim.new(0, 6)
mainBtnCorner.Parent = mainActivateBtn

-- Options Container
local optionsContainer = Instance.new("Frame")
optionsContainer.Size = UDim2.new(1, -20, 0, 35)
optionsContainer.Position = UDim2.new(0, 10, 0, 160)
optionsContainer.BackgroundTransparency = 1
optionsContainer.Parent = mainPanel

-- Lag After Steal
local lagAfterLabel = Instance.new("TextLabel")
lagAfterLabel.Size = UDim2.new(0.6, 0, 0, 15)
lagAfterLabel.Position = UDim2.new(0, 0, 0, 0)
lagAfterLabel.BackgroundTransparency = 1
lagAfterLabel.Text = "Lag After Steal:"
lagAfterLabel.TextSize = 12
lagAfterLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
lagAfterLabel.Font = Enum.Font.Gotham
lagAfterLabel.TextXAlignment = Enum.TextXAlignment.Left
lagAfterLabel.Parent = optionsContainer

local lagAfterBtn = Instance.new("TextButton")
lagAfterBtn.Name = "LagAfterButton"
lagAfterBtn.Size = UDim2.new(0.35, 0, 0, 20)
lagAfterBtn.Position = UDim2.new(0.65, 0, 0, -2)
lagAfterBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
lagAfterBtn.BorderSizePixel = 0
lagAfterBtn.Text = "OFF"
lagAfterBtn.TextSize = 12
lagAfterBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
lagAfterBtn.Font = Enum.Font.GothamBold
lagAfterBtn.Parent = optionsContainer

local lagAfterCorner = Instance.new("UICorner")
lagAfterCorner.CornerRadius = UDim.new(0, 4)
lagAfterCorner.Parent = lagAfterBtn

-- Duration
local durationLabel = Instance.new("TextLabel")
durationLabel.Size = UDim2.new(0.6, 0, 0, 15)
durationLabel.Position = UDim2.new(0, 0, 0, 20)
durationLabel.BackgroundTransparency = 1
durationLabel.Text = "Duration (sec):"
durationLabel.TextSize = 12
durationLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
durationLabel.Font = Enum.Font.Gotham
durationLabel.TextXAlignment = Enum.TextXAlignment.Left
durationLabel.Parent = optionsContainer

local durationInput = Instance.new("TextBox")
durationInput.Name = "DurationInput"
durationInput.Size = UDim2.new(0.35, 0, 0, 20)
durationInput.Position = UDim2.new(0.65, 0, 0, 18)
durationInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
durationInput.BorderSizePixel = 0
durationInput.Text = tostring(Config.Duration)
durationInput.TextSize = 12
durationInput.TextColor3 = Color3.fromRGB(255, 200, 0)
durationInput.Font = Enum.Font.GothamBold
durationInput.Parent = optionsContainer

local durationCorner = Instance.new("UICorner")
durationCorner.CornerRadius = UDim.new(0, 4)
durationCorner.Parent = durationInput

-- Bottom Buttons Container
local bottomButtons = Instance.new("Frame")
bottomButtons.Name = "BottomButtons"
bottomButtons.Size = UDim2.new(1, -20, 0, 40)
bottomButtons.Position = UDim2.new(0, 10, 0, 300)
bottomButtons.BackgroundTransparency = 1
bottomButtons.Parent = mainFrame

-- TP to Highest Button
local tpHighestBtn = Instance.new("TextButton")
tpHighestBtn.Size = UDim2.new(0.32, -5, 1, 0)
tpHighestBtn.Position = UDim2.new(0, 0, 0, 0)
tpHighestBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
tpHighestBtn.BorderSizePixel = 0
tpHighestBtn.Text = "⚡ TP TO HIGHEST"
tpHighestBtn.TextSize = 13
tpHighestBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpHighestBtn.Font = Enum.Font.GothamBold
tpHighestBtn.Parent = bottomButtons

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0, 6)
tpCorner.Parent = tpHighestBtn

-- Kick Self Button
local kickSelfBtn = Instance.new("TextButton")
kickSelfBtn.Size = UDim2.new(0.32, -5, 1, 0)
kickSelfBtn.Position = UDim2.new(0.34, 0, 0, 0)
kickSelfBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 200)
kickSelfBtn.BorderSizePixel = 0
kickSelfBtn.Text = "⚡ Kick Self"
kickSelfBtn.TextSize = 13
kickSelfBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
kickSelfBtn.Font = Enum.Font.GothamBold
kickSelfBtn.Parent = bottomButtons

local kickCorner = Instance.new("UICorner")
kickCorner.CornerRadius = UDim.new(0, 6)
kickCorner.Parent = kickSelfBtn

-- Stop All Button
local stopAllBtn = Instance.new("TextButton")
stopAllBtn.Size = UDim2.new(0.32, -5, 1, 0)
stopAllBtn.Position = UDim2.new(0.68, 0, 0, 0)
stopAllBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
stopAllBtn.BorderSizePixel = 0
stopAllBtn.Text = "⬛ STOP ALL"
stopAllBtn.TextSize = 13
stopAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopAllBtn.Font = Enum.Font.GothamBold
stopAllBtn.Parent = bottomButtons

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0, 6)
stopCorner.Parent = stopAllBtn

-- Floor Unlock Section
local floorSection = Instance.new("Frame")
floorSection.Name = "FloorSection"
floorSection.Size = UDim2.new(1, -20, 0, 90)
floorSection.Position = UDim2.new(0, 10, 0, 350)
floorSection.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
floorSection.BorderSizePixel = 0
floorSection.Parent = mainFrame

local floorCorner = Instance.new("UICorner")
floorCorner.CornerRadius = UDim.new(0, 8)
floorCorner.Parent = floorSection

local floorBorder = Instance.new("UIStroke")
floorBorder.Color = Color3.fromRGB(255, 140, 0)
floorBorder.Thickness = 2
floorBorder.Parent = floorSection

-- Floor Header
local floorHeader = Instance.new("TextLabel")
floorHeader.Size = UDim2.new(1, -20, 0, 25)
floorHeader.Position = UDim2.new(0, 10, 0, 10)
floorHeader.BackgroundTransparency = 1
floorHeader.Text = "🔓 UNLOCK FLOOR (on highest brainrot's base):"
floorHeader.TextSize = 13
floorHeader.TextColor3 = Color3.fromRGB(255, 180, 100)
floorHeader.Font = Enum.Font.GothamBold
floorHeader.TextXAlignment = Enum.TextXAlignment.Left
floorHeader.Parent = floorSection

-- Floor Buttons Container
local floorButtons = Instance.new("Frame")
floorButtons.Size = UDim2.new(1, -20, 0, 40)
floorButtons.Position = UDim2.new(0, 10, 0, 40)
floorButtons.BackgroundTransparency = 1
floorButtons.Parent = floorSection

for i = 1, 3 do
    local floorBtn = Instance.new("TextButton")
    floorBtn.Name = "Floor" .. i
    floorBtn.Size = UDim2.new(0.32, -5, 1, 0)
    floorBtn.Position = UDim2.new((i-1) * 0.34, 0, 0, 0)
    floorBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    floorBtn.BorderSizePixel = 0
    floorBtn.Text = "Floor " .. i
    floorBtn.TextSize = 14
    floorBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    floorBtn.Font = Enum.Font.GothamBold
    floorBtn.Parent = floorButtons
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = floorBtn
end

-- Fonctions de boutons
starterActivateBtn.MouseButton1Click:Connect(function()
    Config.StarterActive = not Config.StarterActive
    if Config.StarterActive then
        starterActivateBtn.Text = "⚡ DEACTIVATE"
        starterActivateBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        starterActivateBtn.Text = "⚡ ACTIVATE"
        starterActivateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    end
end)

mainActivateBtn.MouseButton1Click:Connect(function()
    Config.MainActive = not Config.MainActive
    if Config.MainActive then
        mainActivateBtn.Text = "⚡ DEACTIVATE"
        mainActivateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        mainActivateBtn.Text = "⚡ ACTIVATE"
        mainActivateBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end
end)

lagAfterBtn.MouseButton1Click:Connect(function()
    Config.LagAfterSteal = not Config.LagAfterSteal
    if Config.LagAfterSteal then
        lagAfterBtn.Text = "ON"
        lagAfterBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        lagAfterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    else
        lagAfterBtn.Text = "OFF"
        lagAfterBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        lagAfterBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    end
end)

stopAllBtn.MouseButton1Click:Connect(function()
    Config.StarterActive = false
    Config.MainActive = false
    starterActivateBtn.Text = "⚡ ACTIVATE"
    starterActivateBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    mainActivateBtn.Text = "⚡ ACTIVATE"
    mainActivateBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    print("All effects stopped")
end)

-- Rendre le frame draggable
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

print("Lemon Freezer UI Loaded!")
}):Play()

print("🔥 SLAYZHUB v4.2 LOADED - GREEN EDITION!")
