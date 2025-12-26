-- SLAYZHUB XENO GO COMPATIBLE v3.0 🔥
-- Compatible 100% Xeno, Solara, Fluxus, etc.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Anti-Dump léger (Xeno OK)
if getrawmetatable then
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if method == "Destroy" and tostring(self):find("SlayzHub") then
            return wait(math.huge)
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- MainFrame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(35, 35, 35))
}
UIGradient.Rotation = 45
UIGradient.Parent = MainFrame

-- SLAYZHUB TITLE HAUT DROITE 🔥
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "SlayzHubTitle"
TitleLabel.Size = UDim2.new(0, 120, 0, 40)
TitleLabel.Position = UDim2.new(1, -130, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SlayzHub"
TitleLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
TitleLabel.Parent = MainFrame

-- TitleBar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- ScrollingFrame
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -70)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 60)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollingFrame

-- SCRIPTS CONFIG (TES LIENS ICI)
local Scripts = {
    {
        Name = "NamelessHub",
        Text = "🎮 Nameless Hub",
        URL = "https://raw.githubusercontent.com/NamelessHub/main/loader.lua"
    },
    {
        Name = "InstantBlock", 
        Text = "🧱 Instant Block",
        URL = "https://raw.githubusercontent.com/InstantBlock/main/script.lua"
    },
    {
        Name = "TPToSteal",
        Text = "💎 TP TO STEAL", 
        URL = "https://raw.githubusercontent.com/TPToSteal/main/teleport.lua"
    }
}

-- Créer boutons
for i, scriptData in ipairs(Scripts) do
    local Button = Instance.new("TextButton")
    Button.Name = scriptData.Name
    Button.Size = UDim2.new(1, -20, 0, 50)
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
    
    -- Hover Effect
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
    end)
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
    end)
    
    -- Execute Script
    Button.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(game:HttpGet(scriptData.URL))()
        end)
    end)
end

-- DRAG SYSTEM (Xeno Compatible)
local dragging = false
local dragInput, mousePos, framePos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
end)

-- Auto Resize
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end)

-- Anti AFK (Xeno OK)
player.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("🎮 SlayzHub XENO COMPATIBLE chargé ! ✅")
