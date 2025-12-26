-- SLAYZHUB XENO GO v3.1 🔥 (FIXÉ POUR XENO)
-- Compatible Xeno, Solara, Fluxus, etc.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui (RESETONSPAWN = FALSE IMPORTANT POUR XENO)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- MainFrame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- TitleBar (POUR DRAG)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- SLAYZHUB TITLE
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 SLAYZHUB XENO GO"
TitleLabel.TextColor3 = Color3.fromRGB(255, 85, 85)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0.8
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Parent = TitleBar

-- Close Button (POSITION FIXÉE)
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -45, 0.5, -17.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = CloseButton

-- ScrollingFrame (POSITION FIXÉE)
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -75)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = ScrollingFrame

-- TES SCRIPTS ICI (LIENS VRAIS)
local Scripts = {
    {
        Name = "Infinite Yield",
        Text = "🎮 Infinite Yield (Admin)",
        URL = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
    },
    {
        Name = "Dark Dex",
        Text = "🔍 Dark Dex (Explorer)",
        URL = "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.txt"
    },
    {
        Name = "Hub Loader",
        Text = "📦 Universal Hub Loader",
        URL = "https://raw.githubusercontent.com/ic3w0lf22/Loader/main/Loader.lua"
    }
}

-- CRÉER BOUTONS (OPTIMISÉ XENO)
for i, scriptData in ipairs(Scripts) do
    local Button = Instance.new("TextButton")
    Button.Name = scriptData.Name
    Button.Size = UDim2.new(1, -20, 0, 45)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.Text = scriptData.Text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamSemibold
    Button.Parent = ScrollingFrame
    Button.LayoutOrder = i
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    -- HOVER (SIMPLIFIÉ XENO)
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    
    -- EXECUTE (SAFE XENO)
    Button.MouseButton1Click:Connect(function()
        local success, err = pcall(function()
            loadstring(game:HttpGet(scriptData.URL, true))()
        end)
        if not success then
            -- Notification simple si erreur
            local Notif = Instance.new("TextLabel")
            Notif.Size = UDim2.new(0, 200, 0, 30)
            Notif.Position = UDim2.new(0.5, -100, 0, 10)
            Notif.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
            Notif.Text = "❌ Erreur chargement"
            Notif.TextColor3 = Color3.new(1,1,1)
            Notif.TextScaled = true
            Notif.Parent = MainFrame
            game:GetService("Debris"):AddItem(Notif, 2)
        end
    end)
end

-- DRAG SYSTEM (XENO OPTIMISÉ)
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

-- CLOSE BUTTON
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(255, 65, 65)}):Play()
end)

-- AUTO RESIZE (XENO SAFE)
local function updateCanvas()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
end

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
updateCanvas()

print("🎮 SLAYZHUB XENO GO v3.1 ✅ CHARGÉ!")
