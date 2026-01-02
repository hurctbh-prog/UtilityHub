-- 🔥 FPS TRAINER AIMBOT - AUTO AIM + CLICK
-- Vise les points ROUGES et clique automatiquement

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

-- ⚙️ CONFIGURATION
local AIMBOT_ENABLED = true
local AIM_SPEED = 0.15  -- Vitesse de visée (plus petit = plus rapide)
local CLICK_SPEED = 0.1  -- Vitesse de clic (plus petit = plus rapide)
local MAX_DISTANCE = 500 -- Distance max pour détecter les cibles
local FOV_RADIUS = 150   -- Rayon de détection (FOV)

-- Variables
local closestTarget = nil
local lastClick = 0

-- 🔍 FONCTION DETECTION POINTS ROUGES
local function findRedTargets()
    local targets = {}
    local closest = nil
    local shortestDistance = math.huge
    
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Détecte les points/particules ROUGES
        if obj:IsA("BasePart") or obj:IsA("MeshPart") then
            local color = obj.Color
            local size = obj.Size
            
            -- Critères pour points rouges (petits + rouge vif)
            if color and (color.R > 0.7 and color.G < 0.4 and color.B < 0.4) and 
               size.Magnitude < 5 then
                
                local screenPos, onScreen = camera:WorldToViewportPoint(obj.Position)
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                
                if onScreen and distance < MAX_DISTANCE and distance < shortestDistance then
                    closest = {
                        position = obj.Position,
                        screenPos = Vector2.new(screenPos.X, screenPos.Y),
                        distance = distance,
                        object = obj
                    }
                    shortestDistance = distance
                end
            end
        end
        
        -- Détecte aussi les attachments/particules rouges
        if obj:IsA("Attachment") then
            local parent = obj.Parent
            if parent and parent.Color and parent.Color.R > 0.7 then
                local screenPos, onScreen = camera:WorldToViewportPoint(obj.WorldPosition)
                local distance = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                
                if onScreen and distance < MAX_DISTANCE and distance < shortestDistance then
                    closest = {
                        position = obj.WorldPosition,
                        screenPos = Vector2.new(screenPos.X, screenPos.Y),
                        distance = distance,
                        object = obj
                    }
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closest
end

-- 🎯 FONCTION AIMBOT
local function aimAtTarget(target)
    if not target then return end
    
    local targetScreenPos = target.screenPos
    local currentMousePos = Vector2.new(mouse.X, mouse.Y)
    local delta = targetScreenPos - currentMousePos
    
    -- Mouvement fluide vers la cible
    local moveX = delta.X * (AIM_SPEED / 10)
    local moveY = delta.Y * (AIM_SPEED / 10)
    
    -- Déplace la souris
    mousemoverel(moveX, moveY)
end

-- 🔫 FONCTION AUTO-CLICK
local function autoClick()
    local currentTime = tick()
    if currentTime - lastClick > CLICK_SPEED and closestTarget then
        mouse1click()
        lastClick = currentTime
    end
end

-- 🖥️ INTERFACE SIMPLE (optionnelle)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FPSAimbot"
ScreenGui.Parent = player:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local InfoFrame = Instance.new("Frame")
InfoFrame.Size = UDim2.new(0, 250, 0, 120)
InfoFrame.Position = UDim2.new(0, 20, 0, 20)
InfoFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
InfoFrame.BackgroundTransparency = 0.1
InfoFrame.Parent = ScreenGui

local InfoCorner = Instance.new("UICorner")
InfoCorner.CornerRadius = UDim.new(0, 10)
InfoCorner.Parent = InfoFrame

local InfoStroke = Instance.new("UIStroke")
InfoStroke.Color = Color3.fromRGB(255, 0, 0)
InfoStroke.Thickness = 2
InfoStroke.Parent = InfoFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🔥 FPS TRAINER AIMBOT"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 16
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = InfoFrame

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Name = "StatusLabel"
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 35)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Searching..."
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = InfoFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(1, -20, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0, 70)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.Text = "🟥 AIMBOT OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 16
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Parent = InfoFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Toggle AIMBOT
ToggleButton.MouseButton1Click:Connect(function()
    AIMBOT_ENABLED = not AIMBOT_ENABLED
    if AIMBOT_ENABLED then
        ToggleButton.Text = "🟢 AIMBOT ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        StatusLabel.Text = "Status: ACTIVE"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "🟥 AIMBOT OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        StatusLabel.Text = "Status: DISABLED"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

-- Toggle avec F1
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F1 then
        ToggleButton.MouseButton1Click:Fire()
    end
end)

-- 🎮 LOOP PRINCIPAL AIMBOT
RunService.Heartbeat:Connect(function()
    if not AIMBOT_ENABLED then 
        closestTarget = nil
        return 
    end
    
    -- Trouve la cible la plus proche
    closestTarget = findRedTargets()
    
    -- Met à jour l'interface
    if closestTarget then
        StatusLabel.Text = "Target: " .. math.floor(closestTarget.distance) .. "px"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
        aimAtTarget(closestTarget)
        autoClick()
    else
        StatusLabel.Text = "Status: No red targets"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    end
end)

-- Indicateur FOV (cercle rouge autour de la souris)
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.NumSides = 30
fovCircle.Radius = FOV_RADIUS
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Transparency = 0.5
fovCircle.Filled = false
fovCircle.Visible = true

RunService.RenderStepped:Connect(function()
    if AIMBOT_ENABLED then
        fovCircle.Visible = true
        fovCircle.Position = Vector2.new(mouse.X, mouse.Y)
    else
        fovCircle.Visible = false
    end
end)

print("🔥 FPS TRAINER AIMBOT LOADED!")
print("F1 = Toggle | Vise les points ROUGES + Auto-Click")
